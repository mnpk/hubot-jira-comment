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
    match = /^comment/.test(body.webhookEvent)
    if match && body.comment
      issue = "#{body.issue.key} #{body.issue.fields.summary}"
      url = "#{process.env.HUBOT_JIRA_URL}/browse/#{body.issue.key}"
      content = body.comment.body.replace(/\[~([a-zA-Z0-9]+)\]/g,'@$1')
      assignee = body.issue?.fields?.assignee?.name
      cc = if assignee then ' (cc @' + assignee + ')' else ''
      robot.messageRoom room, "*#{issue}* _(#{url})_\n> @#{body.comment.author.name}'s comment#{cc}:\n> #{content}"
    res.send 'OK'
