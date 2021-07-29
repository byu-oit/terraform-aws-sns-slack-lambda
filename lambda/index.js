const https = require('https')
const URL = require('url').URL

exports.handler = function (event, context) {
  console.debug('Event: ' + JSON.stringify(event, null, 2))

  const webhookUrl = new URL(process.env.SLACK_WEBHOOK_URL)
  const requestPromises = []
  for (const record of event.Records) {
    requestPromises.push(_sendSlackMessage(record.Sns.Message, webhookUrl))
  }

  Promise.all(requestPromises).then(() => {
    console.info('All messages send successfully.')
  }).catch(e => {
    console.error(e)
    context.fail(e)
  })
}

function _sendSlackMessage (messageText, webhookUrl) {
  const data = JSON.stringify({
    text: messageText
  })

  const options = {
    hostname: webhookUrl.hostname,
    port: 443,
    path: webhookUrl.pathname,
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': data.length
    }
  }

  return new Promise((resolve, reject) => {
    if (process.env.SEND_TO_SLACK === 'false') resolve()

    const req = https.request(options, function (res) {
      if (res.statusCode >= 400) {
        reject(new Error(`[Slack API Error] ${res.statusCode} - ${res.statusMessage}`))
      } else {
        console.debug(`Sent message to Slack (code: ${res.statusCode}): ${messageText}`)
        resolve()
      }
    })

    req.on('error', (error) => {
      const errorMsg = `[HTTPS Error] ${error.name} - ${error.message}`
      console.error(errorMsg)
      reject(errorMsg)
    })

    req.write(data)
    req.end()
  })
}
