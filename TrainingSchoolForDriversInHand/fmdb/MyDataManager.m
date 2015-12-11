//
//  MyDataManager.m
//  TrainingSchoolForDriversInHand
//
//  Created by qianfeng on 15/12/8.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import "MyDataManager.h"
#import "TestSelectModel.h"
#import "AnswerModel.h"

@implementation MyDataManager

+ (NSArray *)readDataWithType:(DataType)type{

    static FMDatabase * dataBase;
    NSMutableArray * dataArray = [[NSMutableArray alloc]init];
    
    if (dataBase == nil) {
        
        NSString * path = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"sqlite"];
        dataBase = [[FMDatabase alloc]initWithPath:path];
        
    }
    
    if ([dataBase open]) {
       // NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开数据库失败");
        return dataArray;
    }
    
    switch (type) {
        case chapter:
        {
            
            NSString * sql = @"select pid,pname,pcount from firstlevel";
            FMResultSet * rs = [dataBase executeQuery:sql];
            while ([rs next]) {
                
                TestSelectModel * model = [[TestSelectModel alloc]init];
                
                model.pid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pid"]];
                model.pname = [rs stringForColumn:@"pname"];
                model.pcount = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pcount"]];
                
                [dataArray addObject:model];
                
            }
        
        }
            break;
        case leaflevel:
        {
            
            NSString * sql = @"select mquestion,mdesc,mid,manswer,mimage,pid,pname,sid,sname,mtype from leaflevel";
            
            FMResultSet * rs = [dataBase executeQuery:sql];
            while ([rs next]) {
                
                AnswerModel * model = [[AnswerModel alloc]init];
                
                model.mquestion = [rs stringForColumn:@"mquestion"];
                model.mdesc = [rs stringForColumn:@"mdesc"];
                model.mid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"mid"]];
                model.manswer = [rs stringForColumn:@"manswer"];
                model.mimage = [rs stringForColumn:@"mimage"];
                model.pid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pid"]];
                model.pname = [rs stringForColumn:@"pname"];
                model.sid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"sid"]];
                model.sname = [NSString stringWithFormat:@"sname"];
                model.mtype = [NSString stringWithFormat:@"%d",[rs intForColumn:@"mtype"]];
                
                [dataArray addObject:model];
                
            }
            
        }
            break;
            
        default:
            break;
    }
    
    
    return dataArray;
    
}

@end
