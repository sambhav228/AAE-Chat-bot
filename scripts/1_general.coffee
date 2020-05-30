# Description:
#   Handle Help Options
#   also: internet speed checks and critical system status
#
# Commands:
#   hubot 
#   hubot 
#
# Author:
#   Bren Sapience <brendan.sapience@gmail.com>

utils = require './utils'

module.exports = (robot) ->

  robot.respond /(get|show|create|generate)+[ ]+(my|the|all)*[ ]*(reports|sfdc reports|report|sfdc report)/i, (msg) ->
    msg.send "K, let me get that for you."
    UrlExt="/schedule/automations/deploy"
    #UrlExt="/authentication"

    jsondata = 
      {
        "taskRelativePath":"My Tasks\\Notepad Test.atmx", 
        "botRunners":
          [
            {
              "client":"WIN-3AUGDSPKS6K",
              "user":"runner"
            }
          ]
      }
    #postdata = JSON.parse(strdata)
    utils.apicall(UrlExt,jsondata,msg,robot,
      callback = (msg,jsonbody) ->
        jsonresp = JSON.parse(jsonbody)
        output = jsonresp['message']
        StrMsg = "Done:\n"
        StrMsg = StrMsg + "\t *#{output}*"
        msg.send StrMsg
    )