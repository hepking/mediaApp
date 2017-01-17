//
//  MovieCell.h
//  NewsTwoApp
//
//  Created by mengjianhua on 15/7/8.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UICollectionViewCell

//电影图标
@property (strong, nonatomic) IBOutlet UIImageView *movi_Image;
//电影名称
@property (strong, nonatomic) IBOutlet UILabel *movie_Name;
//电影人气
@property (strong, nonatomic) IBOutlet UILabel *movie_Popular;

-(void)initSubviews:(NSArray *)CellInfoArray;

@end
