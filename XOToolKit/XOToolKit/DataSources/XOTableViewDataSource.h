//
//  XOTableViewDataSource.h
//  XOToolKit
//
//  Created by Scott Petit on 6/7/13.
//  Copyright (c) 2013 ScottPetit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^XOTableViewCellConfigurationBlock)(id cell, id item);

@interface XOTableViewDataSource : NSObject <UITableViewDataSource>

- (id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configurationBlock:(XOTableViewCellConfigurationBlock)configurationBlock;

@end
