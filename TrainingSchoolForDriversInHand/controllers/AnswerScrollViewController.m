//
//  AnswerScrollViewController.m
//  TrainingSchoolForDriversInHand
//
//  Created by qianfeng on 15/12/9.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import "AnswerScrollViewController.h"
#import "AnswerScrollView.h"
#import "MyDataManager.h"
#import "AnswerModel.h"

@interface AnswerScrollViewController ()

@end

@implementation AnswerScrollViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //得到所有选择题的数据
    NSArray * _dataArray = [NSArray arrayWithArray:[MyDataManager readDataWithType:leaflevel]];
    
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    
    for (int i=0; i<_dataArray.count; i++) {
        AnswerModel * model = _dataArray[i];
        if ([model.pid intValue]==self.number+1) {
            [arr addObject:model];
        }
        
    }
    
    AnswerScrollView * asv = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) andDataArray:arr];
    
    [self.view addSubview:asv];
    
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
