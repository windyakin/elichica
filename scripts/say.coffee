module.exports = (robot) ->
	robot.respond /say \#([^ ]+) (.+)$/i, (res) ->
    command = res.match
    envelope = room: res.match[1]
    robot.send envelope, res.match[2]
