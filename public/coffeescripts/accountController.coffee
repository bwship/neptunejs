Neptune.accountController = Ember.ArrayController.create(
  
  init: ->
    this.setUser()
    this._super()

  # helper property that is set when there is a user that is logged in
  isLoggedIn: false

  # the current user that is logged into the system
  # this can be user throughout the app to access the current user
  user: null
   
  # login - attempt to log a user into the parse system
  #   parameters
  #     username - the username for the user logging in
  #     password - the password for the user logging in
  #     callback - callback function to return the user and/or error
  #   returns
  #     success - Neptune.User object, null
  #     failure - null, Neptune.Error object 
  login: (login, callback) ->
    errorMessage = ''

    if (login.username == null || login.username.length == 0)
      errorMessage = 'Please enter your email address'
      
    if (login.password == null || login.password.length == 0)
      errorMessage = 'Please enter your password'
      
    if (errorMessage.length == 0)
      Neptune.parseDataSource.login login.username, login.password, (data, error) =>
        if (!error)
          this.setUser()
          callback(this.user, null)
        else
          callback(null, Neptune.parseDataSource.getError(-1, 'Email or password is incorrect', 'ERROR', 'Neptune.AccountController-login'))    
    else
      callback(null, Neptune.parseDataSource.getError(-1, errorMessage, 'ERROR', 'Neptune.AccountController-login'))    
  
  # logout - log the current user out of the system
  #   parameters - none
  #   returns - nothing
  logout: ->
    Neptune.parseDataSource.logout()
    this.setUser()
      
  # register - register a user into the system
  #   parameters 
  #     user - Neptune.User object of the person attempting to register
  #     callback - callback function to return the user and/or error
  #   returns
  #     success - objectId of the Parse User in the database, null
  #     failure - null, Neptune.Error object
  register: (register, callback) ->
    errorMessage = ''

    if (register.firstName == null || register.firstName.length == 0)
      errorMessage = 'Please specify a first name'
      
    if (register.lastName == null || register.lastName.length == 0)
      errorMessage =  'Please specify a last name'
          
    if (register.email == null || register.email.length == 0)
      errorMessage =  'Please specify an email address'
             
    if (register.password == null || register.password.length == 0)
      errorMessage =  'Please specify a password'
          
    if (errorMessage.length == 0)
      # register the user with in the system
      Neptune.parseDataSource.register register, (data, error) =>
        if (!error)
          # log the user into the system
          Neptune.parseDataSource.login register.email, register.password, (data, error) =>
            if (!error)
              callback(this.setUser(), null)      
            else
              callback(null, Neptune.parseDataSource.getError(error.code, error.message, 'ERROR', 'Neptune.AccountController-register'))
        else
          callback(null, Neptune.parseDataSource.getError(error.code, error.message, 'ERROR', 'Neptune.AccountController-register'))  
    else
      callback(null, Neptune.parseDataSource.getError(-1, errorMessage, 'ERROR', 'Neptune.AccountController-register'))

  # requestPasswordReset - send out a reset password email to the user
  #   parameters
  #     forgotPassword - Neptune.ForgotPassword object containing the email to send to
  #     callback - callback function to return the data and/or error
  #   returns
  #     success - null, null
  #     failure - null, Neptune.Error object
  requestPasswordReset: (forgotPassword, callback) ->
    Neptune.parseDataSource.requestPasswordReset forgotPassword.email, (data, error) ->
      callback(data, error)

  # updateUser - update a user's information in the system
  #   parameters
  #     user - Neptune.User object with new values
  #     callback - callback function to return the data and/or error
  #   returns
  #     success - updated Neptune.User object, null
  #     failure - null, Neptune.Error object
  updateUser: (user, callback) ->
    @set 'user.firstName', user.firstName
    @set 'user.lastName', user.lastName
    
    Neptune.parseDataSource.updateUser user, (data, error) =>
      this.setUser()
      callback(data, error)

  # setUser - helper function to set the current user in the controller
  # returns - Neptune.User object - the current user in the system
  setUser: ->
    @set 'user', Neptune.parseDataSource.getCurrentUser()
    @set 'isLoggedIn', (this.user?)
    return this.user
)