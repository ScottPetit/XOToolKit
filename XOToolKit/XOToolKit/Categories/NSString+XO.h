//
//  NSString+XO.h
//  XOToolKit
//
//  Created by Scott Petit on 11/23/12.
//  Copyright (c) 2012 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XO)

- (NSString *)xo_reverse;
+ (NSString *)xo_camelCaseStringForComponents:(NSArray *)components;

@end
