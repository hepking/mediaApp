//
//  VideoDetailController.m
//  NewsTwoApp
//
//  Created by mengjianhua on 15/7/7.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import "VideoDetailController.h"
#import "VideoCell.h"

#define NAVBUTTON_TAG 998

@interface VideoDetailController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}
@end

@implementation VideoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    
    self.titleLabel.text = @"奔跑吧兄弟";
    
    //分享
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(320-45-80, 20,45, 40)];
    [shareBtn setImage:[UIImage imageNamed:@"play_share_h"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.tag = NAVBUTTON_TAG+1;
    [self.view addSubview:shareBtn];
    
    //下载
    UIButton *downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(320-45-40, 20,45, 40)];
    [downloadBtn setImage:[UIImage imageNamed:@"slide_menu_4"] forState:UIControlStateNormal];
    [downloadBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    downloadBtn.tag = NAVBUTTON_TAG+2;
    [self.view addSubview:downloadBtn];

    //收藏
    UIButton *collectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(320-45, 20,45, 40)];
    [collectionBtn setImage:[UIImage imageNamed:@"myFav_normal"] forState:UIControlStateNormal];
    [collectionBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    collectionBtn.tag = NAVBUTTON_TAG+3;
    [self.view addSubview:collectionBtn];

    //初始化存放视频所有属性的数组
    _videoInfosArray = [[NSMutableArray alloc] init];
    
    
    self.scrollView.delegate = self;
    [self.scrollView setContentSize:CGSizeMake(320, 780)];
    
    //初始化collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(152, 110)];//设置cell的尺寸
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
    flowLayout.sectionInset = UIEdgeInsetsMake(2, 1, 1, 2);//设置其边界
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 220, 320, self.view.frame.size.height - 200) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[VideoCell class] forCellWithReuseIdentifier:@"VideoCell"];
    [self.scrollView addSubview:_collectionView];

    [self getVideoINfosFromHTTP];
}

-(void)BtnAction:(UIButton *)btn{
    if (btn.tag == NAVBUTTON_TAG+1) {
        [self AlertLogMsg:@"分享"];
    }else if (btn.tag == NAVBUTTON_TAG+2){
        [self AlertLogMsg:@"下载"];
    }else if (btn.tag == NAVBUTTON_TAG+3){
        [self AlertLogMsg:@"收藏"];
    }
}

//设置视频相关属性
-(void)getVideoINfosFromHTTP{
    
    //主演
    self.video_Actor.text = @"陈赫、李晨、...";
    //地区
    self.video_Area.text = @"内地";
    //人气
    self.video_Popularity.text = @"332665886";
    //年份
    self.video_Years.text = @"2015";
    //评分
    self.video_Score.text = @"8.6分";
    //类型
    self.video_Type.text = @"喜剧";
    //更新
    self.video_UpdateTime.text = @"2015-05-16";
    //导演
    self.video_Director.text = @"浙江卫视";
    //剧情
    self.video_Drama.text = @"奔跑吧兄弟，是浙江卫视引进韩版推出的大型户外竞技真人秀节目，由浙江卫视和韩版制作团队韩国SBS联合制作";
}

#pragma mark - collectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return 6;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCell" forIndexPath:indexPath];
    UIImageView *movie_Image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_2.png"]];
    NSString *movie_Name = @"导火线";
    NSString *movie_Popurar = @"666688万";
    NSArray *VideoInfoArray = [NSArray arrayWithObjects:movie_Image,movie_Name,movie_Popurar, nil];
    [cell initVideoSubviews:VideoInfoArray];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    NSString *sr = [NSString stringWithFormat:@"第%ld个Section的第%ld个Cell",(long)indexPath.section,(long)indexPath.row];
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
