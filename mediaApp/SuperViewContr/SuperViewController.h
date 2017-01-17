//
//  SuperViewController.h
//  CloudShop
//
//  Created by meng jianhua on 14-3-27.
//  Copyright (c) 2014年 mengjianhua. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_IPHONE_5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define NomalBgColor [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]
#define SuperBackButtonTag 1000000

@interface SuperViewController : UIViewController

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;

-(void)superBackButtonTouchEvent:(UIButton *)btn;

-(void)AlertLogMsg:(NSString *)logMsg;

//push视图
-(void)pushVC:(UIViewController *)ViewVC;

@end
