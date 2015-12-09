//
//  Tools.h
//  TrainingSchoolForDriversInHand
//
//  Created by qianfeng on 15/12/9.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

//处理数据库中题目数据
+ (NSArray *)getAnswerWithString:(NSString *)str;

@end
