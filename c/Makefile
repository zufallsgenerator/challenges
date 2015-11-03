CC=gcc
CFLAGS="-Wall"
LDFLAGS= -lssl -lcrypto

debug:clean
	$(CC) $(CFLAGS) -g -o talentmatch main.c $(LDFLAGS)
stable:clean
	$(CC) $(CFLAGS) -o talentmatch main.c $(LDFLAGS)
clean:
	rm -vfr *~ talentmatch
