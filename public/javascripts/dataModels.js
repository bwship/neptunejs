(function() {
  Neptune.ForgotPassword = Ember.Object.extend({
    email: null,
    error: null
  });

  Neptune.Login = Ember.Object.extend({
    username: null,
    password: null,
    error: null
  });

  Neptune.Register = Ember.Object.extend({
    username: null,
    password: null,
    firstName: null,
    lastName: null,
    email: null,
    error: null
  });

  Neptune.User = Ember.Object.extend({
    objectId: null,
    userName: null,
    firstName: null,
    lastName: null
  });

  Neptune.EmailMessage = Ember.Object.extend({
    objectId: null,
    fromUser: null,
    toEmail: null,
    subject: null,
    body: null,
    init: function() {
      var fromUser;
      this._super();
      return fromUser = Neptune.User.create();
    }
  });

  Neptune.SmsMessage = Ember.Object.extend({
    objectId: null,
    fromUser: null,
    toPhoneNumber: null,
    message: null,
    init: function() {
      var fromUser;
      this._super();
      return fromUser = Neptune.User.create();
    }
  });

  Neptune.Error = Ember.Object.extend({
    code: null,
    severity: null,
    location: null,
    message: null
  });

}).call(this);
