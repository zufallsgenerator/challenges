#!/usr/bin/env python3

from hashlib import sha1


for i in range(100000000):                                                                                                                
    s = "example+%s@example.com" % i
    d = sha1(s)
    if d.hexdigest().startswith('c0ffee'):
        print(d.hexdigest() ,s, i)
        break  # We're done here.
