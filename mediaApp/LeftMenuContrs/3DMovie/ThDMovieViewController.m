//
//  ThDMovieViewController.m
//  NewsTwoApp
//
//  Created by 蒙建华 on 15/7/6.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import "ThDMovieViewController.h"
#import "VideoDetailController.h"
#import "ThDMovieCell.h"
#import "Macro.h"

@interface ThDMovieViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ThDMovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization  share@2x
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.titleLabel.text = @"3D影院";
    
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(320-45, 20,45, 40)];
    [shareBtn setImage:[UIImage imageNamed:@"play_share_h"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, IS_IPHONE_5?504:(504-88)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(void)shareBtnAction{
    [self AlertLogMsg:@"分享"];
}

#pragma mark -
#pragma mark UITableViewDelegate method

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 205;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = @"ThDMovieCell";
    ThDMovieCell *cell = (ThDMovieCell *)[tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ThDMovieCell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[ThDMovieCell class]])
                cell = (ThDMovieCell *)oneObject;
    }
    cell.backgroundColor = RGBA(222, 222, 222, 1);
    
    UIImage *img = [UIImage imageNamed:@"circle_1.png"];
    NSString *movieName = @"速度与激情7";
    NSString *movieDescription = @"在极速的世界里奔跑，这就是生命的全部...";
    NSMutableArray *arry = [NSMutableArray arrayWithObjects:img,movieName,movieDescription, nil];
    
    [cell setCellContenArry:arry];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger row = indexPath.row;
//    NSString *str = [NSString stringWithFormat:@"%ld",(long)row];
//    [self AlertLogMsg:str];
    
    [self pushVC:[[VideoDetailController alloc] init]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
