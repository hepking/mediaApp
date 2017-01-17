//
//  VideoCell.m
//  NewsTwoApp
//
//  Created by mengjianhua on 15/7/8.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"VideoCell" owner:self options:nil];
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

-(void)initVideoSubviews:(NSArray *)CellInfoArray{

    if (CellInfoArray.count >= 3) {
        self.videoImg = CellInfoArray[0];
        self.videoName.text = CellInfoArray[1];
        self.videoPopulatar.text = [NSString stringWithFormat:@"人气:%@",CellInfoArray[2]];
    }
}

@end
