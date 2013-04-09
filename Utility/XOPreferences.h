//
//  XOPreferences.h
//  XOToolkit
//
//  Created by Scott Petit on 2/23/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XOPreferences : NSObject

+ (XOPreferences *)sharedPreferences;

- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

- (void)setBool:(BOOL)boolean forkey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;

@end
