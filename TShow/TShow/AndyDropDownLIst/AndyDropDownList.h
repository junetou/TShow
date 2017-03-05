//
//  AndyDropDownList.h
//  ButtonMenu
//
//  Created by 陈锦滔 on 2017/2/20.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AndyDropDownListDelegate <NSObject>
- (void)Message:(NSString *)string;
@end

@interface AndyDropDownList : UIView
- (instancetype)initWithArray:(NSArray *)arrays frame:(CGRect)frame;
- (void)showList;
- (void)hideList;
@property (strong,nonatomic) id<AndyDropDownListDelegate> delegate;
@end
