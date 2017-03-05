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

@interface ViewController ()<CustomTabBarDelegate,TabBarDelegate>
@property (strong,nonatomic) CustomTabBar *customTabBar;
@end

@implementation ViewController

- (void)selectBarItemWithType:(CustomTabBarType)type{
    if(type!=CustomTabBarTypeSend){
        self.selectedIndex=type-CustomTabBarTypeHome;
        return ;
    }
    //HomeViewController *launchView = [[HomeViewController alloc] init];
    //UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:launchView];
    //[self presentViewController:navigation animated:YES completion:nil];
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
        HomeViewController *view=[[NSClassFromString(string) alloc] init];
        view.delegate=self;
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


- (BOOL)makeTabBarHidden:(BOOL)hide
{
    [UIView beginAnimations:nil context:NULL];
    for(UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[_customTabBar class]])
        {
            if (hide) {
                [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height+50, view.frame.size.width,49)];
                [self.tabBar setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height+50, view.frame.size.width,49)];
            }else {
                [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height-49, view.frame.size.width, 49)];
                [self.tabBar setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height-49, view.frame.size.width,49)];
            }
        }
    }
    [UIView commitAnimations];
    return hide;
}


@end
