//
//  NSObject+XO.m
//  Scooby
//
//  Created by Scott Petit on 1/14/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "NSObject+XO.h"

@implementation NSObject (XO)

- (BOOL)xo_isNotKindOfClass:(Class)class
{
    return ![self isKindOfClass:class];
}

- (instancetype)xo_tap:(void (^)(id))block
{
    NSParameterAssert(block);
    if (!block)
    {
        return nil;
    }
    block(self);
    return self;
}

@end
