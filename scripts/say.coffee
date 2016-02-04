module.exports = (robot) ->
	robot.respond /say \#([^ ]+) (.+)$/i, (res) ->
    command = res.match
    robot.send {room: command[1]}, command[2]
    robot.send {room: 'elichica-log'}, "@#{res.message.user.name} says to #{command[1]}\n#{command[2]}"
