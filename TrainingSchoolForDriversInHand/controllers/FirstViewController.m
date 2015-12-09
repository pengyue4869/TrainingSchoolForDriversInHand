//
//  FirstViewController.m
//  TrainingSchoolForDriversInHand
//
//  Created by qianfeng on 15/12/7.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstTableViewCell.h"
#import "TestSelectViewController.h"
#import "MyDataManager.h"

@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView * _tableView;
    NSArray * _dataArray;
    
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建表格
    [self createTabelView];
    
    //初始化数据源
    _dataArray = @[@"章节练习",@"顺序练习",@"随机练习",@"专项练习",@"仿真模拟练习"];
    [self createView];
}

#pragma mark - 创建表下面的控件
- (void)createView{

    UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height-64-140, 300, 30)];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = [UIColor grayColor];
    lb.text = @"················我的考试分析················";
    
    [self.view addSubview:lb];
    
    CGFloat HSpace = (self.view.frame.size.width-4*60)/5;
    
    
    NSArray * titleArray = @[@"我的错题",@"我的收藏",@"我的成绩",@"练习统计"];
    
    for (int i=0; i<4; i++) {
        
        UIButton * bt = [UIButton buttonWithType:UIButtonTypeSystem];
        bt.frame = CGRectMake(HSpace*(i+1)+60*i, self.view.frame.size.height-64-90, 60, 60);
        [bt setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+12]] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(btClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:bt];
        
        UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(HSpace*(i+1)+60*i, self.view.frame.size.height-64-30, 60, 30)];
        lb.text = titleArray[i];
        lb.font = [UIFont systemFontOfSize:11.0f];
        lb.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lb];
        
    }
    
}





#pragma mark - 创建表下面的控件的点击事件
- (void)btClicked:(UIButton *)but{
    

}


#pragma mark - 创建表格视图
- (void)createTabelView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];

}

#pragma mark - 实现表格的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellID = @"FirstTableViewCell";
    
    FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FirstTableViewCell" owner:self options:nil]firstObject];
    }
    
    [cell.myImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",indexPath.row+7]]];
    cell.myLabel.text = _dataArray[indexPath.row];
    
    return cell;
    
}


#pragma mark - 点击cell将要触发的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {
        
            TestSelectViewController * tvc = [[TestSelectViewController alloc]init];
            
            //从数据库中拿到数据源
            tvc.dataArray = [MyDataManager readDataWithType:chapter];
            
            tvc.myTitle = _dataArray[indexPath.row];
            
            tvc.navigationItem.leftBarButtonItem = [self createBackButton];

            [self.navigationController pushViewController:tvc animated:YES];
        
        }
            break;
            
        default:
            break;
    }

}


#pragma mark - 自定义返回按钮
- (UIBarButtonItem *)createBackButton{
    
    UIButton * ITB = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [ITB addTarget:self action:@selector(backBUttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [ITB setBackgroundImage:[UIImage imageNamed:@"首页-返回.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:ITB];
    
    return item;
    
}

- (void)backBUttonClick:(UIButton *)but{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
