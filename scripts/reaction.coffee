# Description
#   SlackのEmoji Reactionを付与
#
# Configuration:
#   HUBOT_SLACK_TOKEN

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