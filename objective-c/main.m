#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
NSString* hashFromString(NSString * input) {
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(NSInteger i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int count = 0;
        while (true) {
            NSString *string = [NSString stringWithFormat:@"example+%iexample.com", count];
            NSString *hash = hashFromString(string);
            NSString *hashBegin = @"c0ffee";
            if ([[hash substringToIndex:hashBegin.length] isEqualToString:hashBegin]) {
                NSLog(@"%@ : %@", string, hash);
                break;
            }
            count++;
        }
    }
    return 0;
}