twilio = require('twilio')
twilio.initialize('YOUR_TWILIO_ID', 'YOUR_TWILIO_KEY')

mailgun = require('mailgun');
mailgun.initialize('YOUR_MAILGUN_ID', 'YOUR_MAILGUN_KEY');

# EmailMessage Collection beforeSave event
#   purpose - send out an email
Parse.Cloud.afterSave "EmailMessage", (request, response) ->
  toEmail = request.object.get("toEmail")
  subject = request.object.get("subject")
  body = request.object.get("body")

  mailgun.sendEmail
    to: toEmail
    from: "Mailgun@CloudCode.com"
    subject: subject
    text: body
  ,
    success: (httpResponse) ->
      console.log httpResponse
      response.success "Email sent!"
    error: (httpResponse) ->
      console.error httpResponse
      response.error "ERROR - " + httpResponse

# SmsMessage Collection beforeSave event
#   purpose - send out an email
Parse.Cloud.afterSave "SmsMessage", (request, response) ->
  toPhoneNumber = request.object.get("toPhoneNumber")
  message = request.object.get("message")

  twilio.sendSMS
      From: "+17172301040"
      To: toPhoneNumber
      Body: message
    ,
      success: (httpResponse) ->
        console.log httpResponse
        response.success "SMS sent!"
      error: (httpResponse) ->
        console.error httpResponse
        response.error "ERROR - " + httpResponse
