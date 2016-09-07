# Description:
#  かしこいかわいい
#
# Commands:
#   かしこい - かわいい

module.exports = (robot) ->
	robot.hear /(?:賢|かしこ)い/i, (res) ->
		res.send "かわいい？"
	robot.hear /エリーチカ/i, (res) ->
		res.send "@#{res.message.user.name} ハラショー！"

  robot.adapter.client?.on? 'raw_message', (msg) ->
    return if msg.type isnt 'message' || msg.subtype isnt 'bot_message'
    match = msg.text.match(/(?:賢|かしこ)い/)
    return if match is null
    commit_user = match[1]
    channel = robot.adapter.client.getChannelByID msg.channel
    # プライベートチャンネルは取得出来ないためundefinedが返される
    return if channel is undefined
    text = "かわいい？"
    robot.send {room: "##{channel.name}"}, text

