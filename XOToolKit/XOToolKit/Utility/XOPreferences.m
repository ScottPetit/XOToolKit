//
//  XOPreferences.m
//  XOToolkit
//
//  Created by Scott Petit on 2/23/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "XOPreferences.h"

@implementation XOPreferences

+ (XOPreferences *)sharedPreferences
{
    static XOPreferences *sharedPreferences = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPreferences = [[XOPreferences alloc] init];
    });
    return sharedPreferences;
}

- (void)setObject:(id)object forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)objectForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (void)setBool:(BOOL)boolean forkey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:boolean forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)boolForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end
