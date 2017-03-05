//
//  CellHeight.m
//  TShow
//
//  Created by 陈锦滔 on 2017/2/22.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "MapViewHeight.h"
#import <UIKit/UIKit.h>

@implementation MapViewHeight

/*
  String --字体
  IsShow --是否展开
  LableWidth --cell宽度
  Font --字体宽度
  DefaultHeight --字体不展开时默认的宽度
  FixedHeight --固件高度
  IsShowBtn --按钮的高度
*/

+ (CGFloat)cellHeightWithString:(NSString *)contentStr andIsShow:(BOOL)isShow andLableWidth:(CGFloat)width andFont:(CGFloat)font andDefaultHeight:(CGFloat)defaultHeight andFixedHeight:(CGFloat)fixedHeight andIsShowBtn:(CGFloat)btnHeight
{
    CGRect rect = [contentStr boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    if (rect.size.height > defaultHeight) {
        return btnHeight + rect.size.height;
    } else {
        return defaultHeight+btnHeight;
    }
}

@end
