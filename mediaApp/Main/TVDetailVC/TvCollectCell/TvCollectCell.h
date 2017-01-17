//
//  TvCollectCell.h
//  NewsTwoApp
//
//  Created by mengjianhua on 15/7/15.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TvCollectCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *TVCells;

-(void)setTVCCellontensInfo:(NSString *)TVCellsRow;

@end
