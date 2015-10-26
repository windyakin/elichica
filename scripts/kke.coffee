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


