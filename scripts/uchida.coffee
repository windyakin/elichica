# Description:
#  ○○やだ〜 うちだあや〜
#
# Commands:
#   やだ

require('./reaction.coffee')

uchida = [
  'http://66.media.tumblr.com/2161a8f33e2704d13020ea24028d4d16/tumblr_o9e08tS4y41us17wro1_250.jpg'
  'http://67.media.tumblr.com/ff49c60addd69c7aa083818b72ff0039/tumblr_o9e08tS4y41us17wro3_500.jpg'
  'http://66.media.tumblr.com/a7a9438de2b67b9b7497e888c1d1720b/tumblr_inline_o999q1RC0b1trbfau_400.png'
  'http://66.media.tumblr.com/497f54f201d579ae86bfff8e63e16e36/tumblr_o7w3ogX9Xs1us17wro2_r1_250.png'
  'http://66.media.tumblr.com/f5cad5bf99e2fb114e7eea6670006a7a/tumblr_o7w3ogX9Xs1us17wro5_r1_250.png'
  'http://65.media.tumblr.com/d057bc68510261236c7dd547a5839356/tumblr_o7ml8o2sRM1us17wro1_500.jpg'
  'http://66.media.tumblr.com/1f9bc6f10b5a1a8de46d0eaf470d3b9f/tumblr_o64ky7Wl8g1us17wro1_250.jpg'
  'http://65.media.tumblr.com/ce8b4c602cc278afa36a0768a65464e6/tumblr_o5b1dbfULX1us17wro9_250.jpg'
  'http://65.media.tumblr.com/0fac23ffd5d36ebd0e844159484c1166/tumblr_o57kchXGMf1us17wro1_250.png'
]

module.exports = (robot) ->
	robot.hear /(?:やだ|ヤダ)/i, (res) ->
		res.send res.random uchida

  robot.hear /(?:内田|うちだ) ?(?:彩|あや)/i, (res) ->
    addReactions(res, 'uchida')

  addReactions = (msg, name) ->
    options = {
      url: 'https://slack.com/api/reactions.add'
      qs: {
        'token': process.env.HUBOT_SLACK_TOKEN
        'name': name
        'channel': msg.message.rawMessage.channel
        'timestamp': msg.message.rawMessage.ts
      }
    }
    request.post options, (err, res, body) ->
      if err? or res.statusCode isnt 200
        robot.logger.error("Failed to add emoji reaction #{JSON.stringify(err)}")