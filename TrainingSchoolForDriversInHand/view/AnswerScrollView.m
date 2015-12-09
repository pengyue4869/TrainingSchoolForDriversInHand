//
//  AnswerScrollView.m
//  TrainingSchoolForDriversInHand
//
//  Created by 彭月 on 15/12/8.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import "AnswerScrollView.h"

#define SIZE self.frame.size

@interface AnswerScrollView ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    UIScrollView * _scrollView;
    UITableView * leftTableView;
    UITableView * mainTableView;
    UITableView * rightTableView;
    NSArray * _dataArray;


}
@end


@implementation AnswerScrollView

- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _dataArray = [NSArray arrayWithArray:dataArray];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate = self;
        
        leftTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        leftTableView.delegate = self;
        leftTableView.dataSource = self;
        
        mainTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        
        rightTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        rightTableView.delegate = self;
        rightTableView.dataSource = self;
        
        [self createUI];
    
    }
    
    return self;
    
}


- (void)createUI{
    
    leftTableView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    mainTableView.frame = CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
    rightTableView.frame = CGRectMake(SIZE.width*2, 0, SIZE.width, SIZE.height);
    
    [_scrollView addSubview:leftTableView];
    [_scrollView addSubview:mainTableView];
    [_scrollView addSubview:rightTableView];
    
    [self addSubview:_scrollView];
    
}

#pragma mark - 实现表代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 9;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView  * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, 100.0f)];
    headView.backgroundColor = [UIColor redColor];
    return headView;

}

#pragma mark - 实现scrollView的代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{


}

@end
