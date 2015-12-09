//
//  MyDataManager.h
//  TrainingSchoolForDriversInHand
//
//  Created by qianfeng on 15/12/8.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

typedef enum{
    
    chapter//章节练习数据
    
}DataType;

@interface MyDataManager : NSObject

+ (NSArray *)readDataWithType:(DataType)type;

@end
