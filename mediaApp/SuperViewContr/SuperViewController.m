//
//  SuperViewController.m
//  CloudShop
//
//  Created by meng jianhua on 15-7-6.
//  Copyright (c) 2015年 mengjianhua. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()

@end

@implementation SuperViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = NomalBgColor;
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    titleImageView.image = [UIImage imageNamed:@"bg_title_bar"];
    titleImageView.userInteractionEnabled = YES;
    [self.view addSubview:titleImageView];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 25,45, 35)];
    self.backButton.tag = SuperBackButtonTag;
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"back_up@2x"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(superBackButtonTouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    [titleImageView addSubview:self.backButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 25, 160, 35)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [titleImageView addSubview:self.titleLabel];

}

-(void)superBackButtonTouchEvent:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)pushVC:(UIViewController *)ViewVC{
    [self.navigationController pushViewController:ViewVC animated:YES];
}

-(void)AlertLogMsg:(NSString *)logMsg{
    NSLog(@"您选择了%@",logMsg);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:logMsg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
