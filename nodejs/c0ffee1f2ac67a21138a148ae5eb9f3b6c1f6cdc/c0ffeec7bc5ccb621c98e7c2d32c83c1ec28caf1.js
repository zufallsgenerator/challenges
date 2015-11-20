/*
code used to create email address hashing to 'c0ffeec7bc5ccb621c98e7c2d32c83c1ec28caf1'
*/

var crypto = require('crypto');
var target = 'c0ffee';
var hash = '';
var stop = false;
var i = 0;

function getHash (nonce) {
  var algorithm = 'sha1';
  var text = 'prefix+' + nonce + '@domain.tld';
  var hash = crypto.createHash(algorithm);

  hash.setEncoding('hex');
  hash.write(text);
  hash.end();
  
  return hash.read(); 
}

while (hash.substring(0, target.length) != target) {
  hash = getHash(i);
  console.log(i, hash);
  i++;
}

console.log(i--, hash);
