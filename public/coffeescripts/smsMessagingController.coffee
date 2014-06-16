Neptune.smsMessagingController = Ember.ArrayController.create(

  # load all sms messages sent be the user
  init: ->
    this.loadSmsMessages()

  # array of Neptune.SmsMessage objects
  content: []

  loadSmsMessages: ->
     Neptune.parseDataSource.getSmsMessages (messages, error) =>
      if (!error)
        @set 'content', messages

  sendSmsMessage: (message, callback) ->
    Neptune.parseDataSource.sendSmsMessage message, (message, error) =>
      if (!error)
        this.pushObject message

      callback(message, error)
)
