//
//  ViewController.m
//  TrainingSchoolForDriversInHand
//
//  Created by qianfeng on 15/12/7.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import "ViewController.h"
#import "SelectView.h"
#import "FirstViewController.h"

@interface ViewController ()
{
    SelectView * _selectView;
    __weak IBOutlet UIButton *_selectBut;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _selectView = [[SelectView alloc]initWithFrame:self.view.frame andButton:_selectBut];
    [self.view addSubview:_selectView];
    _selectView.alpha = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectButClick:(UIButton *)sender {
    
    
    switch (sender.tag) {
        case 100:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _selectView.alpha = 1;
            }];
        }
            break;
        case 101:
        {
            
            FirstViewController * first = [[FirstViewController alloc]init];
            first.title = @"科目一:理论考试";
            first.navigationItem.leftBarButtonItem = [self createBackButton];
            [self.navigationController pushViewController:first animated:YES];
            
        }
            break;
        case 102:
        {
            
        }
            break;
        case 103:
        {
            
        }
            break;
        case 104:
        {
            
        }
            break;
        case 105:
        {
            
        }
            break;
        case 106:
        {
            
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

@end
