//
//  AnswerTableViewCell.h
//  TrainingSchoolForDriversInHand
//
//  Created by qianfeng on 15/12/9.
//  Copyright © 2015年 pytest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *numberImage;

@end
