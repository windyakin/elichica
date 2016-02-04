module.exports = (robot) ->
	robot.respond /say \#([^ ]+) (.+)$/i, (res) ->
    command = res.match
    envelope = room: command[1]
    robot.send envelope, command[2]
    sendDM 'windyakin', "@#{res.message.user.name} says to #{command[1]}\n#{command[2]}"

  sendDM = (userName, message) ->
  # userName は slack のユーザー名（@hoge の場合は "hoge"）
  # slack の userID を取得
  userId = robot.adapter.client.getUserByName(userName)?.id
  return unless userId?

  robot.adapter.client.openDM userId, (data) ->
    robot.send {room: userName}, message