#include <limits.h>
#include <openssl/sha.h>
#include <stdio.h>
#include <string.h>

int main()
{
    char str[255];
    unsigned char hash[SHA_DIGEST_LENGTH];
    unsigned int i, j;

    for (i = 0; i < UINT_MAX; i++) {
        snprintf(str, sizeof(str), "example+%d@example.com", i);
        SHA1((unsigned char*) str, strlen(str), hash);

        if (hash[0] == 0xc0 && hash[1] == 0xff && hash[2] == 0xee) {
            printf("Found %s with hash ", str);

            for (j = 0; j < SHA_DIGEST_LENGTH; j++) {
                printf("%02x", hash[j]);
            }

            printf(" after %d tries\n", i);
            break;
        }
    }

    return 0;
}
