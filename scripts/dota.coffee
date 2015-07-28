# Description:
#   Dota heroes wiki entry
#
# Commands:
#   hubot dota <hero> - returns info about dota hero
#
# Author:
#   miretz
cheerio = require('cheerio')

capitalize = (str) ->
  result = ""
  for word, i in str.split(" ")
  	if i isnt 0
  	  result += " "
    if word not in ['of', 'the']
      result += word[0].toUpperCase() + word.slice(1)
    else
      result += word
  console.log result
  return result

getHeroInfo = (res) ->
  hero_name = capitalize(res.match[1])
  hero_name_url = hero_name.replace(/\ /g, "_")
  
  url = "http://www.dota2.com/hero/#{hero_name_url}"
  console.log url

  res.http(url).get() (err, resp, body) ->
    if resp.statusCode isnt 200
      res.send "Sorry, this hero was not found!"
      return

    $ = cheerio.load(body)
    
    response = "*#{hero_name}*\n"
    response += $("#heroTopPortraitIMG").attr('src') + "\n"
    response += $("#heroBioRoles").text() + "\n\n"
    response += "*Abilities*\n\n"

    $("#overviewHeroAbilities div.overviewAbilityRowDescription").each (i, element) ->
    	response += "*#{i + 1}. " + $(this).children('h2').text() + "*\n"
    	response += $(this).children('p').text().replace(/\s+/g, " ") + "\n"

    response += "\n#{url}"

    res.send response



module.exports = (robot) ->
  robot.hear /^dota (.*)$/i, (res) ->
    getHeroInfo(res)
