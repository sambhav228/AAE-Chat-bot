request = require 'request'
http = require 'http'
fs = require 'fs'

CTRLROOMURL = process.env.CTRLROOMURL
CTRLROOMLOGIN = process.env.CTRLROOMLOGIN
CTRLROOMPWD = process.env.CTRLROOMPWD
CTRLROOMAUTHURL = process.env.CTRLROOMAUTHURL

URLBASE = CTRLROOMURL+"/v1"


# 

module.exports.apicall = (urlext,postdata,msg,robot,processbody) ->

  authurl = "#{URLBASE}#{CTRLROOMAUTHURL}"
  request.post {
    headers: {'content-type' : 'application/json'},
    uri: authurl,
    body: {
      'Username' : CTRLROOMLOGIN,
      'Password': CTRLROOMPWD
    },
    json : true,
    rejectUnauthorized: false
  }, (err, r, body) ->
      if body
        Token = body["token"]
        ID = body["user"]["id"]
        Email = body["user"]["email"]
        #strbody=JSON.stringify(body)   

        url = "#{URLBASE}#{urlext}"
        request.post {
          headers: {'X-Authorization' : Token},
          uri: url,
          body: postdata,
          json : true,
          rejectUnauthorized: false
        }, (err, r, body) ->
          if body
            strbody=JSON.stringify(body)
            processbody(msg,strbody)

# 
module.exports.authenticate1 = (urlext,login,password,msg,robot,processbody) ->

  authurl = "#{URLBASE}#{CTRLROOMAUTHURL}"
  request.post {
    headers: {'content-type' : 'application/json'},
    uri: authurl,
    body: {
      'Username' : login,
      'Password': password
    },
    json : true,
    rejectUnauthorized: false
  }, (err, r, body) ->
      if body
        Token = body["token"]
        ID = body["user"]["id"]
        Email = body["user"]["email"]
        #strbody=JSON.stringify(body)   

        url = "#{URLBASE}#{urlext}"
        request.post {
          headers: {'X-Authorization' : Token},
          uri: url,
          body: {
            'taskRelativePath':'My Tasks\\Notepad Test.atmx', 
            'botRunners':
              [
                {
                'client':'WIN-3AUGDSPKS6K', 
                'user':'runner'
                }
              ]
          },
          json : true,
          rejectUnauthorized: false
        }, (err, r, body) ->
          if body
            strbody=JSON.stringify(body)
            processbody(msg,strbody)


module.exports.sleep = (ms) ->
  start = new Date().getTime()
  continue while new Date().getTime() - start < ms

# Converts EPOCH time to readable human time
module.exports.convertEpochToSpecificTimezone = (edate,offset) ->
  
  date = new Date(edate*1000);
  Year = date.getFullYear();
  Month = date.getMonth()+1;
  if Month < 10
    Month = "0"+Month
  Day = date.getDate();
  if Day < 10
    Day = "0"+Day
  hours = date.getHours();
  minutes = "0" + date.getMinutes();
  seconds = "0" + date.getSeconds();

  formattedTime = Year+ '-' +Month+'-'+Day+' ' +hours + ':' + minutes.substr(-2) + ':' + seconds.substr(-2);
  return formattedTime;

