#!/bin/sh

set -e

npm install
export PATH="node_modules/.bin:node_modules/hubot/node_modules/.bin:$PATH"
token=`cat .slack_token`
export HUBOT_SLACK_TOKEN="$token"
echo "$HUBOT_SLACK_TOKEN"

exec node_modules/.bin/hubot --adapter slack --name "elichica" "$@"
