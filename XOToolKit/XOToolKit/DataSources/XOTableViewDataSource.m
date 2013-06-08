//
//  XOTableViewDataSource.m
//  XOToolKit
//
//  Created by Scott Petit on 6/7/13.
//  Copyright (c) 2013 ScottPetit. All rights reserved.
//

#import "XOTableViewDataSource.h"

@interface XOTableViewDataSource()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) XOTableViewCellConfigurationBlock configurationBlock;

@end

@implementation XOTableViewDataSource

- (id)init
{
    NSAssert(NO, @"XOTableViewDataSource must be initialized by calling initWithItems:cellIdentifier:configurationBlock");
    return nil;
}

- (id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configurationBlock:(XOTableViewCellConfigurationBlock)configurationBlock
{
    self = [super init];
    if (self)
    {
        _items = items;
        _cellIdentifier = [cellIdentifier copy];
        _configurationBlock = [configurationBlock copy];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id item = self.items[indexPath.row];
    self.configurationBlock(cell, item);
    
    return cell;
}

@end
