# Description:
#   Forward Jira comments to Slack.
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_JIRA_URL
#
# Commands:
#   None
#
# Author:
#   mnpk <mnncat@gmail.com>

module.exports = (robot) ->
  robot.router.post '/hubot/chat-jira-comment/:room', (req, res) ->
    room = req.params.room
    body = req.body
    if body.webhookEvent == 'jira:issue_updated' && body.comment
      issue = "#{body.issue.key} #{body.issue.fields.summary}"
      url = "#{process.env.HUBOT_JIRA_URL}/browse/#{body.issue.key}"
      content = body.comment.body.replace(/\[~([a-zA-Z0-9]+)\]/g,'@$1')
      robot.messageRoom room, "*#{issue}* _(#{url})_#{user}\n@#{body.comment.author.name}'s comment:\n```#{content}```"
    res.send 'OK'
