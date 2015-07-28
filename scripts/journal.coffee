# Description:
#   Journal
#
# Configuration:
#   None
#
# Commands:
#   hubot show me journal - gets Journal daily menu
#
# Author:
#   miretz

cheerio = require('cheerio')

menuRequest = (msg) ->

  url = 'https://www.zomato.com/sk/bratislava/journal-restaurant-ru%C5%BEinov-bratislava-ii/menu'
  
  msg.http(url).get() (err, res, body) ->
    $ = cheerio.load(body)
     
    menu = '*Journal Daily Menu*\n\n'
    
    $('div.tmi-group').each (i, element) -> 
      header = $(this).children("div.tmi-group-name")
      header_text = header.text().replace(/\s+/g, " ")
      header_text = header_text.trim()
      
      if header_text.indexOf("dnes") > -1
        menu = menu + "*#{header_text}*\n"

        $(this).children("div.tmi-daily").each (j, el2) ->
          if j isnt 0          
            text = $(this).text() || ""
            text = text.replace(/\s+/g, " ")
            text = text.trim()
            if text.indexOf("Hlavné jedlá") > -1 or text.indexOf("Špecialita dňa") > -1 or text.indexOf("Zeleninové jedlo") > -1
              text = "*#{text}*"
            text = text + "\n"
            menu += text
        menu += "\n\n"

    msg.send menu

module.exports = (robot) ->
  robot.respond /((show|fetch)( me )?)?journal/i, (msg) ->
    menuRequest(msg)
