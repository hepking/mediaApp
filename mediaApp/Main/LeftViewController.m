//
//  LeftViewController.m
//  WYApp
//
//  Created by meng on 14-7-17.
//  Copyright (c) 2014年 meng. All rights reserved.
//

#import "LeftViewController.h"
#import "MineViewController.h"
#import "FeedbackViewController.h"
#import "SetViewController.h"
#import "TenMinViewController.h"
#import "ThDMovieViewController.h"
#import "SoftWareViewController.h"
#import "GameViewController.h"
#import "VideoDetailController.h"

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, readwrite, nonatomic) UITableView *tableView;

//菜单数据
@property (strong, readwrite, nonatomic) NSArray *titlesDataSuorse;
@property (strong, readwrite, nonatomic) NSArray *imagesDataSuorse;

@end

@implementation LeftViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.titlesDataSuorse = [[NSArray alloc] init];
        self.imagesDataSuorse = [[NSArray alloc] init];
        
        _titlesDataSuorse = @[@"我的收藏", @"10分钟", @"3D影院", @"软件精选", @"游戏频道"];
        _imagesDataSuorse = @[@"myFav_normal", @"tenMin_normal", @"3D_normal", @"slide_menu_1@2x", @"nav_game_n"];

    }
    return self;
}

- (void)viewDidLoad
{
    [self.view setFrame:self.view.bounds];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *imageBgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    [imageBgV setBackgroundColor:RGBA(20.f, 80.f, 110.f, 1)];
    [imageBgV setImage:[UIImage imageNamed:@"channelbg@2x"]];
    [self.view addSubview:imageBgV];
    
    //个人中心
    UIButton *mebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mebtn setFrame:CGRectMake(15,30, 50, 50)];
    [mebtn setImage:[UIImage imageNamed:@"loginBtn_head"] forState:UIControlStateNormal];
    [mebtn addTarget:self action:@selector(mebtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mebtn];

    //登录
    UIButton *loginbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginbtn setFrame:CGRectMake(60,30, 70, 25)];
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    loginbtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [loginbtn addTarget:self action:@selector(loginbtnAction:) forControlEvents:UIControlEventTouchUpInside];
    loginbtn.showsTouchWhenHighlighted = YES;
    [self.view addSubview:loginbtn];

    //lbbtn
    UIButton *warningbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [warningbtn setFrame:CGRectMake(loginbtn.frame.origin.x,loginbtn.frame.origin.y+22, 150, 25)];
    [warningbtn setTitle:@"登录查看播放记录" forState:UIControlStateNormal];
    warningbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [warningbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:warningbtn];

    
    //设置
    UIButton *setbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [setbtn setFrame:CGRectMake(10,self.view.frame.size.height-50, 80, 30)];
    [setbtn setTitle:@"  设置" forState:UIControlStateNormal];
    setbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [setbtn addTarget:self action:@selector(setbtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setbtn];
    
    //设置图标
    UIButton *setbtnImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [setbtnImg setFrame:CGRectMake(0,0, 30, 30)];
    [setbtnImg setImage:[UIImage imageNamed:@"setting_press"] forState:UIControlStateNormal];
    [setbtnImg addTarget:self action:@selector(setbtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [setbtn addSubview:setbtnImg];

    //反馈
    UIButton *feedbackbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [feedbackbtn setFrame:CGRectMake(80,self.view.frame.size.height-50, 80, 30)];
    [feedbackbtn setTitle:@"  反馈" forState:UIControlStateNormal];
    feedbackbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [feedbackbtn addTarget:self action:@selector(feedbackbtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:feedbackbtn];

    //反馈图标
    UIButton *feedbackbtnImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [feedbackbtnImg setFrame:CGRectMake(0,0, 30, 30)];
    [feedbackbtnImg setImage:[UIImage imageNamed:@"feedback_press"] forState:UIControlStateNormal];
    [feedbackbtnImg addTarget:self action:@selector(feedbackbtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [feedbackbtn addSubview:feedbackbtnImg];

    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80 , self.view.frame.size.width, 70 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];

}

//个人中心
-(void)mebtnAction:(id)sender{
    [self pushVC:[[MineViewController alloc] init]];
}
//登陆
-(void)loginbtnAction:(id)sender{
    [self pushVC:[[MineViewController alloc] init]];
}
//设置
-(void)setbtnAction:(id)sender{
    [self pushVC:[[SetViewController alloc] init]];
}
//反馈
-(void)feedbackbtnAction:(id)sender{
    [self pushVC:[[FeedbackViewController alloc] init]];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self pushVC:[[MineViewController alloc] init]];
            break;
        case 1:
            [self pushVC:[[TenMinViewController alloc] init]];
            break;
        case 2:
            [self pushVC:[[ThDMovieViewController alloc] init]];
            break;
        case 3:
            [self pushVC:[[SoftWareViewController alloc] init]];
            break;
        case 4:
            [self pushVC:[[GameViewController alloc] init]];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    cell.textLabel.text = _titlesDataSuorse[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_imagesDataSuorse[indexPath.row]];
    
    return cell;
}
@end
