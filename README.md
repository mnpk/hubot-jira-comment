# hubot-jira-comment
[Slack](https://slack.com/)'s [Jira](https://www.atlassian.com/software/jira) integration does not support for **comments**, yet.

But, [Hubot](https://hubot.github.com/) can do that for you :)

[![npm](https://img.shields.io/npm/v/hubot-jira-comment.svg?style=flat-square)]()

## Example

![](https://raw.githubusercontent.com/mnpk/hubot-jira-spy/master/jira-spy-example.png)

## Install & Configuration

### 1. Hubot Settings

##### 1.1 install with npm

Install this package with npm in your hubot path.
```
$ cd your_hubot_path
$ npm install hubot-jira-comment --save
```

##### 1.2 Add to external-scripts list

Add this package to external-scripts list.

```
$ echo '["hubot-jira-comment"]' > external-scripts.json
```
Now your hubot will load this package when it starts.

##### 1.3 Set environment variables

Hubot already includes support for the express web framework to serve up HTTP requests.
([explained at hubot's scripting.md](https://github.com/github/hubot/blob/master/docs/scripting.md#http-listener))

It listens on the port specified by the `EXPRESS_PORT` or `PORT` environment veriables and defaults to 8080.

```
$ export PORT=9009
```

To generate links back to jira, you need `HUBOT_JIRA_URL` environment variable 
```
$ export HUBOT_JIRA_URL="http://172.16.45.12/jira"
```

##### 1.4 Run & Test

Now hubot is ready. 

Start your hubot, and it will start to listen on `/hubot/chat-jira-comment/:room` on 9009 port.

Let's test by sending a `POST` request to `/hubot/chat-jira-comment/:room` path with jira webhook JSON data, using `curl`.

There's a sample Jira Webhook Post message on [atlassian webpage](https://developer.atlassian.com/jiradev/jira-architecture/webhooks), but that's too long, so let's test with a simpler json data.

```
$ curl \
-X POST \
-H "Content-Type: application/json" \
-d \
'{
 "webhookEvent":"jira:issue_updated",
 "comment":{
   "author":{
     "name":"mnpk"
    },
    "body":"hello,hubot-jira-comment"
 },
 "issue": {
   "key":"key",
   "fields":{
     "summary":"summary"
    }
  }
}' \
http://localhost:9009/hubot/chat-jira-comment/general
```

If you ran hubot using slack-adapter, you will receive a message from Hubot on `#general` channel.

If you ran hubot using shell-adapter, you will receive a message like below on your console.
```
hubot> *key summary* _(http://172.16.45.12/jira/browse/key)_
@mnpk's comment:
```hello,hubot-jira-comment```
```


### 2. Jira Settings

##### 2.1 Add a webhook

You can add an webhook on `Setting > System > Advanced > WebHooks` menu.

(The page URL looks like `http://<your_jira_path>/plugins/servlet/webhooks`)

Create new webhook by click on `Create a WebHook` button.

URL is `http://<your-hubot-listener>:<port>/hubot/chat-jira-comment/<room>` with your hubot address, port, room.
(e.g. If your hubot's address is 172.16.45.12, your hubot's `PORT` is 9009, your chat room name is #general, than the URL will be `http://172.16.45.12:9009/hubot/chat-jira-comment/general`)

Make sure to check on `Issue > update` checkbox.

Click `Create` button, and...  that's all.
