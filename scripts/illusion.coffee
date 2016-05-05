# Description:
#  錯覚…？
#
# Commands:
#   錯覚 - 錯覚…？

module.exports = (robot) ->
	robot.hear /錯覚/i, (res) ->
		res.send "ん…？錯覚…？"
		res.send "それでは聴いてください… 錯覚CROSSREADS"


