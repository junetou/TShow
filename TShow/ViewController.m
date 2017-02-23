//
//  ViewController.m
//  TShow
//
//  Created by 陈锦滔 on 2017/2/21.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "ViewController.h"
#import "CustomTabBar.h"
#import "HomeViewController.h"

@interface ViewController ()<CustomTabBarDelegate>
@property (strong,nonatomic) CustomTabBar *customTabBar;
@end

@implementation ViewController

- (void)selectBarItemWithType:(CustomTabBarType)type{
    if(type!=CustomTabBarTypeSend){
        self.selectedIndex=type-CustomTabBarTypeHome;
        return ;
    }
    HomeViewController *launchView = [[HomeViewController alloc] init];
    UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:launchView];
    //navigation.hidesBottomBarWhenPushed = NO;
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    [self configVIewControllers];
    [self.view addSubview:self.customTabBar];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configVIewControllers{
    NSMutableArray *viewArray=[NSMutableArray arrayWithArray:@[@"HomeViewController",@"HomeViewController"]];
    for(NSInteger i=0;i<viewArray.count;i++){
        NSString *string=viewArray[i];
        UIViewController *view=[[NSClassFromString(string) alloc] init];
        UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:view];
        [viewArray replaceObjectAtIndex:i withObject:navigation];
    }
    self.viewControllers=viewArray;
}

- (CustomTabBar *)customTabBar{
    if(!_customTabBar){
        _customTabBar=[[CustomTabBar alloc] initWithFrame:self.tabBar.frame];
        _customTabBar.delegate=self;
    }
    return _customTabBar;
}

@end
