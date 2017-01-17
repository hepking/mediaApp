//
//  SearchViewController.m
//  NewsTwoApp
//
//  Created by mengjianhua on 15/7/14.
//  Copyright (c) 2015年 meng. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
//    self.titleLabel.text = @"搜索";
    
    UISearchBar *mySearchBar = [[UISearchBar alloc]
                                initWithFrame:CGRectMake(50, 22, 250, 35)];
    mySearchBar.delegate = self;
    mySearchBar.showsCancelButton = NO;
    mySearchBar.barStyle = UIBarStyleDefault;
    mySearchBar.placeholder = @"请输入您要搜索的内容";
    mySearchBar.keyboardType = UIKeyboardTypeDefault;
    mySearchBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mySearchBar];
}

#pragma mark -
#pragma mark UISearchBar Delegate mehtod

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    NSString *searchText = searchBar.text;
    [self AlertLogMsg:searchText];
    
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
