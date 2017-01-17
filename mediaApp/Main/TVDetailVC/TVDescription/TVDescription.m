//
//  TVDescription.m
//  NewsTwoApp
//
//  Created by mengjianhua on 15/7/15.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import "TVDescription.h"
#import "Macro.h"

#define LabelWIDE 150
#define LabelHEIGHT 20

@implementation TVDescription

-(void)setTVdescriptionInfo{
    
    NSMutableArray *AllTVInfoArray = [NSMutableArray arrayWithObjects:@"50集完",@"8.6分",@"2015",@"喜剧",@"内地",@"2015-05-16",@"332665886",@"芒果卫视、暴风影音、优酷...",@"张艺谋",@"潘长江、陆玲、...", nil];
    
    if (AllTVInfoArray.count >= 10) {
        //更新到
        self.video_UpdateTo = [[UILabel alloc] initWithFrame:CGRectMake(3, 5, LabelWIDE, 20)];
        self.video_UpdateTo.text = [NSString stringWithFormat:@"更新到：%@",AllTVInfoArray[0]];
        self.video_UpdateTo.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.video_UpdateTo];
        
        //评分
        self.video_Score = [[UILabel alloc] initWithFrame:CGRectMake(LabelWIDE+30, 5, LabelWIDE, 20)];
        self.video_Score.text = [NSString stringWithFormat:@"评分：%@",AllTVInfoArray[1]];
        self.video_Score.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.video_Score];
        
        //年份
        self.video_Years = [[UILabel alloc] initWithFrame:CGRectMake(3, 30, LabelWIDE+100, 20)];
        self.video_Years.text = [NSString stringWithFormat:@"年份：%@",AllTVInfoArray[2]];
        self.video_Years.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.video_Years];
        
        //类型
        self.video_Type = [[UILabel alloc] initWithFrame:CGRectMake(3, 55, LabelWIDE, 20)];
        self.video_Type.text = [NSString stringWithFormat:@"类型：%@",AllTVInfoArray[3]];
        self.video_Type.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.video_Type];
        
        //地区
        self.video_Area = [[UILabel alloc] initWithFrame:CGRectMake(LabelWIDE+30, 55, LabelWIDE, 20)];
        self.video_Area.text = [NSString stringWithFormat:@"地区：%@",AllTVInfoArray[4]];
        self.video_Area.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.video_Area];
        
        //更新
        self.video_UpdateTime = [[UILabel alloc] initWithFrame:CGRectMake(3, 80, LabelWIDE, 20)];
        self.video_UpdateTime.text = [NSString stringWithFormat:@"更新：%@",AllTVInfoArray[5]];
        self.video_UpdateTime.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.video_UpdateTime];
        
        //人气
        self.video_Popularity = [[UILabel alloc] initWithFrame:CGRectMake(LabelWIDE+30, 80, LabelWIDE, 20)];
        self.video_Popularity.text = [NSString stringWithFormat:@"人气：%@",AllTVInfoArray[6]];
        self.video_Popularity.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.video_Popularity];
        
        //来源
        self.video_SourceFrom = [[UILabel alloc] initWithFrame:CGRectMake(3, 105, LabelWIDE+150, 20)];
        self.video_SourceFrom.text = [NSString stringWithFormat:@"来源：%@",AllTVInfoArray[7]];
        self.video_SourceFrom.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.video_SourceFrom];
        
        //分割线1
        UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 135, 314, 1)];
        lb1.backgroundColor = RGBA(72, 161, 255, 1);
        [self addSubview:lb1];
        
        //导演
        self.video_Director = [[UILabel alloc] initWithFrame:CGRectMake(3, 150, LabelWIDE+150, 20)];
        self.video_Director.text = [NSString stringWithFormat:@"导演：%@",AllTVInfoArray[8]];
        self.video_Director.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.video_Director];
        
        //主演
        self.video_Actor = [[UILabel alloc] initWithFrame:CGRectMake(3, 180, LabelWIDE+150, 20)];
        self.video_Actor.text = [NSString stringWithFormat:@"主演：%@",AllTVInfoArray[9]];
        self.video_Actor.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.video_Actor];

    }
    
    //分割线2
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(3, 205, 314, 1)];
    lb2.backgroundColor = RGBA(72, 161, 255, 1);
    [self addSubview:lb2];
    
    //剧情标题
    UILabel *lb3 = [[UILabel alloc] initWithFrame:CGRectMake(3, 220, LabelWIDE, 20)];
    lb3.text = @"剧情详情";
    lb3.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [self addSubview:lb3];

    //剧情
    self.video_Drama = [[UILabel alloc] initWithFrame:CGRectMake(3, 230, 314, 140)];
    self.video_Drama.text = @"奔跑吧兄弟，是浙江卫视引进韩版推出的大型户外竞技真人秀节目，由浙江卫视和韩版制作团队韩国SBS联合制作,奔跑吧兄弟，是浙江卫视引进韩版推出的大型户外竞技真人秀节目，由浙江卫视和韩版制作团队韩国SBS联合制作,奔跑吧兄弟，是浙江卫视引进韩版推出的大型户外竞技真人秀节目，由浙江卫视和韩版制作团队韩国SBS联合制作,奔跑吧兄弟，是浙江卫视引进韩版推出的大型户外竞技真人秀节目，由浙江卫视和韩版制作团队韩国SBS联合制作";
    self.video_Drama.font = [UIFont systemFontOfSize:15];
    [self.video_Drama setNumberOfLines:6];
    [self.video_Drama setLineBreakMode:NSLineBreakByTruncatingTail];
    [self addSubview:self.video_Drama];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
