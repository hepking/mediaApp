//
//  TvCollectCell.m
//  NewsTwoApp
//
//  Created by mengjianhua on 15/7/15.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import "TvCollectCell.h"

@implementation TvCollectCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"TvCollectCell" owner:self options:nil];
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


-(void)setTVCCellontensInfo:(NSString *)TVCellsRow{
    self.TVCells.text = TVCellsRow;
}
@end
