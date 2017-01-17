//
//  VideoCell.h
//  NewsTwoApp
//
//  Created by mengjianhua on 15/7/8.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCell : UICollectionViewCell
//视频图片
@property (strong, nonatomic) IBOutlet UIImageView *videoImg;
//视频名称
@property (strong, nonatomic) IBOutlet UILabel *videoName;
//视频人气
@property (strong, nonatomic) IBOutlet UILabel *videoPopulatar;

-(void)initVideoSubviews:(NSArray *)CellInfoArray;

@end
