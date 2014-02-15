(function() {
  Neptune.emailMessagingController = Ember.ArrayController.create({
    init: function() {
      this.loadEmailMessages();
      return this._super();
    },
    content: [],
    loadEmailMessages: function() {
      var _this = this;
      return Neptune.parseDataSource.getEmailMessages(function(messages, error) {
        if (!error) {
          return _this.set('content', messages);
        }
      });
    },
    sendEmailMessage: function(message, callback) {
      var _this = this;
      return Neptune.parseDataSource.sendEmailMessage(message, function(message, error) {
        if (!error) {
          _this.pushObject(message);
        }
        return callback(message, error);
      });
    }
  });

}).call(this);
