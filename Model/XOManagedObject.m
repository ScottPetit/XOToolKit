//
//  XOManagedObject.m
//  Scooby
//
//  Created by Scott Petit on 1/24/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "XOManagedObject.h"

@implementation XOManagedObject

+ (id)objectWithId:(id)identifier inContext:(NSManagedObjectContext *)context
{
    NSAssert(NO, @"the 'objectWithId' method should be handled by subclasses");
    return nil;
}

- (void)unpackDictionary:(NSDictionary *)dictionary inContext:(NSManagedObjectContext *)context
{
    NSAssert(NO, @"The 'unpackDictionary' should be handled by subclasses");
}

@end
