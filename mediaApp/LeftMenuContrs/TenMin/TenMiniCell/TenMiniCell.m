//
//  TenMiniCell.m
//  NewsTwoApp
//
//  Created by mengjianhua on 15/7/15.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import "TenMiniCell.h"

@implementation TenMiniCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellContence:(NSArray *)VideoInfoArray{
/*
 videoIcom
 videoName
 videoPlays
 */
    if (VideoInfoArray.count >=3) {
        self.videoIcom.image = VideoInfoArray[0];
        self.videoName.text = VideoInfoArray[1];
        self.videoPlays.text = VideoInfoArray[2];
    }
}

@end
