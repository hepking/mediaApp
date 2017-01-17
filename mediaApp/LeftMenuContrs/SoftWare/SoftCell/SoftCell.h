//
//  SoftCell.h
//  NewsTwoApp
//
//  Created by 蒙建华 on 15/7/19.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoftCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *installBtn;

-(void)setSoftCellContence:(NSArray *)softInfoArray;

@end
