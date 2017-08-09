//
//  ViewController.m
//  UICollectViewDemo
//
//  Created by Ethank on 16/4/17.
//  Copyright © 2016年 Ldy. All rights reserved.
//

#import "SLhorizonColllectionVC.h"
#import "CDCollectionViewCell.h"
#import "SLCollectionLayout.h"
#import "CDCircleLayout.h"
#import "SquareLayout.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
@interface SLhorizonColllectionVC ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)NSMutableArray *imageS;
@property(nonatomic,strong)UICollectionView *collectionV;
@end

@implementation SLhorizonColllectionVC
static NSString *const identifier = @"CDCell";

- (NSMutableArray *)imageS {
    if (!_imageS) {
        self.imageS = [NSMutableArray array];
        for (int i = 1; i <= 20; i++) {
            [self.imageS addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _imageS;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.view addSubview:self.collectionV];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageS.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.imageStr = self.imageS[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionV.collectionViewLayout isKindOfClass:[SLCollectionLayout class]]) {
        NSLog(@"selected %ld", (long)indexPath.item);
        [self switchLayout];

    }else{
        [self switchLayout];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private Methods 

- (void)switchLayout {
    if ([self.collectionV.collectionViewLayout isKindOfClass:[SquareLayout class]]) {
        [self.collectionV setCollectionViewLayout:[[SLCollectionLayout alloc] init] animated:YES];
    } else {
        [self.collectionV setCollectionViewLayout:[[SquareLayout alloc] init] animated:YES];
    }
}

- (UICollectionView *)collectionV{
    if (!_collectionV) {
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 100) collectionViewLayout:[[SquareLayout alloc] init]];
        [_collectionV setBackgroundColor:[UIColor lightGrayColor]];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.showsHorizontalScrollIndicator = NO;
        [_collectionV registerNib:[UINib nibWithNibName:@"CDCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    }
    return _collectionV;
}


@end
