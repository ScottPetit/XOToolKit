//
//  NSArray+XO.m
//  XOToolKit
//
//  Created by Scott Petit on 10/28/12.
//  Copyright (c) 2012 Scott Petit. All rights reserved.
//

#import "NSArray+XO.h"

@implementation NSArray (XO)

- (id)firstObject
{
    if (self.count == 0)
    {
        return nil;
    }
    
    return [self objectAtIndex:0];
}

- (id)randomObject
{
    if (self.count == 0)
    {
        return nil;
    }
    
    return [self objectAtIndex:arc4random_uniform(self.count)];
}

- (NSArray *)reverse
{
    return [[self reverseObjectEnumerator] allObjects];
}

@end
