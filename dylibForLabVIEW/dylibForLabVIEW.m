//
//  dylibForLabVIEW.m
//  dylibForLabVIEW
//
//  Created by Michael Powell on 10/17/19.
//  Copyright © 2019 Michael Powell. All rights reserved.
//
#import "dylibForLabVIEW.h"

@interface dylibForLabVIEW : NSObject
@end

@implementation dylibForLabVIEW
//
// key: 8571a448cf9a6ef062336293fb6dad4c8d4a89224354bcdf048c335b08a9e03c
//
const char keyBytes[] = "\x85\x71\xa4\x48\xcf\x9a\x6e\xf0\x62\x33\x62\x93\xfb\x6d\xad\x4c\x8d\x4a\x89\x22\x43\x54\xbc\xdf\x04\x8c\x33\x5b\x08\xa9\xe0\x3c";
//
///
/// decrypt_objc_data:
///
+(NSData *)decrypt_objc_data:(NSData *)objcDataToDecrypt reportedError:(NSError **)reportedError {
    NSData  *encryptionKey = [NSData dataWithBytes:keyBytes length:32];
    NSData  *decryptedData = [RNDecryptor decryptData:objcDataToDecrypt withEncryptionKey:encryptionKey HMACKey:encryptionKey error:reportedError];
    return decryptedData;
}   //  decryptData
@end
///
///  testFunction
///
int32_t testFunction(int32_t testInteger)   {
    return 2*testInteger;
}   //  testFunction
///
/// decryptData:
///
/// this procedure will accept the encrypted data and return it decrypted
/// it will already have been tested to ensure that it was encrypted
/// base64 will already have been stripped stripped
///
/// prelude:
///     In objective c, or LabVIEW, we will have got access to RNCryptor CBC encrypted data
///     It will have been checked to see if it is indeed encrypted
///     If so, base64 will have been stripped
///     What is passed here is a pointer to the encrypted bytes, their length, and a pointer to where the decrypted result should
///
uint64_t    decryptData (uint8_t *dataToDecrypt, uint64_t lengthToDecrypt, uint8_t *decryptedData, uint8_t *errorText) {
    unsigned long lengthDecrypted = 0;
    NSData  *objcDecryptedData;
    NSData  *objcDataToDecrypt = [NSData dataWithBytes:dataToDecrypt length:lengthToDecrypt];
    NSError *objcError;
    NSData *errorData;
    objcDecryptedData = [dylibForLabVIEW decrypt_objc_data:objcDataToDecrypt reportedError:&objcError];
    if (!objcError) {
        lengthDecrypted = [objcDecryptedData length];
        errorData = [@"no error" dataUsingEncoding:NSUTF8StringEncoding];
    }
    else    {
        errorData = [objcError.localizedDescription dataUsingEncoding:NSUTF8StringEncoding];
    }
    uint32_t errorLength = [errorData length];
    for (int i = 0; i <= errorLength; i++) {
        errorText[i] = 0;
    }   //  text, plus terminal 0
    memcpy(errorText, [errorData bytes], errorLength);
    unsigned char *newlyDecryptedData = [objcDecryptedData bytes];
    memcpy(decryptedData, newlyDecryptedData, lengthDecrypted);
    return lengthDecrypted;
}   //  decryptData
//
