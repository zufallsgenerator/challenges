/**
 * Usage: node ./cli.js your-email@your-domain.com
 */

'use strict';

var crypto = require('crypto');

var HASH_START = 'c0ffee';

var email = process.argv[2];

if (!email) {
    console.log('Argument 1 must be an email address');
    process.exit(1);
}

var user = email.split('@')[0];
var domain = email.split('@')[1];

for (var i = 0; i < 1000000000; i++) {
    var shasum = crypto.createHash('sha1');
    shasum.update(user + '+' + i + '@' + domain);
    var digest = shasum.digest('hex');

    if (digest.slice(0, HASH_START.length) === HASH_START) {
        console.log('Round: ' + i);
        console.log('Email: ' + user + '+' + i + '@' + domain);
        console.log('Digest: ' + digest);
        break;
    }
}

