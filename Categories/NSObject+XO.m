//
//  NSObject+XO.m
//  Scooby
//
//  Created by Scott Petit on 1/14/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "NSObject+XO.h"

@implementation NSObject (XO)

- (BOOL)isNotKindOfClass:(Class)class
{
    return ![self isKndOfClass:class];
}

@end
