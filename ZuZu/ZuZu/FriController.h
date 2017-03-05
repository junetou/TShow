//
//  Fri.h
//  ZuZu
//
//  Created by 陈锦滔 on 2017/2/26.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriControllerDelegate <NSObject>
- (void)switchView;
@end

@interface FriController : UIView
@property (strong,nonatomic) id<FriControllerDelegate> delegate;
@end
