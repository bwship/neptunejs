window.Neptune = Ember.Application.create({

  ApplicationController: Ember.Controller.extend({
    debug: true
  }),

  ApplicationView: Ember.View.extend(
    templateName: 'application'
  ),

  Router: Ember.Router.extend(
    root: Ember.Route.extend({
      doHome: (router, event) ->
        router.transitionTo('home')

      doMyProfile: (router, event) ->
       router.transitionTo('myProfile')

      doEmailMessaging: (router, event) ->
        router.transitionTo('emailMessaging')

      doSmsMessaging: (router, event) ->
        router.transitionTo('smsMessaging')

      home: Ember.Route.extend({
        route: '/',
        connectOutlets: (router, event) ->
          router.get('applicationController').connectOutlet('home')
      }),

      myProfile: Ember.Route.extend({
        route: '/myProfile',
        connectOutlets: (router, event) ->
          if (Neptune.accountController.isLoggedIn)
            router.get('applicationController').connectOutlet('myProfile')
          else
            router.transitionTo('home')
      }), 

      emailMessaging: Ember.Route.extend({
        route: '/emailMessaging',
        connectOutlets: (router, event) ->
          if (Neptune.accountController.isLoggedIn)
            router.get('applicationController').connectOutlet('emailMessaging')
          else
            router.transitionTo('home')
      }), 

      smsMessaging: Ember.Route.extend({
        route: '/smsMessaging',
        connectOutlets: (router, event) ->
          if (Neptune.accountController.isLoggedIn)
            router.get('applicationController').connectOutlet('smsMessaging')
          else
            router.transitionTo('home')
      })
    }) 
  )
})

window.Neptune.initialize()
