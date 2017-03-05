//
//  CustomCalloutView.h
//  ZuZu
//
//  Created by 陈锦滔 on 2017/2/28.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCalloutView : UIView
@property (strong,nonatomic) UIImage *pic;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *subTitle;
@property (strong,nonatomic) NSString *addr;
@property (strong,nonatomic) NSString *userTimer;
@property (strong,nonatomic) UIImageView *pushBtn;
@property (assign,nonatomic) BOOL barCode;
- (instancetype)initWithFrame:(CGRect)frame withPic:(NSString *)pic withTitle:(NSString *)title withSubTitle:(NSString *)subTitle withAddr:(NSString *)addr withUserTimer:(NSString *)userTimer;
@end
