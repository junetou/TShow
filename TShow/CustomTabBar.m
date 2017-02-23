//
//  CustomTabBar.m
//  TShow
//
//  Created by 陈锦滔 on 2017/2/21.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "CustomTabBar.h"

@interface CustomTabBar()
@property (strong,nonatomic) NSArray *dataList;
@property (strong,nonatomic) UIImageView *bgImageView;
@property (strong,nonatomic) UIButton *sendBtn;
@property (strong,nonatomic) UIButton *lastBtn;
@end

@implementation CustomTabBar

- (NSArray *)dataList{
    if(!_dataList){
        _dataList=@[@"tab_live",@"tab_me"];
    }
    return _dataList;
}

- (UIImageView *)bgImageView{
    if(!_bgImageView){
        _bgImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
        _bgImageView.frame=self.bounds;
    }
    return _bgImageView;
}

- (UIButton *)sendBtn{
    if(!_sendBtn){
        _sendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        _sendBtn.frame=CGRectMake(0, 0, self.bounds.size.width/2,self.bounds.size.height*1.2);
        [_sendBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.tag=CustomTabBarTypeSend;
    }
    return _sendBtn;
}

- (void)clickAction:(UIButton *)btn{
    if([self.delegate respondsToSelector:@selector(selectBarItemWithType:)]){
        [self.delegate selectBarItemWithType:btn.tag];
    }
    
    if(btn.tag==CustomTabBarTypeSend){
        return ;
    }
    
    self.lastBtn.selected=NO;
    btn.selected=YES;
    self.lastBtn=btn;
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform=CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.transform=CGAffineTransformMakeScale(1.0,1.0);
        }];
    }];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self addSubview:self.bgImageView];
        for(int i=0;i<self.dataList.count;i++){
            UIButton *itemButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [itemButton setImage:[UIImage imageNamed:self.dataList[i]] forState:UIControlStateNormal];
            [itemButton setImage:[UIImage imageNamed:[self.dataList[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            [itemButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            itemButton.tag = CustomTabBarTypeHome + i;
            
            if(i==0){
                itemButton.selected=YES;
                self.lastBtn=itemButton;
            }
            [self addSubview:itemButton];
        }
        [self addSubview:self.sendBtn];
    }
    return self;
}

- (void)layoutSubviews{
    CGFloat width=[UIScreen mainScreen].bounds.size.width/_dataList.count;
    for(UIView *view in self.subviews){
        if(view.tag>=CustomTabBarTypeHome){
            view.frame=CGRectMake((view.tag - CustomTabBarTypeHome)*width, 0, width, self.frame.size.height);
        }
    }
    self.sendBtn.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 22);
    self.bgImageView.frame=self.bounds;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view=[super hitTest:point withEvent:event];
    if(view==nil){
        CGPoint newPoint=[self.sendBtn convertPoint:point fromView:self];
        if(CGRectContainsPoint(self.sendBtn.bounds, newPoint)){
            view=self.sendBtn;
        }
    }
    return view;
}

@end
