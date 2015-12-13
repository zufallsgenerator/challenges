// run `npm install sha1` before running script

var sha1 = require('sha1');
var flag = "";
var email = "";

var checkHashIsCoffee = function(stringToCheck) {
	if(sha1(stringToCheck).startsWith('c0ffee')) {
		console.log(stringToCheck + ' has hash: ' + sha1(stringToCheck));
		return true
	} 
};

do {
	email = "erasmus+" + Math.floor(Math.random()*10000000) + "@degeist.com";
	console.log(email);
	flag = checkHashIsCoffee(email);
} while(!flag)