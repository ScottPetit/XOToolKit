//
//  NSObject+XO.h
//  Scooby
//
//  Created by Scott Petit on 1/14/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XO)

- (BOOL)isNotKindOfClass:(Class)class;

- (instancetype)tap:(void (^)(id x))block;

@end
