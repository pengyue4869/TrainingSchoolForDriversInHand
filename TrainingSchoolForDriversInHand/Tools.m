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

@end
