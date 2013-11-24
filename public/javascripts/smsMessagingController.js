(function() {
  Neptune.smsMessagingController = Ember.ArrayController.create({
    init: function() {
      this.loadSmsMessages();
      return this._super();
    },
    content: [],
    loadSmsMessages: function() {
      var _this = this;
      return Neptune.parseDataSource.getSmsMessages(function(messages, error) {
        if (!error) {
          return _this.set('content', messages);
        }
      });
    },
    sendSmsMessage: function(message, callback) {
      var _this = this;
      return Neptune.parseDataSource.sendSmsMessage(message, function(message, error) {
        if (!error) {
          _this.pushObject(message);
        }
        return callback(message, error);
      });
    }
  });

}).call(this);
