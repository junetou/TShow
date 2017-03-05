//
//  CustomCalloutView.m
//  ZuZu
//
//  Created by 陈锦滔 on 2017/2/28.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "CustomCalloutView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "CustomerMAPointAnnotationView.h"
#import <Masonry.h>
#import "MapViewHeight.h"

@interface CustomCalloutView()
@property (strong,nonatomic) UIImageView *img;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UITextView *subTitleLabel;
@property (strong,nonatomic) UILabel *addrLabel;
@property (strong,nonatomic) UILabel *userTimerLabel;
@end

@implementation CustomCalloutView

- (instancetype)initWithFrame:(CGRect)frame withPic:(NSString *)pic withTitle:(NSString *)title withSubTitle:(NSString *)subTitle withAddr:(NSString *)addr withUserTimer:(NSString *)userTimer{
    if(self=[super initWithFrame:frame]){
        [self layoutView:pic Title:title SubTitle:subTitle Addr:addr UserTimer:userTimer];
    }
    return  self;
}

- (void)layoutView:(NSString *)pic Title:(NSString *)title SubTitle:(NSString *)subTitle Addr:(NSString *)addr UserTimer:(NSString *)userTimer{
    self.backgroundColor=[UIColor clearColor];
    _img=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    _img.image=[UIImage imageNamed:pic];
    _img.backgroundColor=[UIColor whiteColor];
    [self addSubview:_img];
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(5,55, 50, 15)];
    _titleLabel.font=[UIFont boldSystemFontOfSize:10];
    _titleLabel.textColor=[UIColor blackColor];
    _titleLabel.text=[NSString stringWithFormat:@"名称:%@",title];
    [self addSubview:_titleLabel];
    CGRect size=[subTitle boundingRectWithSize:CGSizeMake(140, self.frame.size.height-20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    _subTitleLabel=[[UITextView alloc] initWithFrame:CGRectMake(60, 0, 140, size.size.height)];
    _subTitleLabel.font=[UIFont boldSystemFontOfSize:10];
    _subTitleLabel.textColor=[UIColor blackColor];
    _subTitleLabel.backgroundColor=[UIColor clearColor];
    _subTitleLabel.text=[NSString stringWithFormat:@"%@",subTitle];
    [self addSubview:_subTitleLabel];
    UILabel *addrL=[[UILabel alloc] initWithFrame:CGRectMake(5, 70, 50, 15)];
    addrL.font=[UIFont boldSystemFontOfSize:8];
    addrL.text=@"地址";
    addrL.textColor=[UIColor blackColor];
    [self addSubview:addrL];
    _addrLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 72, 50, 50)];
    _addrLabel.numberOfLines=0;
    _addrLabel.font=[UIFont boldSystemFontOfSize:8];
    _addrLabel.text=[NSString stringWithFormat:@"%@",addr];
    _addrLabel.textColor=[UIColor blackColor];
    [self addSubview:_addrLabel];
    _userTimerLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 105, 50, 30)];
    _userTimerLabel.font=[UIFont boldSystemFontOfSize:7];
    _userTimerLabel.numberOfLines=0;
    _userTimerLabel.text=[NSString stringWithFormat:@"可租借时间:%@ ¥:%0.2f",userTimer,10.0];
    _userTimerLabel.textColor=[[UIColor redColor] colorWithAlphaComponent:1.0];
    [self addSubview:_userTimerLabel];
    _pushBtn=[[UIImageView alloc] initWithFrame:CGRectMake(0,self.frame.size.height-30, self.frame.size.width, 20)];
    _pushBtn.backgroundColor=[[UIColor orangeColor] colorWithAlphaComponent:0.5];
    _pushBtn.userInteractionEnabled=YES;
    _pushBtn.clipsToBounds=YES;
    [self addSubview:_pushBtn];
}

- (void)drawRect:(CGRect)rect{
    //绘制弹出气泡
    [self drawInContext:UIGraphicsGetCurrentContext()];
    self.layer.shadowColor=[[UIColor purpleColor] colorWithAlphaComponent:0.5].CGColor;
    self.layer.shadowOffset=CGSizeMake(0, 0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity=1;//阴影透明度，默认0
    self.layer.shadowRadius=2;//阴影半径，默认3
    //路径阴影
    UIBezierPath *path=[UIBezierPath bezierPath];
    float width=self.bounds.size.width;
    float height=self.bounds.size.height-5;
    float x=self.bounds.origin.x;
    float y=self.bounds.origin.y;
    float WH=5;
    
    CGPoint topLeft=self.bounds.origin;
    CGPoint topMiddle=CGPointMake(x+(width/2), y-WH);
    CGPoint topRight=CGPointMake(x+width, y);
    
    CGPoint rightMiddle=CGPointMake(x+width+WH, y+(height/2));
    
    CGPoint bottomRight=CGPointMake(x+width, y+height);
    CGPoint bottomMiddle=CGPointMake(x+(width/2), y+height+WH);
    CGPoint bottomLeft=CGPointMake(x, y+height);
    
    CGPoint leftMiddle=CGPointMake(x-WH, y+height);
    
    //绘制4条二元曲线
    [path moveToPoint:topLeft];
    [path addQuadCurveToPoint:topRight controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft  controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft controlPoint:leftMiddle];
    
    self.layer.shadowPath=path.CGPath;
}

- (void)drawInContext:(CGContextRef)context{
    //绘制内部气泡
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context,[[UIColor whiteColor] colorWithAlphaComponent:0.8].CGColor);
    [self drawPath:context];
    CGContextFillPath(context);
}

- (void)drawPath:(CGContextRef)context{
    //绘制气泡背景
    CGRect rect=self.bounds;
    CGFloat radius=6.0;
    CGFloat minx=CGRectGetMinX(rect);
    CGFloat midx=CGRectGetMidX(rect);
    CGFloat maxx=CGRectGetMaxX(rect);
    CGFloat miny=CGRectGetMinY(rect);
    CGFloat maxy=CGRectGetMaxY(rect)-10;
    
    CGContextMoveToPoint(context, midx+10, maxy);
    CGContextAddLineToPoint(context, midx, maxy+10);
    CGContextAddLineToPoint(context, midx-10, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

@end
