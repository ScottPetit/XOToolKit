//
//  XOObject.h
//  Scooby
//
//  Created by Scott Petit on 12/29/12.
//  Copyright (c) 2012 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XOObject : NSObject

+ (id)objectWithDictionary:(NSDictionary *)dictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;
- (void)unpackDictionary:(NSDictionary *)dictionary;

@end
