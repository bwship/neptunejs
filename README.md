Neptune - Node-Ember-Parse all in Tune
=========

This is a baseline project meant to provide a solid foundation to build upon the Node/Ember/Parse stack.  It provides the following pieces of functionality. (It also uses coffeescript, twitter bootstrap, twilio, and mailgun, handlebars.js, jquery and jade)

- out of the box login/logout/register capabilities using Parse as the data source
- a full implementation of Ember meant to provide a robust framework with which you can then integrate many other pieces of functionality
- dataSources, by abstracting ember out to have a datasources file, you can easily house all api calls from one location, this makes your controller and views highly testable, as the only models that any ember object knows about besides the datasources file is the Ember objects declared in the dataMOdels.coffee file
- cloud code - cloud code is implemented to be a foundation for what can be built with cloud code.  It is only currently using beforeSave and afterSave triggers, but can very easily be made to have endpoints

Why use it?
=========
The stack of Node for the server, Ember for client-side MVC, and Parse for the backend provides a complete end to end solution that is great for both web and mobile web.  Within minutes, using this project, you can have a website up and running that has login/registering/forgot password, the whole account structure.  I want to expand this out a bit more, providing more functionality, but in it's current format, it is a great building block for any kind of Web App. 

Installation
=========

1. Install Node.js from nodejs.org
2. Install the Parse command line utility by running the curl command show on https://parse.com/docs/cloud_code_guide 
3. Clone or fork this repo
4. Obtain free keys for Parse, Twilio, and Mailgun to use all the pieces of functionality, though if you want to leave out cloud code, you can jsut set it up to use Parse
5. Update the following files with your keys
    - /cloud_code/config/global.json - update the applicationId and masterKey with the information from your Parse project (these are used for cloud code to talk to parse)
    - /public/coffeescripts/dataSources.coffee - update the   parseApplicationId and parseJavaScriptKey properties in this file (these are used for your ember code to talk to parse)
    - /cloud_code/cloud/messaging.coffee - update the keys for the twilio and mailgun object

Setting up cloud code
=========

- from terminal in the root directory do the following commands
  
  cd cloud_code
  parse deploy

  this will deploy the cloud code with your keys to parse

Running the site
=========

- from terminal in the root do the following command

  node app

Viewing the Site
=========

- open your browser and go to localhost:3002 or whatever you set the port to in the app.coffee file

