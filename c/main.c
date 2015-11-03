#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <openssl/sha.h>

unsigned int hexstr2bytes(unsigned char *hex_str, unsigned char *out_buff){
	int i, n;
	int length = strlen(hex_str) / 2;

	for(i = 0; i < length; i++) {
		sscanf(hex_str, "%2X", &n);
		hex_str += 2;
		out_buff[i] = (char)n;
	}
	return length;
}


int main(int argc, char **argv) {
	unsigned char comp_str[64];
	unsigned char email[128];
	unsigned char hex_byte[16];
	unsigned char hash[SHA_DIGEST_LENGTH];
	unsigned int i = 0;
	unsigned int comp_length = 0;

	if ( argc != 4 ) {

		printf( "Usage: %s yourname pattern domain\n", argv[0] );
		printf( "Example: %s joe c0ffee gmail.com\n", argv[0] );
		return -1;

	} else {
		strcpy(comp_str, argv[1]);
		strcat(comp_str, "+%d@");
		strcat(comp_str, argv[3]);

		comp_length = hexstr2bytes(argv[2], hex_byte);
	}

	do{
		sprintf(email, comp_str, i);
		SHA1(email, strlen(email), hash);

		i++;
	}while(memcmp(hash, hex_byte, comp_length));

	printf("email address:%s\n", email);
	return 0;
}
