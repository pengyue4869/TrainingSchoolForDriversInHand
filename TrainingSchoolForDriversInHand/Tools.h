//
//  Tools.h
//  TrainingSchoolForDriversInHand
//
//  Created by qianfeng on 15/12/9.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject

//处理数据库中题目数据
+ (NSArray *)getAnswerWithString:(NSString *)str;

//翻页动画
+ (CATransition *)createAnimationWithIndexOfAnimation:(NSInteger)index andDirection:(NSString *)direction andTime:(float)time;

//文字，字体大小，自适应的范围
+ (CGSize)getSizeWithString:(NSString *)str withFont:(UIFont *)font andSize:(CGSize)size;

@end
