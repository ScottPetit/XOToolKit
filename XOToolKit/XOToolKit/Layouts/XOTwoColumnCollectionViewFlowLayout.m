//
//  XOTwoColumnCollectionViewFlowLayout.m
//  XOToolKit
//
//  Created by Scott Petit on 6/9/13.
//  Copyright (c) 2013 ScottPetit. All rights reserved.
//

#import "XOTwoColumnCollectionViewFlowLayout.h"
#import "XOToolKit.h"

@interface XOTwoColumnCollectionViewFlowLayout()

@property (nonatomic) NSInteger cellWidth;
@property (nonatomic) NSInteger numberOfItems;

@end

static NSInteger const kCollectionViewCellMargin = 8;

@implementation XOTwoColumnCollectionViewFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.cellWidth = (CGRectGetWidth(self.collectionView.frame) / 2) - (1.5 * kCollectionViewCellMargin);
    
    for (int i = 0; i < [self.collectionView numberOfSections]; i++)
    {
        self.numberOfItems += [self.collectionView numberOfItemsInSection:i];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *attributes in layoutAttributes)
    {
        NSIndexPath *indexPath = attributes.indexPath;
        attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
    }
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger currentColumn = indexPath.row / 2;
    
    NSInteger minX = indexPath.row % 2 ? kCollectionViewCellMargin : self.cellWidth + 2 * kCollectionViewCellMargin;
    NSInteger minY = kCollectionViewCellMargin + (currentColumn * (self.cellWidth + kCollectionViewCellMargin));
    layoutAttributes.frame = CGRectMake(minX, minY, self.cellWidth, self.cellWidth);
    
    return layoutAttributes;
}

- (CGSize)collectionViewContentSize
{
    CGSize contentSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), (self.cellWidth + kCollectionViewCellMargin) * (self.numberOfItems / 2) + kCollectionViewCellMargin);
    return contentSize;
}

@end
