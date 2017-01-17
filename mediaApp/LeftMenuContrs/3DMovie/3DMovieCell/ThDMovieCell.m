//
//  ThDMovieCell.m
//  NewsTwoApp
//
//  Created by 蒙建华 on 15/7/6.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import "ThDMovieCell.h"

@implementation ThDMovieCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellContenArry:(NSMutableArray *)movieMsgArry{
    
    self.MovieImg.image = movieMsgArry[0];
    self.movieName.text = movieMsgArry[1];
    self.movieDescription.text = movieMsgArry[2];
}

@end
