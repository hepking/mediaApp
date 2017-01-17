//
//  TVDetailController.m
//  NewsTwoApp
//
//  Created by mengjianhua on 15/7/15.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import "TVDetailController.h"
#import "TvCollectCell.h"
#import "TVDescription.h"
#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]


#define TVNAVBUTTON_TAG 8866

#define MENUHEIHT 40
#define MENU_BUTTON_WIDTH  320/3
#define MENU_HEIGHT 35

#define _scrollVTag 606
#define _navScrollVTag 808
#define scrollViewTag 909

@interface TVDetailController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    //电视集
    UICollectionView *_collectionView;

    //页面滚动
    UIView *_navView;
    UIView *_topNaviV;
    UIScrollView *_scrollV;
    
    //导航滚动
    UIScrollView *_navScrollV;
    UIView *_navBgV;
    
    float _startPointX;
    UIView *_selectTabV;
}

//存放选集
@property(strong, nonatomic) UIScrollView *scrollView;

@property (strong, readwrite, nonatomic) UITableView *tableView;
//菜单数据
@property (strong, readwrite, nonatomic) NSArray *titlesDataSuorse;
@property (strong, readwrite, nonatomic) NSArray *imagesDataSuorse;

@property (nonatomic, strong) NSMutableArray *scrollDataSource;


@end

@implementation TVDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    
    self.titleLabel.text = @"导火线";
    
    //分享
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(320-45-80, 20,45, 40)];
    [shareBtn setImage:[UIImage imageNamed:@"play_share_h"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.tag = TVNAVBUTTON_TAG+1;
    [self.view addSubview:shareBtn];
    
    //下载
    UIButton *downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(320-45-40, 20,45, 40)];
    [downloadBtn setImage:[UIImage imageNamed:@"slide_menu_4"] forState:UIControlStateNormal];
    [downloadBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    downloadBtn.tag = TVNAVBUTTON_TAG+2;
    [self.view addSubview:downloadBtn];
    
    //收藏
    UIButton *collectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(320-45, 20,45, 40)];
    [collectionBtn setImage:[UIImage imageNamed:@"myFav_normal"] forState:UIControlStateNormal];
    [collectionBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    collectionBtn.tag = TVNAVBUTTON_TAG+3;
    [self.view addSubview:collectionBtn];

    [self iniAllviews];
}

-(void)BtnAction:(UIButton *)btn{
    if (btn.tag == TVNAVBUTTON_TAG+1) {
        [self AlertLogMsg:@"分享"];
    }else if (btn.tag == TVNAVBUTTON_TAG+2){
        [self AlertLogMsg:@"下载"];
    }else if (btn.tag == TVNAVBUTTON_TAG+3){
        [self AlertLogMsg:@"收藏"];
    }
}

- (void)iniAllviews
{
    //导航栏
    _navView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 180, self.view.frame.size.width, 44.f)];
    ((UIImageView *)_navView).backgroundColor = RGBA(33.f,125.f,194.f,1);
    _navView.userInteractionEnabled = YES;
    
    //滚动导航栏
    _topNaviV = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.frame.size.height + _navView.frame.origin.y, self.view.frame.size.width, MENU_HEIGHT)];
    _topNaviV.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_topNaviV];
    
    //滚动页面
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _topNaviV.frame.origin.y + _topNaviV.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - _topNaviV.frame.origin.y - _topNaviV.frame.size.height +100)];
    [_scrollV setPagingEnabled:YES];
    [_scrollV setShowsHorizontalScrollIndicator:NO];
    [self.view insertSubview:_scrollV belowSubview:_navView];
    _scrollV.tag = _scrollVTag;
    _scrollV.delegate = self;
    
    [self createScrollBtns];
}

//创建scroll 滚动菜单
- (void)createScrollBtns
{
    _scrollDataSource = [NSMutableArray arrayWithObjects:@"选集", @"详情",@"猜你喜欢", nil];
    
    _navScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, MENU_HEIGHT)];
    _navScrollV.tag = _navScrollVTag;
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
    _navBgV = [[UIView alloc] initWithFrame:CGRectMake(0, MENU_HEIGHT - 4, MENU_BUTTON_WIDTH, 5)];
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
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 600)];
        self.scrollView.tag = scrollViewTag;
        self.scrollView.delegate = self;
        [self.scrollView setContentSize:CGSizeMake(320, 800)];
        [View addSubview:self.scrollView];
        
        //初始化collectionView
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake(40, 40)];//设置cell的尺寸
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 1, 1, 5);//设置其边界
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(2, 0, 320, self.view.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[TvCollectCell class] forCellWithReuseIdentifier:@"TvCollectCell"];
        [self.scrollView addSubview:_collectionView];
        
        //删除记录
        UIButton *delebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [delebtn setFrame:CGRectMake(View.frame.size.width-60,5, 50, 30)];
        [delebtn setTitle:@"序列" forState:UIControlStateNormal];
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

        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 600)];
        self.scrollView.tag = scrollViewTag+1;
        self.scrollView.delegate = self;
        [self.scrollView setContentSize:CGSizeMake(320, 680)];
        [View addSubview:self.scrollView];
        
        TVDescription *TVdescriptV = [[TVDescription alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        [TVdescriptV setTVdescriptionInfo];

        [self.scrollView addSubview:TVdescriptV];

    }
    
    if (View.tag == 3) {
        UIImageView *imageBgV = [[UIImageView alloc] initWithFrame:CGRectMake(320/2 - 50, 80, 100, 120)];
        [imageBgV setImage:[UIImage imageNamed:@"btn_no_record"]];
        imageBgV.userInteractionEnabled = YES;
        [View addSubview:imageBgV];
    }

}

-(void)deleBtnAct{
    [self AlertLogMsg:@"序列"];
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
    if (scrollView.tag == _scrollVTag) {
        _startPointX = scrollView.contentOffset.x;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == _scrollVTag) {
        [self changeView:scrollView.contentOffset.x];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == _scrollVTag) {
        float xx = scrollView.contentOffset.x * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
        [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
    }
}

#pragma mark - collectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TvCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TvCollectCell" forIndexPath:indexPath];
    NSString *strTVCells = [NSString stringWithFormat:@"%d",indexPath.row+1];
    
    [cell setTVCCellontensInfo:strTVCells];

    if (indexPath.row == 0 || indexPath.row == 1) {
        UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"worldCup_newIcon"]];
        imgv.frame = CGRectMake(0, 0, 30, 30);
        [cell addSubview:imgv];
        
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){0,0,1,1});
        [cell.layer setBorderColor:color];
        [cell.layer setBorderWidth:1.0];
    }
    else{
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){0.4,0.4,0.4,1});
        [cell.layer setBorderColor:color];
        [cell.layer setBorderWidth:1.0];
    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sr = [NSString stringWithFormat:@"第%ld集",(long)indexPath.row+1];
    [self AlertLogMsg:sr];
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
