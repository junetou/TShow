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

typedef NS_ENUM(NSInteger,AndyDropDownButtonType){
    AndyDropDownButtonTypeFri=1200
};

@interface AndyDropDownButton : UIView
- (void)showList;
- (void)hideList:(UIButton *)btn;
@property (strong,nonatomic) id<AndyDropDownButtonDelegate> delegate;
@end
