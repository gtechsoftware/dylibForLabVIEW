//
//  dylibForLabVIEW.h
//  dylibForLabVIEW
//
//  Created by Michael Powell on 10/17/19.
//  Copyright © 2019 Michael Powell. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import "RNCryptor.h"
#import "RNDecryptor.h"
#import <stdlib.h>
//
//  testFunction
//
int32_t testFunction(int32_t testInteger);
//
//  decryptData
//
uint64_t    decryptData (uint8_t *dataToDecrypt, uint64_t lengthToDecrypt, uint8_t *decryptedData, uint8_t *errorText);
