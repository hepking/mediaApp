//
//  TVDescription.h
//  NewsTwoApp
//
//  Created by mengjianhua on 15/7/15.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVDescription : UIView

//更新到
@property (strong, nonatomic) IBOutlet UILabel *video_UpdateTo;
//评分
@property (strong, nonatomic) IBOutlet UILabel *video_Score;
//年份
@property (strong, nonatomic) IBOutlet UILabel *video_Years;
//类型
@property (strong, nonatomic) IBOutlet UILabel *video_Type;
//地区
@property (strong, nonatomic) IBOutlet UILabel *video_Area;
//更新时间
@property (strong, nonatomic) IBOutlet UILabel *video_UpdateTime;
//人气
@property (strong, nonatomic) IBOutlet UILabel *video_Popularity;
//来源
@property (strong, nonatomic) IBOutlet UILabel *video_SourceFrom;
//导演
@property (strong, nonatomic) IBOutlet UILabel *video_Director;
//主演
@property (strong, nonatomic) IBOutlet UILabel *video_Actor;
//剧情详情
@property (strong, nonatomic) IBOutlet UILabel *video_Drama;

-(void)setTVdescriptionInfo;

@end
