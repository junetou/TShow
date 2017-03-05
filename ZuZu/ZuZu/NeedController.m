//
//  NeedController.m
//  ZuZu
//
//  Created by 陈锦滔 on 2017/2/27.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "NeedController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface NeedController()<MAMapViewDelegate,AMapLocationManagerDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (strong,nonatomic) UIView *views;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) NSMutableDictionary *cellIsShowAll;
@property (strong,nonatomic) UIButton *titleBtn;
@property (strong,nonatomic) UIButton *rightBtn;
@property (strong,nonatomic) UIButton *gpsButton;

@end

@implementation NeedController

- (instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self layoutView];
    }
    return self;
}

- (void)layoutView{
    [AMapServices sharedServices].enableHTTPS=YES;
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.locationTimeout=2;
    self.locationManager.reGeocodeTimeout = 2;
    self.mapView=[[MAMapView alloc] initWithFrame:self.frame];
    self.mapView.delegate=self;
    [self addSubview:self.mapView];
    self.mapView.showsScale=YES;
    self.mapView.showsUserLocation=YES;
    self.mapView.centerCoordinate=CLLocationCoordinate2DMake(32.288656,123.386575);
    //添加地图加减按钮
    UIView *zoomPannelView=[self zoomPannelView];
    zoomPannelView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:zoomPannelView];
    //增加定位控件
    self.gpsButton=[self makeGPSButton];
    [self addSubview:self.gpsButton];
    self.gpsButton.autoresizingMask=UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
}

- (UIButton *)makeGPSButton {
    //定位按钮
    UIButton *ret = [[UIButton alloc] initWithFrame:CGRectMake(0,self.frame.size.height-60, 40, 40)];
    ret.layer.cornerRadius = 8;
    [ret setImage:[UIImage imageNamed:@"gpsStat2"] forState:UIControlStateNormal];
    [ret addTarget:self action:@selector(gpsAction) forControlEvents:UIControlEventTouchUpInside];//增加事件
    return ret;
}

- (void)gpsAction {
    //定位按钮的添加事件
    if(self.mapView.userLocation.updating && self.mapView.userLocation.location) {
        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
        [self.gpsButton setSelected:YES];//表示控件是否处于所选状态
        // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            if (error)
            {
                NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                
                if (error.code == AMapLocationErrorLocateFailed)
                {
                    return;
                }
            }
            if(regeocode)
            {
                NSLog(@"reGeocode:%@", regeocode.city);
            }
        }];
    }
}

- (UIView *)zoomPannelView{
    UIView *zoom = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-60, self.frame.size.height-120, 53, 98)];
    UIButton *incBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 49)];
    [incBtn setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
    [incBtn sizeToFit];
    [incBtn addTarget:self action:@selector(zoomPlusAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton *decBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 49, 53, 49)];
    [decBtn setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
    [decBtn sizeToFit];
    [decBtn addTarget:self action:@selector(zoomMinusAction) forControlEvents:UIControlEventTouchUpInside];
    [zoom addSubview:incBtn];
    [zoom addSubview:decBtn];
    return zoom;
}

- (void)zoomPlusAction
{//+
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom + 1) animated:YES];
}

- (void)zoomMinusAction
{//-
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom - 1) animated:YES];
}


@end
