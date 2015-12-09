//
//  AnswerScrollViewController.m
//  TrainingSchoolForDriversInHand
//
//  Created by qianfeng on 15/12/9.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import "AnswerScrollViewController.h"
#import "AnswerScrollView.h"


@interface AnswerScrollViewController ()

@end

@implementation AnswerScrollViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _dataArray = @[@"1",@"2",@"3",@"4",@"5"];
    
    AnswerScrollView * asv = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) andDataArray:_dataArray];
    
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
