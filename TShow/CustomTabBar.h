//
//  CustomTabBar.h
//  TShow
//
//  Created by 陈锦滔 on 2017/2/21.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabBar;

typedef NS_ENUM(NSUInteger,CustomTabBarType){
    CustomTabBarTypeSend=100,
    CustomTabBarTypeHome=200,
    CustomTabBarTypeMe
};

@protocol CustomTabBarDelegate<NSObject>

- (void)selectBarItemWithType:(CustomTabBarType)type;

@end


@interface CustomTabBar : UIView

@property (strong,nonatomic) id<CustomTabBarDelegate> delegate;

@end
