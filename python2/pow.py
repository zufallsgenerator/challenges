#!/usr/bin/env python2
import sha
import sys

def main():
	if len(sys.argv) != 4:
		sys.stderr.write('Usage: %s yourname domain pattern\n' % sys.argv[0])
		sys.exit(1)

	email = "%s.%s@%s" % (sys.argv[1], "%d", sys.argv[2])
	pattern = sys.argv[3]

	i = 0
	length = len(pattern)

	while(sha.new(email % i).hexdigest()[:length] != pattern):
		i += 1

	print "Result: %s" % (email % i)
	print "sha1sum: %s" % (sha.new(email % i).hexdigest())

if __name__ == "__main__": main()
