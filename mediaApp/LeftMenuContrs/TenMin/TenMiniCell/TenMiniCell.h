//
//  TenMiniCell.h
//  NewsTwoApp
//
//  Created by mengjianhua on 15/7/15.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TenMiniCell : UITableViewCell

//视频图标
@property (strong, nonatomic) IBOutlet UIImageView *videoIcom;
//视频名称
@property (strong, nonatomic) IBOutlet UILabel *videoName;
//视频播放次数
@property (strong, nonatomic) IBOutlet UILabel *videoPlays;


-(void)setCellContence:(NSArray *)VideoInfoArray;

@end
