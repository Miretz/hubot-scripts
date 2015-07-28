# Description:
#   Mlyn
#
#
# Configuration:
#   None
#
# Commands:
#   hubot show me mlyn - gets Mlyn daily menu
#
# Author:
#   miretz

menuRequest = (msg) ->
  mydate = new Date()
  datestring = ('0' + mydate.getDate()).slice(-2) + ('0' + (mydate.getMonth()+1)).slice(-2)
  msg.send "http://www.mlynrestaurant.com/images/dm" +  datestring + ".png" 

module.exports = (robot) ->
  robot.respond /((show|fetch)( me )?)?mlyn/i, (msg) ->
    menuRequest(msg)
