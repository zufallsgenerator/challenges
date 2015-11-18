#!/usr/bin/env node

var crypto = require('crypto')
var chars = 'abcdefghijklmnopqrstuvwxyz'.split()
var prefix = /^c0ffee/

function check () {
  var email = 'jo+' + (Math.random().toString(36)+'00000000000000000').slice(2, 18) + '@die-tf.de'
  var shasum = crypto.createHash('sha1')
  shasum.update(email)
  return shasum.digest('hex').match(prefix) && email
}

var result
do {
  result = check()
} while (!result)

console.log(result)
