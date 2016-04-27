moment = require('moment')

module.exports = (req)->
  if req.headers['user-agent'] isnt 'Bitbucket.org'
    return no

  if not req.body.payload
    return no
  data = JSON.parse(req.body.payload)
  req.payload = {commits: []}
  if data.commits
    for commit in data.commits
      req.payload.commits.push(
        hash: commit.raw_node
        message: commit.message
        date: moment(commit.utctimestamp).toISOString()
        branch: commit.branch
      )
return yes
