import random 
import string 
import hashlib 
import sys
 
def main(): 
    all() 
 
def generate(): 
    s_r = "@gmx.com" 
    for i in range(0,12): 
        if random.randint(0,1) == 0: 
            s_r = random.choice(string.ascii_letters) + s_r 
        else: 
            s_r = str(random.randint(0,9)) + s_r 
    return s_r 
 
def all(): 
    while True: 
        a = generate() 
        a_s = hashlib.sha1(bytes(a,"UTF-8")).hexdigest() 
        if "c0ffee" in a_s[:6]: 
            print("{0} : {1}".format(a, a_s)) 
            sys.exit()

if __name__ == "__main__": 
    main() 
