# ErrorLog Collection beforeSave event
#   purpose - validate that the severity level is ERROR, WARNING, or INFO
#             and if it isn't then set it to ERROR
Parse.Cloud.beforeSave "ErrorLog", (request, response) ->
  severity = request.object.get("severity")
  
  # set the severity to ERROR if a correct severity wasn't passed in
  request.object.set "severity", "ERROR"  if severity isnt "ERROR" and severity isnt "WARNING" and severity isnt "INFO"
  response.success()
