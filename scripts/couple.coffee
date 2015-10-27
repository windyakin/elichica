# Description:
#  ラブライブのカップリング（適当）
#
# Commands:
#   花園 - 完全にランダムでCPを作成して発言

cheerio = require 'cheerio'
request = require 'request'
extend = require 'extend'
Q = require 'q'

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
		couple

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

class Pixiv

	constructor: (couple) ->
		@couple = couple
		@option = {
			url: 'http://www.pixiv.net/tags.php',
		}

	isNumber = (x) ->
		if typeof(x) != 'number' && typeof(x) != 'string'
			false
		else
			x == parseFloat(x) && isFinite(x);

	getCouplingNums = (couple) ->
		d = Q.defer()
		@option = extend(@option, {qs: {tag: couple}})
		request.get @option, (err, res) ->
			if !err && res.statusCode == 200
				$ = cheerio.load res.body
				nums = []
				$('.more').each ->
					elem = $ @
					text = elem.text()
					num = text.replace(/^[^\d]*(\d+) 件$/, "$1")
					num = parseInt(num, 10)
					if isNumber(num)
						nums.push(num)
				count = 0
				for num in nums
					count += num
				d.resolve count
			else
				d.reject err
		d.promise

	getCouplingAllNums: ->
		d = Q.defer()
		count = 0
		Q
			.when(getCouplingNums.call @, @couple.join(""))
			.then (val) ->
				count += val
			.fail (err) ->
				d.reject err
			.then(getCouplingNums.call @, @couple.reverse().join(""))
			.then (val) ->
				count += val
				d.resolve count
			.fail (err) ->
				d.reject err
		d.promise

module.exports = (robot) ->
	robot.hear /花園/i, (res) ->
		character = new Character()
		eli = new Eli()
		couple = character.getCoupling()
		couple_st = couple.join("")
		res.send eli.getBefore() + "「" + couple_st + "」" + eli.getAfter()
		pixiv = new Pixiv(couple)
		Q.when(pixiv.getCouplingAllNums())
			.then (val) ->
				res.send "ちなみにpixivで「" + couple_st + "」は" + val + "件の投稿があるみたいよ？"
			.fail (err) ->
				res.send "pixivからの取得は失敗ね…"


