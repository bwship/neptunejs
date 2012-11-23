Neptune.HomeView = Ember.View.extend(
  templateName: 'home'
)

Neptune.NavigationView = Ember.View.extend(

  init: ->
    this._super()
    if (this.isLoggedIn)
      @set "hideLogin", "hide"
      @set "hideLogout", ""
    else
      @set "hideLogin", ""
      @set "hideLogout", "hide"
    
  templateName: 'navigation'

  hideLogin: "",
  
  hideLogout: "hide",

  isLoggedInBinding: 'Neptune.accountController.isLoggedIn'

  isLoggedInDidChange: (->
    if (this.isLoggedIn)
      @set "hideLogin", ""
      @set "hideLogout", "hide"
    else
      @set "hideLogin", "hide"
      @set "hideLogout", ""
  ).observes('Neptune.accountController.isLoggedIn')

  login: null,

  forgotPassword: null,

  register: null,

  # sign a user in
  showSignIn: ->
    $(".error").removeClass "error"
    
    @set "login", Neptune.Login.create()
    
    $("#register").modal "hide"
    $("#forgotPassword").modal "hide"

    $("#signIn").modal "show"

  cancelSignIn: ->
    $("#signIn").modal "hide"

  signIn: ->
    Neptune.accountController.login this.login, (data, error) =>
      if (!error)
        $("#signIn").modal "hide"
      else
        $(".signin-group").addClass("error")
        @set "login.error", error.message

  # enter key pressed on the sign in page, call signIn
  signInTextField: Ember.TextField.extend(
    insertNewline: ->
      this.get('parentView').signIn()
  )

  # log a user out
  logout: ->
    Neptune.accountController.logout()
    Neptune.router.transitionTo('home', null)

  # register a user
  showRegister: ->
    $(".error").removeClass "error"
    
    @set "register", Neptune.Register.create()
    
    $("#signIn").modal "hide"
    $("#forgotPassword").modal "hide"

    $("#register").modal "show"

  cancelRegister: ->
    $("#register").modal "hide"

  registerUser: ->
    Neptune.accountController.register this.register, (data, error) =>
      if (!error)
        $("#register").modal "hide"
      else
        $(".register-group").addClass("error")
        @set "register.error", error.message

  # enter key pressed on the sign in page, call signIn
  registerTextField: Ember.TextField.extend(
    insertNewline: ->
      this.get('parentView').registerUser()
  )

  # forgot password
  showForgotPassword: ->
    $(".error").removeClass "error"

    @set "forgotPassword", Neptune.ForgotPassword.create()
    
    $("#signIn").modal "hide"
    $("#forgotPassword").modal "show"
  
  cancelForgotPassword: ->
    $("#forgotPassword").modal "hide"

  requestForgotPassword: ->
    Neptune.accountController.requestPasswordReset this.forgotPassword, (data, error) =>
      if (!error)
        $("#forgotPassword").modal "hide"
      else
        $(".forgot-password-group").addClass("error")
        @set "forgotPassword.error", error.message

  # show a user's inbox modal
  showInboxModal: ->
    $("#inboxModal").modal "show"
  
  # show the filter modal
  showFilter: ->
    $("#filter").modal "show"

  cancelFilter: ->
    $("#filter").modal "hide"

)

Neptune.MyProfileView = Ember.View.extend(

  templateName: 'my-profile'

  userBinding: 'Neptune.accountController.user'

  editUser: null

  showEdit: ->
    @set 'editUser', Neptune.User.create()
    @set 'editUser.firstName', @get 'user.firstName'
    @set 'editUser.lastName', @get 'user.lastName'    

    $('#editUser').modal 'show'

  cancelEdit: ->
    $('#editUser').modal 'hide'

  # enter key pressed on the sign in page, call signIn
  updateTextField: Ember.TextField.extend(
    insertNewline: ->
      this.get('parentView').updateUser()
  )

  updateUser: ->
    Neptune.accountController.updateUser this.editUser, (user, error) ->
      if (!error)
        $("#editUser").modal "hide"
      else
        alert 'Error updating user, please try again later.'

)

Neptune.EmailMessagingView = Ember.View.extend(
  
  templateName: 'email-messaging'

  # Array of Neptune.EmailMessage objects of previously sent emails
  contentBinding: 'Neptune.emailMessagingController.content'

  # Neptune.EmailMessage object used for adding a new email message
  emailMessage: null

  showSendMessage: ->
    @set 'emailMessage', Neptune.EmailMessage.create()

    $('#sendEmailMessage').modal 'show'

  cancelSendMessage: ->
    $('#sendEmailMessage').modal 'hide'

  sendMessage: ->
    Neptune.emailMessagingController.sendEmailMessage this.emailMessage, (data, error) ->
      if (!error)
        $('#sendEmailMessage').modal 'hide'

)

Neptune.SmsMessagingView = Ember.View.extend(

  templateName: 'sms-messaging'

    # Array of Neptune.SmsMessage objects of previously sent emails
  contentBinding: 'Neptune.smsMessagingController.content'

  # Neptune.SmsMessage object used for adding a new sms message
  smsMessage: null

  showSendMessage: ->
    @set 'smsMessage', Neptune.SmsMessage.create()

    $('#sendSmsMessage').modal 'show'

  cancelSendMessage: ->
    $('#sendSmsMessage').modal 'hide'

  sendMessage: ->
    Neptune.smsMessagingController.sendSmsMessage this.smsMessage, (data, error) ->
      if (!error)
        $('#sendSmsMessage').modal 'hide'
)