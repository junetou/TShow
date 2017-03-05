//
//  Fri.m
//  ZuZu
//
//  Created by 陈锦滔 on 2017/2/26.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "FriController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "CustomerMAPointAnnotation.h"
#import "CustomerMAPointAnnotationView.h"
#import "MapInfoViewViewController.h"

@interface FriController()<MAMapViewDelegate,AMapLocationManagerDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (strong,nonatomic) UIView *views;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;
@property (strong,nonatomic) NSMutableDictionary *cellIsShowAll;
@property (strong,nonatomic) UIButton *titleBtn;
@property (strong,nonatomic) UIButton *rightBtn;
@property (strong,nonatomic) UIButton *gpsButton;
@end

@implementation FriController

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
    self.mapView.userTrackingMode=MAUserTrackingModeFollow;
    self.mapView.showsUserLocation=YES;
    self.mapView.centerCoordinate=CLLocationCoordinate2DMake(22.288656,113.386575);
    //添加地图加减按钮
    UIView *zoomPannelView=[self zoomPannelView];
    zoomPannelView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:zoomPannelView];
    //增加定位控件
    self.gpsButton=[self makeGPSButton];
    [self addSubview:self.gpsButton];
    self.gpsButton.autoresizingMask=UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    //添加数据
    [_mapView addAnnotations:self.dataSourceArray];
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
{
    //+控件
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom + 1) animated:YES];
}

- (void)zoomMinusAction
{
    //-控件
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom - 1) animated:YES];
}

- (NSMutableArray *)dataSourceArray{
    if(!_dataSourceArray){
        _dataSourceArray=[NSMutableArray array];
        for(NSInteger i=0;i<5;i++){
            CustomerMAPointAnnotation *annotation=[[CustomerMAPointAnnotation alloc] init];
            annotation.coordinate=CLLocationCoordinate2DMake(22.288656+i, 113.386575+i);
            annotation.title=[NSString stringWithFormat:@"T.%lu",i];
            annotation.subtitle=@"xxxxxxxxxxxxxxxxxxxxxxxxzzzzzzzzzzzzzzccccccć";
            annotation.identification=[NSString stringWithFormat:@"%lu",i];
            annotation.barCode=YES;
            annotation.userId=[NSString stringWithFormat:@"%lu",i];
            annotation.userName=@"T.x";
            annotation.userPrestige=@"10";
            annotation.name=[NSString stringWithFormat:@"%lu",i];
            annotation.addr=@"广东省佛山市禅城区张槎街道张槎中学旁";
            annotation.money=@"15.0/天";
            annotation.timer=@"10";
            annotation.info=@"是任天堂最初于2011年推出的第四代便携式游戏机，是任天堂DS的后续机种。其利用了视差障壁技术，让玩家不需配戴特殊眼镜即可感受到裸眼3D图像。该平台向下兼容任天堂DS软件。2012年9月发行繁体中文版";
            annotation.pic1=@"123";
            annotation.pic2=@"123";
            annotation.pic3=@"123";
            [_dataSourceArray addObject:annotation];
        }
    }
    return _dataSourceArray;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if([annotation isKindOfClass:[MAPointAnnotation class]]){
        CustomerMAPointAnnotation *annotations=(CustomerMAPointAnnotation *)annotation;
        static NSString *cellId=@"AnnotationView";
        CustomerMAPointAnnotationView *view=(CustomerMAPointAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:cellId];
        if(view==nil){
            view=[[CustomerMAPointAnnotationView alloc] initWithAnnotation:annotations reuseIdentifier:cellId];
            view.canShowCallout=NO;
            view.userInteractionEnabled=YES;
        }
        view.annotations=annotations;
        view.image=[self reSizeImage:[UIImage imageNamed:@"123"] toSize:CGSizeMake(30, 30) toRect:self.views.frame];
        view.centerOffset=CGPointMake(20, 20);
        UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"详情" forState:UIControlStateNormal];
        [button setTintColor:[UIColor orangeColor]];
        [button setBackgroundColor:[UIColor blackColor]];
        button.backgroundColor=[UIColor brownColor];
        button.frame=CGRectMake(0, 0, 200, 20);
        view.rightCalloutAccessoryView = button;
        [view.rightCalloutAccessoryView setBackgroundColor:[UIColor clearColor]];
        return view;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if([self.delegate respondsToSelector:@selector(switchView)]){
        [self.delegate switchView];
    }
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize toRect:(CGRect)reRect
{
    
    UIGraphicsBeginImageContextWithOptions(reSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //圆的边框宽度为2，颜色为红色
    CGContextSetLineWidth(context,1);
    CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);
    CGRect rect = CGRectMake(0,0, reSize.width, reSize.height);
    //画椭圆
    CGContextAddEllipseInRect(context, rect);
    //连接内容
    CGContextClip(context);
    //在圆区域内画出image原图
    [image drawInRect:rect];
    //把图片变成圆形
    CGContextAddEllipseInRect(context, rect);
    //连接内容
    CGContextStrokePath(context);
    //生成新的image
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    //结束绘画
    UIGraphicsEndImageContext();
    
    return newimg;
}


@end
