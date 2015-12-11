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
    //记录每道题的答题情况，即选择的哪个
    NSMutableArray * _answerArray;

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
        
        //记录每道题的答题情况
        _answerArray = [[NSMutableArray alloc]init];
        for (int i=0; i<dataArray.count; i++) {
            [_answerArray addObject:@"0"];
        }
        
        _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
        _scrollView.backgroundColor = [UIColor colorWithRed:1.0 green:0.76 blue:0.84 alpha:1];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        if (_dataArray.count>1) {
            _scrollView.contentSize = CGSizeMake(SIZE.width*2, SIZE.height);
        }
        
        
        leftTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        leftTableView.bounces = NO;
        leftTableView.delegate = self;
        leftTableView.dataSource = self;
        
        mainTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        mainTableView.bounces = NO;
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        
        rightTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        rightTableView.bounces = NO;
        rightTableView.delegate = self;
        rightTableView.dataSource = self;
        
        [self createUI];
    
        [self createToolBar];
        
    }
    
    return self;
    
}

- (void)createToolBar{
    
    UIView * toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, SIZE.height-60, SIZE.width, 60)];
    
    toolBarView.backgroundColor = [UIColor colorWithRed:250/255.0f green:240/255.0f blue:130/255.0f alpha:1];
    
    NSArray * array = @[@"1111",@"查看答案",@"收藏本题"];
    
    for (int i=0; i<3; i++) {
        
        UIButton * but = [[UIButton alloc]initWithFrame:CGRectMake((SIZE.width-36*3)/4*(i+1)+i*36, 2, 36, 36)];
        [but setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png",16+i]] forState:UIControlStateNormal];
        [but setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",16+i]] forState:UIControlStateHighlighted];
        but.tag = 100 + i;
        //点击底部视图按钮
        [but addTarget:self action:@selector(toolBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [toolBarView addSubview:but];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(but.center.x-30, 39, 60, 18)];
        label.text = array[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
        [toolBarView addSubview:label];
        
    }
    
    [self addSubview:toolBarView];

}

#pragma mark -点击底部视图按钮
- (void)toolBarButtonClick:(UIButton *)but{
    
    switch (but.tag) {
        case 100:

            break;
            
        case 101:
            
            if ([_answerArray[_currentPage] intValue]!=0) {
                
                return;
                
            }else{
                
                //NSLog(@"%d",[[_dataArray[_currentPage] manswer] characterAtIndex:0]-64);
                [_answerArray replaceObjectAtIndex:_currentPage withObject:[NSString stringWithFormat:@"%d",[[_dataArray[_currentPage] manswer] characterAtIndex:0]-64]];
            
                [self reloadData];
                
            }
            
            break;
            
        case 102:
            
            NSLog(@"收藏本题");
            break;
            
        default:
            break;
    }

}


- (void)createUI{
    
    leftTableView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    mainTableView.frame = CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
    rightTableView.frame = CGRectMake(SIZE.width*2, 0, SIZE.width, SIZE.height);
    
    leftTableView.backgroundColor = [UIColor clearColor];
    mainTableView.backgroundColor = [UIColor clearColor];
    rightTableView.backgroundColor = [UIColor clearColor];
    
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
    cell.numberImage.hidden = YES;
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AnswerTableViewCell" owner:self options:nil]lastObject];
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius = 10;
    }
    
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    AnswerModel * answerModel = [self getModelWithTableView:tableView];
    
    if ([answerModel.mtype intValue]==1) {
        cell.numberLabel.text = [NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];
        cell.answerLabel.text = [Tools getAnswerWithString:answerModel.mquestion][indexPath.row+1];
    }
    
    
    int page = [self getQuestionNumber:tableView andCurrentPage:_currentPage];
    
    if ([_answerArray[page-1]intValue]!=0) {
        if ([answerModel.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+(int)indexPath.row]]) {
            cell.numberImage.hidden = NO;
            cell.numberImage.image = [UIImage imageNamed:@"19"];
        }
        if (![answerModel.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+[_answerArray[page-1] intValue]-1]] && indexPath.row == [_answerArray[page-1] intValue]-1) {
            cell.numberImage.hidden = NO;
            cell.numberImage.image = [UIImage imageNamed:@"20"];
        }
    }else{
    
        cell.numberImage.hidden = YES;
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    int page = [self getQuestionNumber:tableView andCurrentPage:_currentPage];
    
    //这道题已经答过
    if ([_answerArray[page-1] intValue] != 0) {
        
        NSLog(@"%d",[_answerArray[page-1] intValue]);
        
        return;
        
    }else{
        
        //这道题没有答过，但是这里要记录点击的
        [_answerArray replaceObjectAtIndex:page-1 withObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
        //NSLog(@"记录");
    }
    
    [self reloadData];

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
    headView.backgroundColor = [UIColor colorWithRed:80/255.0f green:200/255.0f blue:170/255.0f alpha:1];
    
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
    
    NSString * titleStr = [NSString stringWithFormat:@"答案解析:%@",answerModel.mdesc];
    CGSize size = [Tools getSizeWithString:titleStr withFont:[UIFont systemFontOfSize:12*SCREEN_SCALE] andSize:CGSizeMake(tableView.frame.size.width-20, 400)];
    
    height = size.height+20;
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    //view.backgroundColor = [UIColor yellowColor];
    
    UILabel * descLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, SIZE.width-10, height-10)];
    descLabel.text = titleStr;
    descLabel.font = [UIFont systemFontOfSize:12*SCREEN_SCALE];
    descLabel.numberOfLines = 0;
    descLabel.textColor = [UIColor darkGrayColor];
    [view addSubview:descLabel];
    
    if([_answerArray[[self getQuestionNumber:tableView andCurrentPage:_currentPage]-1]intValue]!=0){
        return view;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    AnswerModel * answerModel = [self getModelWithTableView:tableView];
    
    CGFloat height;
        
    NSString * titleStr = [NSString stringWithFormat:@"答案解析:%@",answerModel.mdesc];
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
    
    int page = (int)currentSizeOff.x/SIZE.width;
    
    if (page < _dataArray.count-1 && page > 0) {
        
        _scrollView.contentSize = CGSizeMake(currentSizeOff.x+SIZE.width*2, SIZE.height);
        
        leftTableView.frame = CGRectMake(currentSizeOff.x-SIZE.width, 0, SIZE.width, SIZE.height);
        mainTableView.frame = CGRectMake(currentSizeOff.x, 0, SIZE.width, SIZE.height);
        rightTableView.frame = CGRectMake(currentSizeOff.x+SIZE.width, 0, SIZE.width, SIZE.height);
        
    }
    
    _currentPage = page;
    //NSLog(@"当前是第：%d页",_currentPage);
    
    [self reloadData];
    
}

#pragma mark -重新加载表数据
- (void)reloadData{
    
    [leftTableView reloadData];
    [mainTableView reloadData];
    [rightTableView reloadData];

}

@end
