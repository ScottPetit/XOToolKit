//
//  XOManagedObject.h
//  Scooby
//
//  Created by Scott Petit on 1/24/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface XOManagedObject : NSManagedObject

+ (id)objectWithId:(id)identifier inContext:(NSManagedObjectContext *)context;

- (void)unpackDictionary:(NSDictionary *)dictionary inContext:(NSManagedObjectContext *)context;

@end
