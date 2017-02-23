//
//  AndyDropDownButton.h
//  TShow
//
//  Created by 陈锦滔 on 2017/2/23.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AndyDropDownButton;
@protocol  AndyDropDownButtonDelegate <NSObject>
- (void) ButtonMessage:(NSString *)message;
@end

@interface AndyDropDownButton : UIView
@property (strong,nonatomic) NSArray *arrayList;
- (void)showList;
- (void)hideList;
@property (strong,nonatomic) id<AndyDropDownButtonDelegate> delegate;
@end
