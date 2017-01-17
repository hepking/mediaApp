//
//  SliderViewController.h
//  LeftRightSlider
//
//  Created by Zhao Yiqi on 13-11-27.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderViewController : UIViewController

@property(nonatomic,strong)UIViewController *LeftVC;
@property(nonatomic,strong)UIViewController *RightVC;
@property(nonatomic,strong)UIViewController *MainVC;

@property(nonatomic,strong)NSMutableDictionary *controllersDict;

//左右宽度
@property(nonatomic,assign)float LeftSContentOffset;
@property(nonatomic,assign)float RightSContentOffset;

//淡出比例（宽比高）
@property(nonatomic,assign)float LeftSContentScale;
@property(nonatomic,assign)float RightSContentScale;


@property(nonatomic,assign)float LeftSJudgeOffset;
@property(nonatomic,assign)float RightSJudgeOffset;

@property(nonatomic,assign)float LeftSOpenDuration;
@property(nonatomic,assign)float RightSOpenDuration;

@property(nonatomic,assign)float LeftSCloseDuration;
@property(nonatomic,assign)float RightSCloseDuration;

@property(nonatomic,assign)BOOL canShowLeft;
@property(nonatomic,assign)BOOL canShowRight;

+ (SliderViewController*)sharedSliderController;

- (void)showContentControllerWithModel:(NSString*)className;
- (void)showLeftViewController;
- (void)showRightViewController;

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes;

@end
