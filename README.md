# uni-webhook

## Install

`npm install uni-webhook --save`

## Example

```
var uniWebhook = require('uni-webhook')
var express = require('express')

app = express()

app.post(uniWebhook,function(req,res,next){
    res.send(req.payload);
})

app.listen(process.env.PORT)
```