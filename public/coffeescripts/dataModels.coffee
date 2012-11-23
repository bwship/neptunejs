#################################################################################################################################
# Account Models
#################################################################################################################################
# forgot password modal model for a user forgetting their password
Neptune.ForgotPassword = Ember.Object.extend(
  email: null
  error: null
)

# login modal model for logging a user into parse
Neptune.Login = Ember.Object.extend(
  username: null
  password: null
  error: null
)

# register modal model for registering a user with parse
Neptune.Register = Ember.Object.extend(
  username: null
  password: null
  firstName: null
  lastName: null
  email: null
  error: null
)

# parse user model
Neptune.User = Ember.Object.extend(
  objectId: null
  userName: null
  firstName: null
  lastName: null
)

#################################################################################################################################
# Messaging Models
#################################################################################################################################
Neptune.EmailMessage = Ember.Object.extend(
  objectId: null
  fromUser: null
  toEmail: null
  subject: null
  body: null
  init: ->
    this._super()
    fromUser = Neptune.User.create()
)

Neptune.SmsMessage = Ember.Object.extend(
  objectId: null
  fromUser: null
  toPhoneNumber: null
  message: null
  init: ->
    this._super()
    fromUser = Neptune.User.create()
)

#################################################################################################################################
# Error Models
#################################################################################################################################
Neptune.Error = Ember.Object.extend(
  code: null
  severity: null
  location: null
  message: null
)