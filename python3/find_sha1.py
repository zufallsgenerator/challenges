#!/usr/bin/env python3

from hashlib import sha1

def sha1_hash(string):
    """Return SHA1 of string."""
    sha1_obj = sha1(string.encode('utf-8'))
    return sha1_obj.hexdigest()

def find_sha1_with_start(start, template):
    """Return tuple of string and SHA1(string)
    that begin with start and adhere to template."""
    counter = 0
    candidate = ''
    while not sha1_hash(candidate).startswith(start):
        candidate = template.format(counter)
        counter += 1
    return (candidate, sha1_hash(candidate))


if __name__ == '__main__':
    sha1_start = 'c0ffee'

    # Make sure it's actually working
    print('Testing...', end='')
    assert sha1_hash('example+1899634@example.com').startswith(sha1_start)
    print('OK')

    # Run the search
    needle, needle_hash = find_sha1_with_start(sha1_start, '{0}@example.com')
    print('*'*10, 'FOUND', '*'*10)
    print(needle, needle_hash)
