//
//  NSDictionary+XO.m
//  Scooby
//
//  Created by Scott Petit on 1/30/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "NSDictionary+XO.h"

@implementation NSDictionary (XO)

- (id)xo_objectForKeyOrNil:(id)key
{
    id value = [self objectForKey:key];
    if ([value isEqual:[NSNull null]])
    {
        return nil;
    }
    return value;
}

@end
