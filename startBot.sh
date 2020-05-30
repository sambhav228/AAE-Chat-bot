#!/bin/sh
forever start -w -a -c /bin/sh ./bin/hubot --adapter slack --require scripts/envs/$HUBOT_ENVIRONMENT
