//
//  AppDelegate.h
//  mediaApp
//
//  Created by hpking　 on 2017/1/17.
//  Copyright © 2017年 hpking　. All rights reserved.
//

#import <UIKit/UIKit.h>

// 3.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

// 4.屏幕大小尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

