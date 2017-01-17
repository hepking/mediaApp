//
//  MainAppViewController.m
//  helloworld
//
//  Created by meng on 14/7/13.
//  Copyright (c) 2014年 meng. All rights reserved.
//

#import "MainAppViewController.h"
#import "SliderViewController.h"
#import "MovieCell.h"

#import "MineViewController.h"
#import "SoftWareViewController.h"
#import "SearchViewController.h"
#import "VideoDetailController.h"
#import "TVDetailController.h"

#import "Macro.h"

//头部
static NSString *kheaderIdentifier = @"headerIdentifier";

//scroll 按钮宽高
#define MENU_BUTTON_WIDTH  60
#define MENU_HEIGHT 40
#define MENU_NAVBUTTON_TAG 800

#define _scrollVTag 606
#define _navScrollVTag 808


@interface MainAppViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>
{
    //承装整个首页的scrollView
    UIScrollView *Home_scrollV;
    
    UIView *_navView;
    UIView *_topNaviV;
    UIScrollView *_scrollV;
    
    UIScrollView *_navScrollV;
    UIView *_navBgV;
    
    float _startPointX;
    UIView *_selectTabV;
    
    UICollectionView *_collectionView;
}

//scroll 按钮数据
@property (nonatomic, strong) NSMutableArray *scrollDataSource;

@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *historyDataSource;

@end

@implementation MainAppViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        _scrollDataSource = [[NSMutableArray alloc] init];
    
    }
    return self;
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *statusBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 0.f)];
    if (isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)
    {
        statusBarView.frame = CGRectMake(statusBarView.frame.origin.x, statusBarView.frame.origin.y, statusBarView.frame.size.width, 20.f);
        statusBarView.backgroundColor = [UIColor clearColor];
        ((UIImageView *)statusBarView).backgroundColor = RGBA(33.f,125.f,194.f,1);
        [self.view addSubview:statusBarView];
    }
    
    //导航栏
    _navView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, StatusbarSize, self.view.frame.size.width, 50.f)];
    ((UIImageView *)_navView).backgroundColor = RGBA(33.f,125.f,194.f,1);
    [self.view insertSubview:_navView belowSubview:statusBarView];
    _navView.userInteractionEnabled = YES;
    
    //导航栏图标
    [self setNavbtn];
    
    //滚动导航栏
    _topNaviV = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.frame.size.height + _navView.frame.origin.y, self.view.frame.size.width, MENU_HEIGHT)];
    _topNaviV.backgroundColor = RGBA(33.f,125.f,194.f,1);
    [self.view addSubview:_topNaviV];
    
    //滚动页面
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _topNaviV.frame.origin.y + _topNaviV.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - _topNaviV.frame.origin.y - _topNaviV.frame.size.height)];
    _scrollV.tag = _scrollVTag;
    [_scrollV setPagingEnabled:YES];
    [_scrollV setShowsHorizontalScrollIndicator:NO];
    [self.view insertSubview:_scrollV belowSubview:_navView];
    _scrollV.delegate = self;
    [_scrollV.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    
    //选择弹出的view
    _selectTabV = [[UIView alloc] initWithFrame:CGRectMake(0, _scrollV.frame.origin.y - _scrollV.frame.size.height, _scrollV.frame.size.width, _scrollV.frame.size.height)];
    [_selectTabV setBackgroundColor:RGBA(255.f, 209.f, 56.f, 1)];
    [_selectTabV setHidden:YES];
    [self.view insertSubview:_selectTabV belowSubview:_navView];
    
    //创建滚动条菜单
    [self createScrollBtns];
    
}

//创建主导航菜单
-(void)setNavbtn{

    UIButton *MenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [MenuBtn setFrame:CGRectMake(15, 8, 20, 20)];
    [MenuBtn setBackgroundImage:[UIImage imageNamed:@"icon_list"] forState:UIControlStateNormal];
    [MenuBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    MenuBtn.showsTouchWhenHighlighted = YES;
    [_navView addSubview:MenuBtn];
    
    for (int i = 0; i < 4; i++) {
        UIButton *NavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [NavBtn setFrame:CGRectMake(170 + i*40, 8 , 20, 20)];
        NSString *NavBtn_backimg = [NSString stringWithFormat:@"slide_menu_%d@2x",i+1];
        [NavBtn setBackgroundImage:[UIImage imageNamed:NavBtn_backimg] forState:UIControlStateNormal];
        [NavBtn addTarget:self action:@selector(NavbtnAction:) forControlEvents:UIControlEventTouchUpInside];
        NavBtn.tag = MENU_NAVBUTTON_TAG + i;
        [_navView addSubview:NavBtn];
    }
}

//创建scroll 滚动菜单
- (void)createScrollBtns
{
    float btnW = 40;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(_topNaviV.frame.size.width - btnW, 0, btnW, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_more"] forState:UIControlStateNormal];
    [_topNaviV addSubview:btn];
    [btn addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
        
    _scrollDataSource = [NSMutableArray arrayWithObjects:@"推荐", @"电影", @"电视剧", @"卡通", @"综艺", @"体育", @"娱乐", @"新闻", nil];
    
    _navScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - btnW, MENU_HEIGHT)];
    _navScrollV.tag = _navScrollVTag;
    [_navScrollV setShowsHorizontalScrollIndicator:NO];
    for (int i = 0; i < [_scrollDataSource count]; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(MENU_BUTTON_WIDTH * i, -5, MENU_BUTTON_WIDTH, MENU_HEIGHT)];
        [btn setTitle:[_scrollDataSource objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(ScrolBtnActionbtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.showsTouchWhenHighlighted = YES;
        [_navScrollV addSubview:btn];
    }
    [_navScrollV setContentSize:CGSizeMake(MENU_BUTTON_WIDTH * [_scrollDataSource count], MENU_HEIGHT)];
    [_topNaviV addSubview:_navScrollV];
    
    //滚动栏底部 滚动条
    _navBgV = [[UIView alloc] initWithFrame:CGRectMake(0, MENU_HEIGHT - 5, MENU_BUTTON_WIDTH, 5)];
    [_navBgV setBackgroundColor:[UIColor redColor]];
    [_navScrollV addSubview:_navBgV];
    [self addView2Page:_scrollV count:[_scrollDataSource count] frame:CGRectZero];
}

//初始化视图内容  显示当前选中scroll的btn要显示的内容
- (void)addView2Page:(UIScrollView *)scrollV count:(NSUInteger)pageCount frame:(CGRect)frame
{
    for (int i = 0; i < pageCount; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollV.frame.size.width * i, 0, scrollV.frame.size.width, scrollV.frame.size.height)];
        view.tag = i + 1;
        
        //初始化collectionViews 视频视图
        [self creatScrollSubViewsInViews:view];
        
        [scrollV addSubview:view];
    }
    [scrollV setContentSize:CGSizeMake(scrollV.frame.size.width * pageCount, scrollV.frame.size.height)];
}

-(void)creatScrollSubViewsInViews:(UIView *)View{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    if (View.tag == 1) {
        _historyDataSource = [NSMutableArray arrayWithObjects:@"一路惊喜",@"一路惊喜", nil];
        //继续观看记录
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, 320, 85) style:UITableViewStylePlain];
        self.tableView.tag = View.tag;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.scrollEnabled = NO;
        [View addSubview:self.tableView];

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,+90+5, 320, View.frame.size.height -90+5) collectionViewLayout:flowLayout];
        
    }else{
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, View.frame.size.height) collectionViewLayout:flowLayout];
    }
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.tag = View.tag;
    [_collectionView registerClass:[MovieCell class] forCellWithReuseIdentifier:@"MovieCell"];
    
    //注册headerView Nib的view需要继承UICollectionReusableView
    [_collectionView registerNib:[UINib nibWithNibName:@"HeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];

    [View addSubview:_collectionView];
}

- (void)changeView:(float)x
{
    float xx = x * (MENU_BUTTON_WIDTH / self.view.frame.size.width);
    [_navBgV setFrame:CGRectMake(xx, _navBgV.frame.origin.y, _navBgV.frame.size.width, _navBgV.frame.size.height)];
}

#pragma mark - NavBtn_action
-(void)NavbtnAction:(UIButton *)btn{
    
    switch (btn.tag) {
        case MENU_NAVBUTTON_TAG +0:
            [[SliderViewController sharedSliderController].navigationController pushViewController:[[SoftWareViewController alloc] init] animated:YES];
            break;
        case MENU_NAVBUTTON_TAG +1:
            [[SliderViewController sharedSliderController].navigationController pushViewController:[[SearchViewController alloc] init] animated:YES];
            break;
        case MENU_NAVBUTTON_TAG +2:
            [[SliderViewController sharedSliderController].navigationController pushViewController:[[MineViewController alloc] init] animated:YES];
            break;
        case MENU_NAVBUTTON_TAG +3:
            [self AlertLogMsg:@"下载管理"];
            break;
            
        default:
            break;
    }
}

#pragma mark - scrollBtn_action
- (void)ScrolBtnActionbtn:(UIButton *)btn
{
    NSLog(@"您选择了%@",_scrollDataSource[(long)btn.tag-1]);

    [_scrollV scrollRectToVisible:CGRectMake(_scrollV.frame.size.width * (btn.tag - 1), _scrollV.frame.origin.y, _scrollV.frame.size.width, _scrollV.frame.size.height) animated:YES];
    
    float xx = _scrollV.frame.size.width * (btn.tag - 1) * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
}

- (void)leftAction:(UIButton *)btn
{
    if ([_selectTabV isHidden] == NO)
    {
        [self showSelectView:btn];
        return;
    }
    [((SliderViewController *)[[[self.view superview] superview] nextResponder]) showLeftViewController];
}

- (void)showSelectView:(UIButton *)btn
{
    if ([_selectTabV isHidden] == YES)
    {
        [_selectTabV setHidden:NO];
        [UIView animateWithDuration:0.6 animations:^
         {
             [_selectTabV setFrame:CGRectMake(0, _scrollV.frame.origin.y, _scrollV.frame.size.width, _scrollV.frame.size.height)];
         } completion:^(BOOL finished)
         {
         }];
    }
    else
    {
        [UIView animateWithDuration:0.6 animations:^
         {
             [_selectTabV setFrame:CGRectMake(0, _scrollV.frame.origin.y - _scrollV.frame.size.height, _scrollV.frame.size.width, _scrollV.frame.size.height)];
         } completion:^(BOOL finished)
         {
             [_selectTabV setHidden:YES];
         }];
    }
}

//左右滑动手势 是否允许切换
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    BOOL isPaning = NO;
    if(_scrollV.contentOffset.x < 0)
    {
        isPaning = YES;
//        isLeftDragging = YES;
//        [self showMask];
    }
    else if(_scrollV.contentOffset.x > (_scrollV.contentSize.width - _scrollV.frame.size.width))
    {
//        isPaning = YES;
//        isRightDragging = YES;
//        [self showMask];
    }
    
    if(isPaning)
    {
        [((SliderViewController *)[[[self.view superview] superview] nextResponder]) moveViewWithGesture:panParam];
    }
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

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SliderViewController sharedSliderController].navigationController pushViewController:[[VideoDetailController alloc] init] animated:YES];
}

//更多
-(void)moreBtnAction{
    [self AlertLogMsg:@"更多"];
}

#pragma mark -
#pragma mark UITableView Datasource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;{
    
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 15)];
    titleLabel.textColor=[UIColor colorWithRed:0.2 green:0.7 blue:0.95 alpha:1];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"继续观看";

    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(320-50, 5, 60, 15)];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [moreBtn addTarget:self action:@selector(moreBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [myView addSubview:moreBtn];
    [myView addSubview:titleLabel];
    
    return myView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 30;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    //显示时间
    cell.detailTextLabel.text = @"不足一分钟";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    
    cell.textLabel.text = _historyDataSource[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
}



#pragma mark - collectionViewDelegate
// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader ]){
        reuseIdentifier = kheaderIdentifier;
    }
    
    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    if (indexPath.section == 0) {
        UILabel *label = (UILabel *)[view viewWithTag:1];
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
            label.text = [NSString stringWithFormat:@"今日热播"];
        }
    }
    if (indexPath.section == 1) {
        UILabel *label = (UILabel *)[view viewWithTag:2];
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
            label.text = [NSString stringWithFormat:@"热播大片"];
        }
    }
    
    return view;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);//分别为上、左、下、右
}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (collectionView.tag == 1) {
        CGSize size={320,30};
        return size;
    }else
    {
        CGSize size={0,0};
        return size;
    }
}
//返回头footerView的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    CGSize size={2,2};
//    return size;
//}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 1) {
        if (section == 0) {
            return 8;
        }else
            return 10;
    }
    if (collectionView.tag == 2) {
        return 14;
    }else
        return 17;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView.tag == 1) {
        return 2;
    }
    if (collectionView.tag == 2) {
        return 1;
    }else
        return 1;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    if (collectionView.tag == 1) {
        UIImage *movie_Image = [UIImage imageNamed:@"movie1.png"];
        NSString *movie_Name = @"一克拉梦想";
        NSString *movie_Popurar = @"6666万";
        NSArray *array = [NSArray arrayWithObjects:movie_Image,movie_Name,movie_Popurar, nil];
        [cell initSubviews:array];
    }else if (collectionView.tag == 2) {
        UIImage *movie_Image = [UIImage imageNamed:@"circle_1.png"];
        NSString *movie_Name = @"速度与激情7";
        NSString *movie_Popurar = @"8888万";
        NSArray *array = [NSArray arrayWithObjects:movie_Image,movie_Name,movie_Popurar, nil];
        [cell initSubviews:array];
    }else if (collectionView.tag == 3) {
        UIImage *movie_Image = [UIImage imageNamed:@"circle_2.png"];
        NSString *movie_Name = @"导火线";
        NSString *movie_Popurar = @"9998万";
        NSArray *array = [NSArray arrayWithObjects:movie_Image,movie_Name,movie_Popurar, nil];
        [cell initSubviews:array];
    }else{
        UIImage *movie_Image = [UIImage imageNamed:@"circle_3.png"];
        NSString *movie_Name = @"杀破狼";
        NSString *movie_Popurar = @"6852万";
        NSArray *array = [NSArray arrayWithObjects:movie_Image,movie_Name,movie_Popurar, nil];
        [cell initSubviews:array];
    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 2) {
        [[SliderViewController sharedSliderController].navigationController pushViewController:[[VideoDetailController alloc] init] animated:YES];
    }else{
        [[SliderViewController sharedSliderController].navigationController pushViewController:[[TVDetailController alloc] init] animated:YES];
    }
}




@end
