//
//  AnswerScrollView.m
//  TrainingSchoolForDriversInHand
//
//  Created by 彭月 on 15/12/8.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import "AnswerScrollView.h"
#import "AnswerTableViewCell.h"
#import "MyDataManager.h"
#import "AnswerModel.h"
#import "Tools.h"

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
        
        _currentPage = 0; // 展示第一页面 就是第一题
        
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

    return 60.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellID = @"AnswerTableViewCell";
    AnswerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AnswerTableViewCell" owner:self options:nil]lastObject];
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius = 10;
    }
    
    AnswerModel * answerModel = [self getModelWithTableView:tableView];
    
    if ([answerModel.mtype intValue]==1) {
        cell.numberLabel.text = [NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];
        cell.answerLabel.text = [Tools getAnswerWithString:answerModel.mquestion][indexPath.row+1];
    }
    

    return cell;
}


#pragma mark -头视图的封装
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    AnswerModel * answerModel = [self getModelWithTableView:tableView];
    
    CGFloat height;
    NSString * titleStr;
    
    if ([answerModel.mtype intValue] == 1) {
        
        titleStr = [[Tools getAnswerWithString:answerModel.mquestion]firstObject];
        CGSize size = [Tools getSizeWithString:titleStr withFont:[UIFont systemFontOfSize:16*SCREEN_SCALE] andSize:CGSizeMake(tableView.frame.size.width-20, 400)];
        
        height = size.height+20;
        
    }else{
        
        titleStr = answerModel.mquestion;
        CGSize size = [Tools getSizeWithString:titleStr withFont:[UIFont systemFontOfSize:16*SCREEN_SCALE] andSize:CGSizeMake(tableView.frame.size.width-20, 400)];
        
        height = size.height+20;
        
    }
    
    UIView  * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    headView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, SIZE.width-10, height-20)];
    //titleLabel.backgroundColor = [UIColor yellowColor];
    titleLabel.font = [UIFont systemFontOfSize:16 * SCREEN_SCALE];
    titleLabel.numberOfLines = 0;
    [headView addSubview:titleLabel];
    titleLabel.text = [NSString stringWithFormat:@"%d.%@",[self getQuestionNumber:tableView andCurrentPage:_currentPage],titleStr];
    return headView;

    
}

- (int)getQuestionNumber:(UITableView *)tableView andCurrentPage:(int)page{
    
    int pageNum = 0;
    
    if (tableView == leftTableView && _currentPage == 0) {
        pageNum = 1;
    }
    if (tableView == leftTableView && _currentPage > 0) {
        pageNum = page;
    }
    if (tableView == mainTableView && _currentPage == 0) {
        pageNum = 2;
    }
    if (tableView == mainTableView && _currentPage > 0 && _currentPage < _dataArray.count-1) {
        pageNum = page + 1;
    }
    if (tableView == mainTableView && _currentPage == _dataArray.count-1) {
        pageNum = page;
    }
    if (tableView == rightTableView && _currentPage == _dataArray.count-1) {
        pageNum = page + 1;
    }
    if (tableView == rightTableView && _currentPage < _dataArray.count-1) {
        pageNum = page + 2;
    }

    return pageNum;
}

//题目自适应高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    AnswerModel * answerModel = [self getModelWithTableView:tableView];
    
    CGFloat height;
    
    if ([answerModel.mtype intValue] == 1) {
        
        NSString * titleStr = [[Tools getAnswerWithString:answerModel.mquestion]firstObject];
        CGSize size = [Tools getSizeWithString:titleStr withFont:[UIFont systemFontOfSize:16*SCREEN_SCALE] andSize:CGSizeMake(tableView.frame.size.width-20, 400)];
        
        height = size.height+20;
        
    }else{
    
        NSString * titleStr = answerModel.mquestion;
        CGSize size = [Tools getSizeWithString:titleStr withFont:[UIFont systemFontOfSize:16*SCREEN_SCALE] andSize:CGSizeMake(tableView.frame.size.width-20, 400)];
        
        height = size.height+20;
    
    }
    
    if (height <= 80.0f) {
        
        return 80.0f;
        
    }else{
    
        return height;
    }

}

#pragma mark 脚视图封装
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    AnswerModel * answerModel = [self getModelWithTableView:tableView];
    
    CGFloat height;
    
    NSString * titleStr = answerModel.manswer;
    CGSize size = [Tools getSizeWithString:titleStr withFont:[UIFont systemFontOfSize:12*SCREEN_SCALE] andSize:CGSizeMake(tableView.frame.size.width-20, 400)];
    
    height = size.height+20;
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    view.backgroundColor = [UIColor yellowColor];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    AnswerModel * answerModel = [self getModelWithTableView:tableView];
    
    CGFloat height;
        
    NSString * titleStr = answerModel.manswer;
    CGSize size = [Tools getSizeWithString:titleStr withFont:[UIFont systemFontOfSize:12*SCREEN_SCALE] andSize:CGSizeMake(tableView.frame.size.width-20, 400)];
    
    height = size.height+20;
        
    
    return height;
}



#pragma mark 处理model和currentPage的逻辑
- (AnswerModel *)getModelWithTableView:(UITableView *)tableView{
    
    AnswerModel * answerModel;
    
    if (tableView == leftTableView && _currentPage == 0) {
        answerModel = _dataArray[_currentPage];
    }
    if (tableView == leftTableView && _currentPage > 0) {
        answerModel = _dataArray[_currentPage-1];
    }
    if (tableView == mainTableView && _currentPage == 0) {
        answerModel = _dataArray[_currentPage+1];
    }
    if (tableView == mainTableView && _currentPage > 0 && _currentPage < _dataArray.count-1) {
        answerModel = _dataArray[_currentPage];
    }
    if (tableView == mainTableView && _currentPage == _dataArray.count-1) {
        answerModel = _dataArray[_currentPage-1];
    }
    if (tableView == rightTableView && _currentPage == _dataArray.count-1) {
        answerModel = _dataArray[_currentPage];
    }
    if (tableView == rightTableView && _currentPage < _dataArray.count-1) {
        answerModel = _dataArray[_currentPage+1];
    }
    return answerModel;
}


#pragma mark - 实现scrollView的代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    CGPoint currentSizeOff = scrollView.contentOffset;
    
    self.currentPage = (int)currentSizeOff.x/SIZE.width;
    
    if (self.currentPage < _dataArray.count-1 && self.currentPage > 0) {
        
        _scrollView.contentSize = CGSizeMake(currentSizeOff.x+SIZE.width*2, SIZE.height);
        
        leftTableView.frame = CGRectMake(currentSizeOff.x-SIZE.width, 0, SIZE.width, SIZE.height);
        mainTableView.frame = CGRectMake(currentSizeOff.x, 0, SIZE.width, SIZE.height);
        rightTableView.frame = CGRectMake(currentSizeOff.x+SIZE.width, 0, SIZE.width, SIZE.height);
        
    }
    
    [self reloadData];
    
}

#pragma mark -重新加载表数据
- (void)reloadData{
    
    [leftTableView reloadData];
    [mainTableView reloadData];
    [rightTableView reloadData];

}

@end
