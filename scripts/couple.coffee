# Description:
#  ラブライブのカップリング（適当）
#
# Commands:
#   花園 - 完全にランダムでCPを作成して発言

class Character

	constructor: ->
		@chara = ["ほの", "こと", "うみ", "にこ", "のぞ", "えり", "まき", "りん", "ぱな", "あり", "ゆき"]

	deleteCharacter = (index) ->
		@chara.splice(index, 1)

	randomInt = () ->
		Math.floor(Math.random() * @chara.length)

	getCharacter: ->
		num = randomInt.call @, null
		@chara[num]

	getCoupling: ->
		couple = []
		for i in [0..1]
			num = randomInt.call @, null
			couple.push(@chara[num])
			deleteCharacter.call @, num
		couple.join("")

class Eli
	before = [
		"そうね",
		"やっぱり",
		"それなら",
		"今日は"
	]
	after = [
		"なんてどうかしら",
		"がいいんじゃないかしら",
		"で語ってみましょう？",
		"が素敵だと思わない？"
	]
	randomInt = (mode) ->
		Math.floor(Math.random() * mode.length)

	getBefore: ->
		num = randomInt.call @, before
		before[num]

	getAfter: ->
		num = randomInt.call @, after
		after[num]

module.exports = (robot) ->
	robot.hear /花園/i, (res) ->
		character = new Character()
		eli = new Eli()
		res.send eli.getBefore() + "「" + character.getCoupling() + "」" + eli.getAfter()

