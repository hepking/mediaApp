//
//  VideoDetailController.h
//  NewsTwoApp
//
//  Created by mengjianhua on 15/7/7.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@interface VideoDetailController : SuperViewController


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

//存放下面视频属性的数组
@property (strong, nonatomic) NSMutableArray *videoInfosArray;

//视频icon
@property (strong, nonatomic) IBOutlet UIButton *videoDetail_Icon;
//主演
@property (strong, nonatomic) IBOutlet UILabel *video_Actor;
//地区
@property (strong, nonatomic) IBOutlet UILabel *video_Area;
//人气
@property (strong, nonatomic) IBOutlet UILabel *video_Popularity;
//年份
@property (strong, nonatomic) IBOutlet UILabel *video_Years;
//评分
@property (strong, nonatomic) IBOutlet UILabel *video_Score;
//类型
@property (strong, nonatomic) IBOutlet UILabel *video_Type;
//更新时间
@property (strong, nonatomic) IBOutlet UILabel *video_UpdateTime;
//导演
@property (strong, nonatomic) IBOutlet UILabel *video_Director;
//剧情
@property (strong, nonatomic) IBOutlet UILabel *video_Drama;

@end
