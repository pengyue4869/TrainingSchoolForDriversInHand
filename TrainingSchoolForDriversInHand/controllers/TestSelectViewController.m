//
//  TestSelectViewController.m
//  TrainingSchoolForDriversInHand
//
//  Created by qianfeng on 15/12/8.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import "TestSelectViewController.h"
#import "TestSelectTableViewCell.h"
#import "TestSelectModel.h"
#import "AnswerScrollViewController.h"


@interface TestSelectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView * _tabelView;
    
    
}
@end

@implementation TestSelectViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //取消延展性
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //实现复用cell表格
    self.title = _myTitle;
    
    
    [self createTableView];
    
   // _answerSV = [[AnswerScrollView alloc]initWithFrame:self.view.frame andDataArray:nil];
   // [self.view addSubview:_answerSV];
   // _answerSV.alpha = 0;
    
}

#pragma mark - 创建选题表
- (void)createTableView{

    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    
    [self.view addSubview:_tabelView];

}

#pragma mark - 实现选题表的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80.0f*SCREEN_SCALE;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    static NSString * cellID = @"TestSelectTableViewCell";
    TestSelectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TestSelectTableViewCell" owner:self options:nil]lastObject];
        
        //选择样式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //切圆角
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius = 8.0f;
        
    }
    
    TestSelectModel * model = [_dataArray objectAtIndex:indexPath.row];
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.titleLabel.text = model.pname;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController pushViewController:[[AnswerScrollViewController alloc]init] animated:YES];
        }
            
            break;
            
        default:
            break;
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
