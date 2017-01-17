//
//  ThDMovieCell.h
//  NewsTwoApp
//
//  Created by 蒙建华 on 15/7/6.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThDMovieCell : UITableViewCell

-(void)setCellContenArry:(NSMutableArray *)movieMsgArry;

@property (strong, nonatomic) IBOutlet UIImageView *MovieImg;
@property (strong, nonatomic) IBOutlet UILabel *movieName;
@property (strong, nonatomic) IBOutlet UILabel *movieDescription;

@end
