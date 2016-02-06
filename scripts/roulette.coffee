module.exports = (robot) ->
	robot.respond /roulette/i, (res) ->
    roulette = ['lovelive1', 'lovelive2', 'lovelive3', 'lovelive4']
    comment = ''
    for i in [0..3]
      num = Math.floor(Math.random() * 10 % 4, 10)
      comment += ':' + roulette[num] + ':'
    res.send "@#{res.message.user.name} "+ comment;
