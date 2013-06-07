//
//  XOObject.m
//  Scooby
//
//  Created by Scott Petit on 12/29/12.
//  Copyright (c) 2012 Scott Petit. All rights reserved.
//

#import "XOObject.h"
#import "NSString+XO.h"

@implementation XOObject

+ (id)objectWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        [self unpackDictionary:dictionary];
    }
    return self;
}

- (void)unpackDictionary:(NSDictionary *)dictionary
{
    for (NSString *key in [dictionary allKeys])
    {
        NSString *normalizedKey = [self normalizedKey:key];
        NSArray *setterComponents = @[@"set", normalizedKey];
        NSString *setterName = [[NSString xo_camelCaseStringForComponents:setterComponents] stringByAppendingString:@":"];
        
        SEL selector = NSSelectorFromString(setterName);
        if ([self respondsToSelector:selector])
        {
            id value = [dictionary objectForKey:key];
            [self setValue:value forSelector:selector];
        }
    }
}

- (void)setValue:(id)value forSelector:(SEL)selector
{
#   pragma clang diagnostic push
#   pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:selector withObject:value];
#   pragma clang diagnostic pop
}

- (NSString *)normalizedKey:(NSString *)key
{
    NSArray *components = [key componentsSeparatedByString:@"_"];
    return [NSString xo_camelCaseStringForComponents:components];
}

@end
