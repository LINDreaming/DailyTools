//
//  SquareLayout.m
//  DailyTools
//
//  Created by 林喜 on 8/9/17.
//  Copyright © 2017 ShowLin. All rights reserved.
//

#import "SquareLayout.h"

@implementation SquareLayout


-(void)prepareLayout{
    [super prepareLayout];
    [self.attrsArr removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attrs=[self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArr addObject:attrs];
    }
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArr;
}
- (CGSize)collectionViewContentSize{
    int count =(int)[self.collectionView numberOfItemsInSection:0];
    int rows=(count +2)/3;
    CGFloat rowH = self.collectionView.frame.size.width/2;
    if ((count)%6==2|(count)%6==4) {
        return CGSizeMake(0, rows * rowH);
        
    }else{
        
        return CGSizeMake(0, rows*rowH);
        
    }
  
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width =self.collectionView.frame.size.width*0.5;
    UICollectionViewLayoutAttributes * attrs=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat height =width;
    NSInteger i=indexPath.item;
    if (i==0) {
        attrs.frame = CGRectMake(0, 0, width, height);
    }else if (i==1){
        attrs.frame = CGRectMake(width, 0, width, height/2);
    }else if (i==2){
        attrs.frame = CGRectMake(width, height/2, width, height/2);
    }else if (i==3){
        attrs.frame = CGRectMake(0, height, width, height/2);
    }else if (i==4){
        attrs.frame = CGRectMake(0, height+height/2, width, height/2);
    }else if (i==5){
        attrs.frame = CGRectMake(width, height, width, height);
    }else{
        UICollectionViewLayoutAttributes *lastAttrs = self.attrsArr[i-6];
        CGRect frame = lastAttrs.frame; frame.origin.y+=2 * height; attrs.frame=frame;
    }
    return attrs;
    
  
}

-(NSMutableArray *)attrsArr
{
    if(!_attrsArr){
        _attrsArr=[[NSMutableArray alloc] init];
    }
    return _attrsArr;
}

@end
