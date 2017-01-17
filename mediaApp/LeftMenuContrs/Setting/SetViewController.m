//
//  SetViewController.m
//  CloudShop
//
//  Created by meng jianhua on 14-4-3.
//  Copyright (c) 2014年 mengjianhua. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource1;
@property (nonatomic, strong) NSArray *dataSource2;

@end

@implementation SetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = @"设置";
    
    
    self.dataSource1 = [NSArray arrayWithObjects:@"本地文件路径",@"视频扫描设置",@"选择解码方式",@"左眼开启效果",nil];
    self.dataSource2 = [NSArray arrayWithObjects:@"视频来源",@"同时缓存数",@"离线缓存保存位置",@"语言设置",nil];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, 320, 480) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];

    self.view.backgroundColor= [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark UITableViewDelegate method -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2; // [dataSourse count]分组   1非分组
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 4;
    }else
        return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 20.f;
    }else{
        return 20.f;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        if (section == 0) {
            UIView* myView = [[UIView alloc] init];
            myView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 150, 15)];
            titleLabel.textColor=[UIColor colorWithRed:0.2 green:0.7 blue:0.95 alpha:1];
            titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.text = @"本地播放设置";
            [myView addSubview:titleLabel];
            return myView;
        
        }
    
        else{
            UIView* myView = [[UIView alloc] init];
            myView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 150, 15)];
            titleLabel.textColor=[UIColor colorWithRed:0.2 green:0.7 blue:0.95 alpha:1];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
            titleLabel.text = @"在线视频设置设置";
            [myView addSubview:titleLabel];
            return myView;
        }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = @"cell";
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    
    //cell右边的显示方式
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    //第一个section
    if (indexPath.section == 0 ) {
        cell.textLabel.text = self.dataSource1[row];
        
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"mnt/adcard";
        }
        if (indexPath.row == 2) {
            cell.detailTextLabel.text = @"智能解码";
        }
    }
    
    //第二个section
    if (indexPath.section == 1 ) {
        cell.textLabel.text = self.dataSource2[row];
        
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"流畅优先";
        }
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = @"1";
        }
        if (indexPath.row == 2) {
            cell.detailTextLabel.text = @"ext sdcard";
        }
        if (indexPath.row == 3) {
            cell.detailTextLabel.text = @"english";
            
        }
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    
    //第一个section
    if (indexPath.section == 0) {
        switch (row) {
            case 0:
                [self LocationPath:0];
                break;
            case 1:
                [self VideoScan:0];
                break;
            case 2:
                [self SeleDecodeTyep:0];
                break;
            case 3:
                [self LeftEyeEffect:0];//云聊设置
                break;
            default:
                break;
        }

    }else{
        //第二个section
        NSInteger i = indexPath.section;
        switch (row) {
            case 0:
                [self LocationPath:&i];
                break;
            case 1:
                [self VideoScan:&i];
                break;
            case 2:
                [self SeleDecodeTyep:&i];
                break;
            case 3:
                [self LeftEyeEffect:&i];//云聊设置
                break;
            default:
                break;
        }
        
    }
}

-(void)LocationPath:(NSInteger *)section{
    
    self.dataSource1 = [NSArray arrayWithObjects:@"本地文件路径",@"视频扫描设置",@"选择解码方式",@"左眼开启效果",nil];
    self.dataSource2 = [NSArray arrayWithObjects:@"视频来源",@"同时缓存数",@"离线缓存保存位置",@"语言设置",nil];

    if (section == 0) {
        [self AlertLogMsg:@"本地文件路径"];
    }else{
        [self AlertLogMsg:@"视频来源"];
    }
}

-(void)VideoScan:(NSInteger *)section{
    if (section == 0) {
        [self AlertLogMsg:@"视频扫描设置"];
    }else{
        [self AlertLogMsg:@"同时缓存数"];
    }
}

-(void)SeleDecodeTyep:(NSInteger *)section{
    if (section == 0) {
        [self AlertLogMsg:@"选择解码方式"];
    }else{
        [self AlertLogMsg:@"离线缓存保存位置"];
    }
}

-(void)LeftEyeEffect:(NSInteger *)section{
    if (section == 0) {
        [self AlertLogMsg:@"左眼开启效果"];
    }else{
        [self AlertLogMsg:@"语言设置"];
    }
}

@end
