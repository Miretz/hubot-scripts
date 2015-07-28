# Description:
#   Dsl.sk
#
# Dependencies:
#   "htmlparser": "1.7.6"
#
# Configuration:
#   None
#
# Commands:
#   hubot show me dsl - gets the dsl feed
#
# Author:
#   miretz
cheerio = require "cheerio"
request = require "request"
Iconv  = require('iconv').Iconv

module.exports = (robot) ->
  robot.respond /((show|fetch)( me )?)?dsl/i, (msg) ->
    dslRss(msg)

dslRss = (msg) ->
  text = '*DSL.SK news*\n'

  options =
    url: 'http://www.dsl.sk'
    method: 'GET'
    encoding: null
    headers:
      'User-Agent': 'request'

  request(options, (err, resp, body) ->
    iconv = new Iconv('CP1250', 'UTF-8') 
    buffer = iconv.convert(body)
    $ = cheerio.load(buffer.toString('utf-8'))
    $('#news_box a').each (i, element) -> 
      if $(this).attr('href').indexOf("count") == -1
        text = text + $(this).text() + " - "
        text = text + "http://www.dsl.sk/" + $(this).attr('href') + "\n\n"
    msg.send text)

