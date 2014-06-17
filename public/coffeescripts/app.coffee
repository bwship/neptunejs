window.Neptune = Ember.Application.create({
  ApplicationController: Ember.Controller.extend
    debug: true

  ApplicationView: Ember.View.extend
    templateName: 'application'
})

Neptune.Router.map ->
  this.route 'home', { path: "/" }
  this.route 'myProfile', { path: "/myProfile" }
  this.route 'emailMessaging', { path: "/emailMessaging" }
  this.route 'smsMessaging', { path: "/smsMessaging" }

Neptune.ApplicationRoute = Ember.Route.extend({
  actions:
    doHome: ->
      this.transitionTo('home')

    doMyProfile: ->
     this.transitionTo('myProfile')

    doEmailMessaging: ->
      this.transitionTo('emailMessaging')

    doSmsMessaging: ->
      this.transitionTo('smsMessaging')
})

Neptune.MyProfileRoute = Ember.Route.extend({
  beforeModel: ->
    if (Neptune.accountController.isLoggedIn)
      return true
    else
      this.transitionTo('home')
})

Neptune.EmailMessagingRoute = Ember.Route.extend({
  beforeModel: ->
    if (Neptune.accountController.isLoggedIn)
      return true
    else
      this.transitionTo('home')
})

Neptune.SmsMessagingRoute = Ember.Route.extend({
  beforeModel: ->
    if (Neptune.accountController.isLoggedIn)
      return true
    else
      this.transitionTo('home')
})
