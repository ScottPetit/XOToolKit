//
//  NSArray+XO.h
//  XOToolKit
//
//  Created by Scott Petit on 10/28/12.
//  Copyright (c) 2012 Scott Petit. All rights reserved.
//

@interface NSArray (XO)

// Example
// NSObject *firstObject = [self.myArray firstObject];
//
// Returns the object at index 0 of the given array if it exists
// If the array is empty it returns nil
- (id)xo_firstObject;

// Example
// NSObject *randomObject = [self.myArray randomObject];
//
// Returns a random object in the given array
// If the array is empty it returns nil
- (id)xo_randomObject;

// Example
// NSArray *reversedArray = [array reverse];
//
// Returns a reversed array
- (NSArray *)xo_reverse;

@end
