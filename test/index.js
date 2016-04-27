var assert = require('assert');
var request = require('request');
var express = require('express');

var uniWebhook = require('../index');

describe('parsing',function(){
    before(function(done){
        var app = new express();

        app.use(uniWebhook)

        app.use(function(req,res,next){
            res.send(req.payload);
        })

        app.listen(60000,done);
    })

    it('should parse bitbucket-push payload',function(done){
        request.post('http://localhost:60000',{json:{payload:'{"commits":[{"raw_node":"hash","message":"test-message","branch":"test-branch"}]}'},headers:{'user-agent':'Bitbucket.org'}},function(error,response,data){
            assert.ifError(error);
            assert.equal(data.commits[0].message,'test-message');
            done();
        })
    })

    it('should parse bitbucket-webhook payload',function(done){
        request.post('http://localhost:60000',{json:{"push":{"changes":[{"new":{"target":{"type":"commit","hash":"hash","message":"test-message"},"name":"test-branch","type":"branch"}}]}},headers:{'user-agent':'Bitbucket-Webhooks/2.0'}},function(error,response,data){
            assert.ifError(error);
            assert.equal(data.commits[0].message,'test-message');
            done();
        })
    })
})

