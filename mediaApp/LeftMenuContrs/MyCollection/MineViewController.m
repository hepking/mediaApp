//
//  MineViewController.m
//  NewsTwoApp
//
//  Created by 蒙建华 on 15/7/5.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import "MineViewController.h"
#import "SliderViewController.h"
#import "VideoDetailController.h"
#import "HistoryCell.h"
#import "Macro.h"

#define MENUHEIHT 40
#define MENU_BUTTON_WIDTH  160
#define MENU_HEIGHT 35

@interface MineViewController ()<UIScrollViewDelegate ,UITableViewDelegate ,UITableViewDataSource>
{
    UIView *_navView;
    UIView *_topNaviV;
    UIScrollView *_scrollV;
    
    UIScrollView *_navScrollV;
    UIView *_navBgV;
    
    float _startPointX;
    UIView *_selectTabV;
}

@property (strong, readwrite, nonatomic) UITableView *tableView;

//菜单数据
@property (strong, readwrite, nonatomic) NSArray *titlesDataSuorse;
@property (strong, readwrite, nonatomic) NSArray *imagesDataSuorse;

@property (nonatomic, strong) NSMutableArray *scrollDataSource;

@end

@implementation MineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.titleLabel.text = @"个人中心";
    
    self.titlesDataSuorse = [[NSArray alloc] init];
    self.imagesDataSuorse = [[NSArray alloc] init];
    
    _titlesDataSuorse = @[@"一路惊喜", @"一路惊喜", @"一路惊喜", @"一路惊喜", @"一路惊喜"];
    _imagesDataSuorse = @[@"play_record_with_online", @"play_record_with_online", @"play_record_with_online", @"play_record_with_online", @"play_record_with_online"];
    
    UIImageView *imageBgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320, 120)];
    [imageBgV setBackgroundColor:RGBA(20.f, 80.f, 110.f, 1)];
    imageBgV.userInteractionEnabled = YES;
    [self.view addSubview:imageBgV];
    
    //个人中心
    UIButton *mebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mebtn setFrame:CGRectMake(15,35, 50, 50)];
    [mebtn setImage:[UIImage imageNamed:@"loginBtn_head"] forState:UIControlStateNormal];
    [mebtn addTarget:self action:@selector(loginMineView) forControlEvents:UIControlEventTouchUpInside];
    [imageBgV addSubview:mebtn];
    
    //登录
    UIButton *loginbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginbtn setFrame:CGRectMake(70,35, 70, 25)];
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    loginbtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [loginbtn addTarget:self action:@selector(loginMineView) forControlEvents:UIControlEventTouchUpInside];
    loginbtn.showsTouchWhenHighlighted = YES;
    [imageBgV addSubview:loginbtn];
    
    //lbbtn
    UIButton *warningbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [warningbtn setFrame:CGRectMake(loginbtn.frame.origin.x,loginbtn.frame.origin.y+30, 150, 25)];
    [warningbtn setTitle:@"登录查看播放记录" forState:UIControlStateNormal];
    warningbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [warningbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [imageBgV addSubview:warningbtn];
    
    [self iniAllviews];
}

-(void)loginMineView{
    [self AlertLogMsg:@"去登录"];
}

- (void)iniAllviews
{
    //导航栏
    _navView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 120, self.view.frame.size.width, 44.f)];
    ((UIImageView *)_navView).backgroundColor = RGBA(33.f,125.f,194.f,1);
    _navView.userInteractionEnabled = YES;
    
    _topNaviV = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.frame.size.height + _navView.frame.origin.y, self.view.frame.size.width, MENU_HEIGHT)];
    _topNaviV.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_topNaviV];
    
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _topNaviV.frame.origin.y + _topNaviV.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - _topNaviV.frame.origin.y - _topNaviV.frame.size.height)];
    [_scrollV setPagingEnabled:YES];
    [_scrollV setShowsHorizontalScrollIndicator:NO];
    [self.view insertSubview:_scrollV belowSubview:_navView];
    _scrollV.delegate = self;
    
    [self createScrollBtns];
}

//创建scroll 滚动菜单
- (void)createScrollBtns
{
    _scrollDataSource = [NSMutableArray arrayWithObjects:@"历史", @"收藏", nil];
    
    _navScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, MENU_HEIGHT)];
    [_navScrollV setShowsHorizontalScrollIndicator:NO];
    for (int i = 0; i < [_scrollDataSource count]; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(MENU_BUTTON_WIDTH * i, 0, MENU_BUTTON_WIDTH, MENU_HEIGHT)];
        [btn setTitle:[_scrollDataSource objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(actionbtn:) forControlEvents:UIControlEventTouchUpInside];
        [_navScrollV addSubview:btn];
    }
    [_navScrollV setContentSize:CGSizeMake(MENU_BUTTON_WIDTH * [_scrollDataSource count], MENU_HEIGHT)];
    [_topNaviV addSubview:_navScrollV];
    
    //滚动栏底部 滚动条
    _navBgV = [[UIView alloc] initWithFrame:CGRectMake(0, MENU_HEIGHT - 3, MENU_BUTTON_WIDTH, 5)];
    
    [_navBgV setBackgroundColor:RGBA(72, 161, 255, 1)];
    [_navScrollV addSubview:_navBgV];
    
    [self addView2Page:_scrollV count:[_scrollDataSource count] frame:CGRectZero];
}

//显示当前选择scroll的btn要显示的内容
- (void)addView2Page:(UIScrollView *)scrollV count:(NSUInteger)pageCount frame:(CGRect)frame
{
    for (int i = 0; i < pageCount; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollV.frame.size.width * i, 0, scrollV.frame.size.width, scrollV.frame.size.height)];
        view.tag = i + 1;
        
        [self creatScrollSubViewsInViews:view];
        
        [scrollV addSubview:view];
    }
    
    [scrollV setContentSize:CGSizeMake(scrollV.frame.size.width * pageCount, scrollV.frame.size.height)];
    
}

-(void)creatScrollSubViewsInViews:(UIView *)View{
    if (View.tag == 1) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, 320, IS_IPHONE_5?504:(504-88)) style:UITableViewStylePlain];
        self.tableView.tag = View.tag;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [View addSubview:self.tableView];
        
        //删除记录
        UIButton *delebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [delebtn setFrame:CGRectMake(View.frame.size.width-60,5, 50, 30)];
        [delebtn setTitle:@"删除" forState:UIControlStateNormal];
        delebtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        [delebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){0.4,0.4,0.4,1});
        [delebtn.layer setBorderColor:color];
        [delebtn.layer setMasksToBounds:YES];
        [delebtn.layer setCornerRadius:5.0];
        [delebtn.layer setBorderWidth:1.0];
        
        [delebtn addTarget:self action:@selector(deleBtnAct) forControlEvents:UIControlEventTouchUpInside];
        [View addSubview:delebtn];

    }
    
    if (View.tag == 2) {
        UIImageView *imageBgV = [[UIImageView alloc] initWithFrame:CGRectMake(320/2 - 50, 80, 100, 120)];
        [imageBgV setImage:[UIImage imageNamed:@"btn_no_record"]];
        imageBgV.userInteractionEnabled = YES;
        [View addSubview:imageBgV];
    }
}

-(void)deleBtnAct{
    [self AlertLogMsg:@"删除"];
}

- (void)changeView:(float)x
{
    float xx = x * (MENU_BUTTON_WIDTH / self.view.frame.size.width);
    [_navBgV setFrame:CGRectMake(xx, _navBgV.frame.origin.y, _navBgV.frame.size.width, _navBgV.frame.size.height)];
}

#pragma mark - scrollBtn_action
- (void)actionbtn:(UIButton *)btn
{
    [_scrollV scrollRectToVisible:CGRectMake(_scrollV.frame.size.width * (btn.tag - 1), _scrollV.frame.origin.y, _scrollV.frame.size.width, _scrollV.frame.size.height) animated:YES];
    
    float xx = _scrollV.frame.size.width * (btn.tag - 1) * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _startPointX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changeView:scrollView.contentOffset.x];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float xx = scrollView.contentOffset.x * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushVC:[[VideoDetailController alloc] init]];
    
//    [self AlertLogMsg:_titlesDataSuorse[indexPath.row]];

}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
    NSString *str = @"HistoryCell";
    HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HistoryCell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[HistoryCell class]])
                cell = (HistoryCell *)oneObject;
    }
    cell.backgroundColor = [UIColor clearColor];
    
    NSString *movieName = @"一路惊喜";// remaining
    NSString *remainingTime = @"2015-6-16";
    NSString *playTime = @"2015-6-16";
    NSMutableArray *arry = [NSMutableArray arrayWithObjects:movieName,remainingTime,playTime, nil];
    
    [cell setHistoryCellContence:arry];
    
    return cell;
}



@end
