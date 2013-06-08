//
//  XOCollectionViewDataSource.m
//  XOToolKit
//
//  Created by Scott Petit on 6/7/13.
//  Copyright (c) 2013 ScottPetit. All rights reserved.
//

#import "XOCollectionViewDataSource.h"

@interface XOCollectionViewDataSource()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) XOCollectionViewCellConfigurationBlock configurationBlock;

@end

@implementation XOCollectionViewDataSource

- (id)init
{
    NSAssert(NO, @"XOCollectionViewDataSource must be initialized by calling initWithItems:cellIdentifier:configurationBlock");
    return nil;
}

- (id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configurationBlock:(XOCollectionViewCellConfigurationBlock)configurationBlock
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id item = self.items[indexPath.row];
    self.configurationBlock(cell, item);
    
    return cell;
}

@end
