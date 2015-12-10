//
//  Tools.m
//  TrainingSchoolForDriversInHand
//
//  Created by qianfeng on 15/12/9.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (NSArray *)getAnswerWithString:(NSString *)str{
    
    NSMutableArray * array = [[NSMutableArray alloc]init];
    NSArray * arr = [str componentsSeparatedByString:@"<BR>"];
    [array addObject:arr[0]];
    
    for (int i=0; i<4; i++) {
        
        [array addObject:[arr[i+1] substringFromIndex:2]];//不包括选项中的标号
        
    }
    
    //这个数据中包括题目和4个选择
    return array;

}

+ (CATransition *)createAnimationWithIndexOfAnimation:(NSInteger)index andDirection:(NSString *)direction andTime:(float)time{
    
    /*动画效果详解：
     #import <QuartzCore/QuartzCore.h>(一定要加入此库)
    1.模块翻转；2.深入深处 3.淡入淡出 4.默认 5.翻页 6.反翻页 7.吸效果 8.水滴效果 9.旋转
     */
    
    NSArray * array = @[@"cube",@"moveIn",@"reveal",@"fade",@"pageCurl",@"pageUnCurl",@"suckEffect",@"rippleEffect",@"oglFlip"];
    CATransition * tranaition = [CATransition animation];
    if (index<=9&&index>=1) {
        tranaition.type = [array objectAtIndex:index-1];
    }else{
        tranaition.type = [array lastObject];
    }
    tranaition.subtype = direction;
    tranaition.duration = time;
    
    return tranaition;
    
}

+ (CGSize)getSizeWithString:(NSString *)str withFont:(UIFont *)font andSize:(CGSize)size{

    CGSize newSize;
    
    CGRect newRect = [str boundingRectWithSize:CGSizeMake(size.width, 9999999999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    newSize = newRect.size;
    NSLog(@"高：%lf",newSize.height);
    return newSize;

}

@end
