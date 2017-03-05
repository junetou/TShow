//
//  AndyDropDownButton.m
//  TShow
//
//  Created by 陈锦滔 on 2017/2/23.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "AndyDropDownButton.h"
#import <Masonry.h>

@interface AndyDropDownButton()
@property (strong,nonatomic) UIButton *addFriBtn;
@property (strong,nonatomic) UILabel *addFriLabel;
@property (strong,nonatomic) UIView *bgView;
@end

@implementation AndyDropDownButton
- (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)array{
    if(self=[super initWithFrame:frame]){
        self.backgroundColor=[UIColor blackColor];
    }
    return self;
}

- (void)Btn:(UIButton *)btn{
    [self hideList:btn];
}

- (UIView *)bgView{
    if(!_bgView){
        _bgView=[[UIView alloc] initWithFrame:self.frame];
        self.addFriBtn=[[UIButton alloc] init];
        [self.addFriBtn setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        self.addFriBtn.tag=AndyDropDownButtonTypeFri;
        [_addFriBtn addTarget:self action:@selector(Btn:) forControlEvents:UIControlEventTouchUpInside];
        self.addFriLabel=[[UILabel alloc] init];
        self.addFriLabel.text=@"添加好友";
        self.addFriLabel.textColor=[UIColor blackColor];
        self.addFriLabel.font=[UIFont systemFontOfSize:10];
        self.addFriLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _bgView;
}

- (void)showList{
    [UIView animateWithDuration:0.25f animations:^{
        [self addSubview:self.bgView];
        self.bgView.frame=CGRectMake(0, 0, self.frame.size.width, 50);
        self.bgView.backgroundColor=[UIColor colorWithRed:254/255.0 green:67/255.0 blue:101/255.0 alpha:1.0];
        [_bgView addSubview:_addFriBtn];
        [_bgView addSubview:_addFriLabel];
        [_addFriLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bgView.mas_left).offset(2);
            make.top.mas_equalTo(_bgView.mas_top).offset(0);
            make.height.mas_equalTo(20);
        }];
        [_addFriBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bgView.mas_left).offset(5);
            make.top.mas_equalTo(_addFriLabel.mas_bottom).offset(-5);
            make.height.mas_equalTo(30);
        }];
    }];
}

- (void)hideList:(UIButton *)btn{
    if(btn){
        [UIView animateWithDuration:0.25f animations:^{
        _bgView.frame=CGRectMake(0, 0, self.frame.size.width, 0);
        }];
        [_addFriLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bgView.mas_left).offset(2);
            make.top.mas_equalTo(_bgView.mas_top).offset(2);
            make.height.mas_equalTo(0);
        }];
        [_addFriBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bgView.mas_left).offset(2);
            make.top.mas_equalTo(_addFriLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(0);
        }];
        if([self.delegate respondsToSelector:@selector(ButtonMessage:)]){
            [self.delegate ButtonMessage:[NSString stringWithFormat:@"%lu",btn.tag]];
        }
    }else{
        [UIView animateWithDuration:0.25f animations:^{
           _bgView.frame=CGRectMake(0, 0, self.frame.size.width, 0);
        }];
    }
}

@end
