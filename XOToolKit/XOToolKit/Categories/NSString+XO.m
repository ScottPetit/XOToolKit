//
//  NSString+XO.m
//  XOToolKit
//
//  Created by Scott Petit on 11/23/12.
//  Copyright (c) 2012 Scott Petit. All rights reserved.
//

#import "NSString+XO.h"

@implementation NSString (XO)

- (NSString *)xo_reverse
{
    NSMutableString *mutableString = [NSMutableString string];
    NSInteger charIndex = [self length];
    
    while (charIndex > 0)
    {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [mutableString appendString:[self substringWithRange:subStrRange]];
    }
    
    return [mutableString copy];
}

+ (NSString *)xo_camelCaseStringForComponents:(NSArray *)components
{
    NSMutableString *result = [NSMutableString string];
    
    for (NSString *segment in components)
    {
        BOOL lowercase = result.length == 0;
        if (segment.length == 0)
        {
            continue;
        }
        
        if (lowercase)
        {
            [result appendString:[[segment substringToIndex:1] lowercaseString]];
            [result appendString:[segment substringFromIndex:1]];
        }
        else
        {
            [result appendString:[[segment substringToIndex:1] uppercaseString]];
            [result appendString:[segment substringFromIndex:1]];
        }
    }
    
    return result;
}

@end
