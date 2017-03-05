//
//  CustomerMAPointAnnotationView.m
//  ZuZu
//
//  Created by 陈锦滔 on 2017/2/28.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "CustomerMAPointAnnotationView.h"
#import "CustomCalloutView.h"
#import "MapViewHeight.h"

#define kCalloutWidth       200.0
#define kCalloutHeight      70.0

@interface CustomerMAPointAnnotationView()
@property (strong,nonatomic) CustomCalloutView *callOutView;
@end

@implementation CustomerMAPointAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if(self.selected==selected){
        return ;
    }
    if(selected){
        CGFloat size=[MapViewHeight cellHeightWithString:self.annotations.info andIsShow:YES andLableWidth:140 andFont:12 andDefaultHeight:145 andFixedHeight:0 andIsShowBtn:20];
        self.callOutView=[[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, size) withPic:self.annotations.pic1 withTitle:self.annotations.title withSubTitle:self.annotations.info withAddr:self.annotations.addr withUserTimer:self.annotations.timer];
        self.callOutView.center= CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                 -CGRectGetHeight(self.callOutView.bounds) / 2.f + self.calloutOffset.y);
        [self.callOutView.pushBtn addSubview:self.rightCalloutAccessoryView];
        [self addSubview:self.callOutView];
    }else{
        [self.callOutView removeFromSuperview];
    }
    [super setSelected:selected animated:YES];
}

@end
