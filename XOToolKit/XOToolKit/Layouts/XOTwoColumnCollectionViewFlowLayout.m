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

@end

static NSInteger const kCollectionViewCellMargin = 8;

@implementation XOTwoColumnCollectionViewFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.cellWidth = (CGRectGetWidth(self.collectionView.frame) / 2) - (3 * kCollectionViewCellMargin);
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

@end
