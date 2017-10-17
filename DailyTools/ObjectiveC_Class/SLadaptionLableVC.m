//
//  SLadaptionLableVC.m
//  DailyTools
//
//  Created by 林喜 on 10/14/17.
//  Copyright © 2017 ShowLin. All rights reserved.
//

#import "SLadaptionLableVC.h"
#import "UIView+PYSearchExtension.h"
#define PYSEARCH_MARGIN 5 // 默认边距
#define PYSEARCH_BACKGROUND_COLOR PYSEARCH_COLOR(255, 255, 255) // tableView背景颜色
@interface SLadaptionLableVC ()
@property(nonatomic,strong)NSMutableArray *dataSource;//存放标签的dataSource;
@property (nonatomic, weak) UIView *hotSearchTagsContentView;
@property (nonatomic, weak) UIView *hotSearchView;
@property (nonatomic, weak) UIView *searchHistoryView;


@end

@implementation SLadaptionLableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.myTitle;
    [self addAndLayoutTagsWithTagsContentView:self.view tagTexts:self.dataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 用户交互

- (void)tagDidCLick:(UITapGestureRecognizer *)gr{
    UILabel *lable = (UILabel *)gr.view;
    NSLog(@"点击的文字是 %@",
          lable.text);
}



#pragma mark - private Methods
/** 添加和布局标签 */
- (NSArray *)addAndLayoutTagsWithTagsContentView:(UIView *)contentView tagTexts:(NSArray<NSString *> *)tagTexts;
{
    // 清空标签容器的子控件
    [contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 添加热门搜索标签
    NSMutableArray *tagsM = [NSMutableArray array];
    for (int i = 0; i < tagTexts.count; i++) {
        UILabel *label = [self labelWithTitle:tagTexts[i]];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [contentView addSubview:label];
        [tagsM addObject:label];
    }
    
    // 计算位置
    CGFloat currentX = 0;
    CGFloat currentY = 0;
    CGFloat countRow = 0;
    CGFloat countCol = 0;
    
    // 调整布局
    for (int i = 0; i < contentView.subviews.count; i++) {
        UILabel *subView = contentView.subviews[i];
        // 当搜索字数过多，宽度为contentView的宽度
        if (subView.py_width > contentView.py_width) subView.py_width = contentView.py_width;
        if (currentX + subView.py_width + PYSEARCH_MARGIN * countRow > contentView.py_width) { // 得换行
            subView.py_x = 0;
            subView.py_y = (currentY += subView.py_height) + PYSEARCH_MARGIN * ++countCol+64;
            currentX = subView.py_width;
            countRow = 1;
        } else { // 不换行
            subView.py_x = (currentX += subView.py_width) - subView.py_width + PYSEARCH_MARGIN * countRow;
            subView.py_y = currentY + PYSEARCH_MARGIN * countCol+64;
            countRow ++;
        }
    }
    // 设置contentView高度
    contentView.py_height = CGRectGetMaxY(contentView.subviews.lastObject.frame);
    if (self.hotSearchTagsContentView == contentView) { // 热门搜索标签
        self.hotSearchView.py_height = CGRectGetMaxY(contentView.frame) + PYSEARCH_MARGIN * 2;
    }
    // 取消隐藏
    // 重新赋值, 注意：当操作系统为iOS 9.x系列的tableHeaderView高度设置失效，需要重新设置tableHeaderView
    return [tagsM copy];
}


/** 添加标签 */
- (UILabel *)labelWithTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.userInteractionEnabled = YES;
    label.font = [UIFont systemFontOfSize:14];
    label.text = title;
    label.textColor = [UIColor grayColor];
    label.layer.cornerRadius = 3;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.py_width += 20;
    label.py_height += 14;
    return label;
}

#pragma mark - getter&&Setter Methods



- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObjectsFromArray:@[@"劝君吸取今日时",@"人生路漫漫",@"与你相伴",@"123",@"2",@"4",@"劝君吸取今日时",@"人生路漫漫",@"与你相伴",@"123",@"2",@"4"]];
        
    }
    return _dataSource;
}
- (UIView *)searchHistoryView
{
    if (!_searchHistoryView) {
        UIView *searchHistoryView = [[UIView alloc] init];
        searchHistoryView.py_x = self.hotSearchView.py_x;
        searchHistoryView.py_y = self.hotSearchView.py_y;
        searchHistoryView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _searchHistoryView = searchHistoryView;
    }
    return _searchHistoryView;
}
@end
