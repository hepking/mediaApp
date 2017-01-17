//
//  FeedbackViewController.m
//  CloudShop
//
//  Created by mengjianhua on 14-11-18.
//  Copyright (c) 2014年 mengjianhua. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"反馈";
    self.FeedbackView = [[UITextView alloc] initWithFrame:CGRectMake(0, 65, 320, 180)];
    self.FeedbackView.delegate = self;
    self.FeedbackView.font = [UIFont fontWithName:nil size:17];//字体设置
    UIColor *testColor1= [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    self.FeedbackView.backgroundColor = testColor1;
    [self.view resignFirstResponder];
    [self.view addSubview:self.FeedbackView];
    
    UIButton  *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 20,45, 40)];
	nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [nextButton addTarget:self action:@selector(commitConten) forControlEvents:UIControlEventTouchUpInside];
    [nextButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:nextButton];
    
}

//提交反馈信息
-(void)commitConten{
        
    if ([@"" isEqualToString:self.FeedbackView.text] || self.FeedbackView.text == NULL || [self.FeedbackView.text length] == 0) {
        [self AlertLogMsg:@"空内容"];
    }else{
        [self AlertLogMsg:self.FeedbackView.text];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
