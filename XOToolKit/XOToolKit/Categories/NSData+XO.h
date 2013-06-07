//
//  NSData+XO.h
//  XOToolKit
//
//  Created by Scott Petit on 3/13/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>

void *NewBase64Decode(
                      const char *inputBuffer,
                      size_t length,
                      size_t *outputLength);

char *NewBase64Encode(
                      const void *inputBuffer,
                      size_t length,
                      bool separateLines,
                      size_t *outputLength);

@interface NSData (XO)

+ (NSData *)xo_dataFromBase64String:(NSString *)aString;
- (NSString *)xo_base64EncodedString;

- (NSString *)xo_base64EncodedStringWithSeparateLines:(BOOL)separateLines;

@end
