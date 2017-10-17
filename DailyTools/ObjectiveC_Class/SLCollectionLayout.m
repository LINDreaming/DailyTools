//
//  SLCollectionLayout.m
//  DailyTools
//
//  Created by 林喜 on 8/8/17.
//  Copyright © 2017 ShowLin. All rights reserved.
//

#import "SLCollectionLayout.h"
static const CGFloat CDItemW = 160;
static const CGFloat CDItemH = 280;
static const CGFloat LineSpacing = 80;
@implementation SLCollectionLayout

- (void)prepareLayout{
    self.itemSize = CGSizeMake(CDItemW, CDItemH);
    CGFloat inset = (self.collectionView.frame.size.width - CDItemW)*0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = LineSpacing;
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width *0.5;
    CGFloat margin = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attribute in array) {
        if (ABS(attribute.center.x - centerX) < ABS(margin)) {
            margin = attribute.center.x - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + margin, proposedContentOffset.y);
    
}

static CGFloat const CDActiveDistance = 160;
/** 缩放因素: 值越大, item就会越大 */
static CGFloat const CDScaleFactor = 0.6;

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
   
    CGRect visibleRect;
    visibleRect.size = self.collectionView.frame.size;
    visibleRect.origin = self.collectionView.contentOffset;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    for (UICollectionViewLayoutAttributes *attribute in array) {
        if (!CGRectIntersectsRect(visibleRect, attribute.frame)) {
            continue;
        }
        
        CGFloat itemCenterX = attribute.center.x;
        CGFloat scale = 1 + CDScaleFactor*(1- ABS(itemCenterX - centerX)/CDActiveDistance);
        attribute.transform = CGAffineTransformMakeScale(scale, scale);
        
    }
    return array;
}

@end
