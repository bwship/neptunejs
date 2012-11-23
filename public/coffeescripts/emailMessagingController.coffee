Neptune.emailMessagingController = Ember.ArrayController.create(
  
  # load all email messages sent be the user 
  init: ->
    this.loadEmailMessages()
    this._super()

  # array of Neptune.EmailMessage objects
  content: []

  loadEmailMessages: ->
     Neptune.parseDataSource.getEmailMessages (messages, error) =>
     	if (!error)
        @set 'content', messages

  sendEmailMessage: (message, callback) ->
    Neptune.parseDataSource.sendEmailMessage message, (message, error) =>
      if (!error)
        this.pushObject message

      callback(message, error)
)