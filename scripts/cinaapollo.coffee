# Description:
#   Cina Apollo
#
#
# Configuration:
#   None
#
# Commands:
#   hubot show me cina apollo - gets Cina Apollo daily menu
#
# Author:
#   miretz

menuRequest = (msg) ->
  msg.send 'https://a.zmtcdn.com/data/menus/796/16507796/9b8389d2f9914a0658a0d56e4344d126.jpg'

module.exports = (robot) ->
  robot.respond /((show|fetch)( me )?)?cina apollo/i, (msg) ->
    menuRequest(msg)
