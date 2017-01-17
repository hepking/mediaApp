//
//  FeedbackViewController.h
//  CloudShop
//
//  Created by mengjianhua on 14-11-18.
//  Copyright (c) 2014年 mengjianhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
@interface FeedbackViewController : SuperViewController <UITextViewDelegate>

//反馈内容
@property (strong, nonatomic) UITextView *FeedbackView;

@end
