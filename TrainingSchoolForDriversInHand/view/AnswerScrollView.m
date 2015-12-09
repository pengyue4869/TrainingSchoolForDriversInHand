//
//  AnswerScrollView.m
//  TrainingSchoolForDriversInHand
//
//  Created by 彭月 on 15/12/8.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import "AnswerScrollView.h"
#import "AnswerTableViewCell.h"



#define SIZE self.frame.size

@interface AnswerScrollView ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    UIScrollView * _scrollView;
    UITableView * leftTableView;
    UITableView * mainTableView;
    UITableView * rightTableView;
    NSArray * _dataArray;


}

@property (nonatomic,assign,readwrite) int currentPage;

@end


@implementation AnswerScrollView

- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _dataArray = [NSArray arrayWithArray:dataArray];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        if (_dataArray.count>1) {
            _scrollView.contentSize = CGSizeMake(SIZE.width*2, SIZE.height);
        }
        
        
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

    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellID = @"AnswerTableViewCell";
    AnswerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AnswerTableViewCell" owner:self options:nil]lastObject];
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius = 10;
    }
    
    cell.numberLabel.text = [NSString stringWithFormat:@"%c",'A'+indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView  * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, 100.0f)];
    headView.backgroundColor = [UIColor redColor];
    return headView;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 100.0f;

}

#pragma mark - 实现scrollView的代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    CGPoint currentSizeOff = scrollView.contentOffset;
    
    self.currentPage = (int)currentSizeOff.x/SIZE.width;
    
    if (self.currentPage < _dataArray.count-1) {
        
        _scrollView.contentSize = CGSizeMake(currentSizeOff.x+SIZE.width*2, SIZE.height);
        
        leftTableView.frame = CGRectMake(currentSizeOff.x-SIZE.width, 0, SIZE.width, SIZE.height);
        mainTableView.frame = CGRectMake(currentSizeOff.x, 0, SIZE.width, SIZE.height);
        rightTableView.frame = CGRectMake(currentSizeOff.x+SIZE.width, 0, SIZE.width, SIZE.height);
        
    }
    
    
}

@end
