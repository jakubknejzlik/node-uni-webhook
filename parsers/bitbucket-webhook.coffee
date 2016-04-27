moment = require('moment')

module.exports = (req)->
  if req.headers['user-agent'] isnt 'Bitbucket-Webhooks/2.0'
    return no

  req.payload = {commits: []}
  if req.body.push and req.body.push.changes
    for change in req.body.push.changes
      if change.new.target.type == 'commit' and change.new.type == 'branch'
        req.payload.commits.push(
          hash: change.new.target.hash
          message: change.new.target.message
          date: moment(change.new.target.date).toISOString()
          branch: change.new.name
        )
  return yes
