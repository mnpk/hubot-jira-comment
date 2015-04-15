# hubot-jira-comment
[Slack](https://slack.com/)'s [Jira](https://www.atlassian.com/software/jira) integration does not support for **comments**, yet.
[Hubot](https://hubot.github.com/) can do that for you :)



## Example

![](https://raw.githubusercontent.com/mnpk/hubot-jira-spy/master/jira-spy-example.png)

## Jira Settings
Add an WebHook on Setting > WebHooks menu.

Hook URL is `http://your-hubot-listener/hubot/chat-jira-comment/:room`

Make sure the `Issue Update` Events can be post.

## Hubot Settings
Add this script to your hubot-slack.

