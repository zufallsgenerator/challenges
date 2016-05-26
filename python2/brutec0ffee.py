#!/usr/bin/env python

import hashlib
import sys


class SaltGenerator:
    # https://en.wikipedia.org/wiki/Email_address except the plus sign
    CHARS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!#$%&'*-/=?^_`{|}~"   # noqa

    def __init__(self):
        self._idx = 0
        self._max = len(self.CHARS)
        self._arr = [0]
        self._mul = 1.0 / float(len(self.CHARS))
        self._str = ""

    def __iter__(self):
        return self

    def next(self):
        arr = self._arr
        ret = "".join([self.CHARS[c] for c in arr])

        carrie = True
        for i in range(len(arr) - 1, -1, -1):
            if carrie:
                arr[i] = arr[i] + 1
            if arr[i] >= self._max:
                carrie = True
                arr[i] = 0
            else:
                carrie = False
        if carrie:
            arr.insert(0, 1)

        return ret


def hashes_to_c0ffee(input):
    res = hashlib.sha1(input).hexdigest()
    return res[:6] == "c0ffee"


def brute_c0ffee(template):
    found = False

    salt_gen = SaltGenerator()

    cnt = 0
    while not found:
        cnt += 1
        salt = salt_gen.next()
        res = template.format(salt)
        if hashes_to_c0ffee(res):
            print("\nFound match: {}".format(res))
            print("Hash: {}".format(hashlib.sha1(res).hexdigest()))
            return res

        if (cnt % 100000) == 0:
            print "\rTries so far: {}".format(cnt),
            sys.stdout.flush()


if __name__ == "__main__":

    # First verify the example
    assert(hashes_to_c0ffee("example+1899634@example.com"))
    if len(sys.argv) != 2:
        print("Usage: {} email+{}@example.org".format(sys.argv[0], "{}"))
        sys.exit(1)
    template = sys.argv[1]
    brute_c0ffee(template)
