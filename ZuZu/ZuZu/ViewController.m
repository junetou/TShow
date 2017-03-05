//
//  ViewController.m
//  ZuZu
//
//  Created by 陈锦滔 on 2017/2/26.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "FriController.h"
#import "NeedController.h"
#import "RentController.h"
#import "MapInfoViewViewController.h"

@interface ViewController ()<FriControllerDelegate>
@property (strong,nonatomic) UISegmentedControl *segmentController;
@property (strong,nonatomic) UIView *lastView;
@property (strong,nonatomic) FriController *friController;
@property (strong,nonatomic) NeedController *needController;
@property (strong,nonatomic) RentController *rentController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _segmentController=[[UISegmentedControl alloc] initWithItems:@[@"好友",@"出租",@"需求"]];
    _segmentController.selectedSegmentIndex=0;
    _segmentController.layer.masksToBounds=NO;
    _segmentController.layer.cornerRadius=0;
    _segmentController.backgroundColor=[UIColor whiteColor];
    _segmentController.tintColor=[UIColor orangeColor];
    [_segmentController addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    _segmentController.frame=CGRectMake(0,self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height, self.view.frame.size.width, 30);
    [self.view insertSubview:_segmentController atIndex:0];
    _friController=[[FriController alloc] initWithFrame:self.view.frame];
    _friController.delegate=self;
    [self.view addSubview:_friController];
    [self.view sendSubviewToBack:_friController];
    _lastView=_friController;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeView:(UISegmentedControl *)segment{
    [self.view sendSubviewToBack:_lastView];
    switch (segment.selectedSegmentIndex) {
        case 0:
        {
            if(!_friController){
                _friController=[[FriController alloc] initWithFrame:self.view.frame];
                [self.view addSubview:_friController];
                _friController.delegate=self;
            }
            [self.view bringSubviewToFront:_friController];
            _lastView=_friController;
            break;
        }
        break;
        case 1:{
            if(!_needController){
                _needController=[[NeedController alloc] initWithFrame:self.view.frame];
                [self.view addSubview:_needController];
            }
            [self.view bringSubviewToFront:_needController];
            _lastView=_needController;
            break;
        }
            break;
        case 2:{
            if(!_rentController){
                _rentController=[[RentController alloc] initWithFrame:self.view.frame];
                [self.view addSubview:_rentController];
            }
            [self.view bringSubviewToFront:_rentController];
            _lastView=_rentController;
            break;
        }
            break;
        default:
            break;
    }
    [self.view bringSubviewToFront:_segmentController];
}

- (void)switchView{
    MapInfoViewViewController *infoView=[[MapInfoViewViewController alloc] init];
    [self.navigationController pushViewController:infoView animated:YES];
}

@end
