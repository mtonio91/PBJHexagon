//
//  PBJHexagonFlowLayout.m
//
//  Created by Patrick Piemonte on 10/30/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "PBJHexagonFlowLayout.h"

@interface PBJHexagonFlowLayout ()
{
    NSInteger _itemsPerRow;
    NSInteger _itemTotalCount;
    CGSize _hexagonSize;
}

@end

@implementation PBJHexagonFlowLayout

@synthesize itemsPerRow = _itemsPerRow;
@synthesize itemTotalCount = _itemTotalCount;
@synthesize hexagonSize = _hexagonSize;

#pragma mark - UICollectionViewLayout Subclass hooks

- (void)prepareLayout
{
    [super prepareLayout];
    
    if (_itemsPerRow == 0)
        _itemsPerRow = 4;
    _itemTotalCount = [self.collectionView numberOfItemsInSection:0];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0 ; i < _itemTotalCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = (NSInteger)( floorf((indexPath.row / _itemsPerRow)) );
    NSInteger col = indexPath.row % _itemsPerRow;

    CGFloat horiOffset = ((row % 2) != 0) ? 0 : _hexagonSize.width * 0.5f;
    CGFloat vertOffset = 0;
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = _hexagonSize;
    attributes.center = CGPointMake( ( (col * _hexagonSize.width) + (0.5f * _hexagonSize.width) + horiOffset),
                                     ( ( (row * 0.75f) * _hexagonSize.height) + (0.5f * _hexagonSize.height) + vertOffset) );
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

- (CGSize)collectionViewContentSize
{
    CGFloat contentWidth = self.collectionView.bounds.size.width;
    CGFloat contentHeight = ( ((_itemTotalCount / _itemsPerRow) * 0.75f) * _hexagonSize.height) + (0.5f + _hexagonSize.height);
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    return contentSize;
}

@end
