import sha1 from 'sha1';

const EMAIL = 'example+{token}@example.com';
const HASH_START = 'c0ffee';
const START_TIME = new Date().valueOf();

let result = '';
let index = 0;

while (result.substr(0, HASH_START.length) !== HASH_START) {
  result = sha1(EMAIL.replace('{token}', index++));
}

console.log('Hash: ' + result);
console.log('Index: ' + index);
console.log('Finished in: ' + (new Date().valueOf() - START_TIME / 1000) + ' seconds.');
