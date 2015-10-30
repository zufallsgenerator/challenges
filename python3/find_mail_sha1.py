 #!/usr/bin/env python2

from hashlib import sha1
from itertools import combinations
from string import printable


def check_sha1_hash(gen_string):
#Create Sha1 Hash and compare
    email_hash = sha1(gen_string.encode('utf-8')).hexdigest()
    if email_hash[0:6]=="c0ffee":
        return 1, email_hash
    else:
        return 0, None


def find_mail(email, provider):

#Test all possible combinations of email addresses based on exisitng address
    str_length = 1

    while True:
        for i in combinations(printable, str_length):
            concat = email + ''.join(i) + provider
            found, hash = check_sha1_hash(concat)
            if hash:
                return concat, hash

        str_length += 1


if __name__ == "__main__":


#Adjust email and provider variable accordingly

    email = "mrexample+"
    provider = "@gmail.com"

    print("Searching sha1 hash ...." )
    concat, hash = find_mail(email, provider)
    print("E-Mail found: " + str(concat))
    print("Hash: " + str(hash))

