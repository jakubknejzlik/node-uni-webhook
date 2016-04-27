bodyParser = require('body-parser')
Router = require('express').Router

router = new Router()

parsers = require('./parsers')

router.use(bodyParser.json())
router.use(bodyParser.urlencoded({extended: false}))


router.use((req,res,next)->
  for parser in parsers
    if parser(req)
      return next()
  next(new Error('parser not found'))
)

module.exports = router