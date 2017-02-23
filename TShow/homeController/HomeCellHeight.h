//
//  CellHeight.h
//  TShow
//
//  Created by 陈锦滔 on 2017/2/22.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HomeCellHeight : NSObject



+ (CGFloat)cellHeightWithString:(NSString *)contentStr andIsShow:(BOOL)isShow andLableWidth:(CGFloat)width  andFont:(CGFloat)font andDefaultHeight:(CGFloat)defaultHeight andFixedHeight:(CGFloat)fixedHeight andIsShowBtn:(CGFloat)btnHeight;

@end
