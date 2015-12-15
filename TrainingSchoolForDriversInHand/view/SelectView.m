//
//  SelectView.m
//  TrainingSchoolForDriversInHand
//
//  Created by qianfeng on 15/12/7.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import "SelectView.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
#define BUTSIZE (WIDTH-20*5)/4
#define BUTBETWEEN 20.0f

@interface SelectView ()
{
    UIButton * _button;//反对票买好票付款后配套费
}
@end

@implementation SelectView

- (instancetype)initWithFrame:(CGRect)frame andButton:(UIButton *)but{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        _button = but;
        [self createButtons];
        
    }
    
    return self;

}

- (void)createButtons{
    
    for (int i=0; i<4; i++) {
        
        UIButton * bt = [UIButton buttonWithType:UIButtonTypeSystem];
        bt.frame = CGRectMake(BUTBETWEEN*(i+1)+BUTSIZE*i, HEIGHT-BUTSIZE-20, BUTSIZE, BUTSIZE);
        [bt setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bt];
        
    }
    
}

- (void)buttonClick:(UIButton *)but{
    
    [_button setBackgroundImage:[but imageForState:UIControlStateNormal] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}

@end
