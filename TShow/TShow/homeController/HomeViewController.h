//
//  HomeViewController.h
//  TShow
//
//  Created by 陈锦滔 on 2017/2/22.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TabBarDelegate<NSObject>
-(BOOL)makeTabBarHidden:(BOOL)hide;
@end

@interface HomeViewController : UIViewController
@property (strong,nonatomic) id<TabBarDelegate> delegate;
@end
