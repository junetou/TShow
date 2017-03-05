//
//  ViewController.m
//  Send
//
//  Created by 陈锦滔 on 2017/2/26.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()
@property (strong,nonatomic) UIView *bgView;
@property (strong,nonatomic) UIButton *leftBtn;
@property (strong,nonatomic) UIButton *rightBtn;
@property (strong,nonatomic) UITextView *textInfo;
@property (strong,nonatomic) UILabel *titleText;
@property (strong,nonatomic) UIButton *plusBtn;
@property (strong,nonatomic) UIButton *minusBtn;
@property (strong,nonatomic) UIImageView *img1;
@property (strong,nonatomic) UIImageView *img2;
@property (strong,nonatomic) UIImageView *img3;
@property (strong,nonatomic) UIButton *addrBtn;
@property (strong,nonatomic) UILabel *addrText;
@property (strong,nonatomic) UIButton *sendBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.8];
    self.view.userInteractionEnabled=YES;
    _bgView=[[UIView alloc] init];
    _bgView.frame=CGRectMake(0,self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_bgView];
    _bgView.userInteractionEnabled=YES;
    _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setImage:[UIImage imageNamed:@"trash"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(removeAll:) forControlEvents:UIControlEventTouchUpInside];
    _titleText=[[UILabel alloc] init];
    _titleText.text=@"发布";
    _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setImage:[UIImage imageNamed:@"jiaocha"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    _textInfo=[[UITextView alloc] init];
    _textInfo.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.5];
    _textInfo.layer.borderColor=[UIColor orangeColor].CGColor;
    _textInfo.layer.borderWidth=1;
    _plusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_plusBtn setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    [_plusBtn addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
    _minusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_minusBtn setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    [_minusBtn addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
    _img1=[[UIImageView alloc] init];
    _img1.image=[UIImage imageNamed:@"123"];
    _img1.layer.borderWidth=1;
    _img1.layer.borderColor=[UIColor purpleColor].CGColor;
    _img2=[[UIImageView alloc] init];
    _img2.image=[UIImage imageNamed:@"123"];
    _img2.layer.borderWidth=1;
    _img2.layer.borderColor=[UIColor purpleColor].CGColor;
    _img3=[[UIImageView alloc] init];
    _img3.image=[UIImage imageNamed:@"123"];
    _img3.layer.borderWidth=1;
    _img3.layer.borderColor=[UIColor purpleColor].CGColor;
    _addrBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _addrBtn.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.7];
    _addrText=[[UILabel alloc] init];
    _addrText.text=@"广东省佛山市禅城区懂啊回大的范围";
    _addrText.font=[UIFont systemFontOfSize:12];
    [_addrBtn setTitle:@"地址>" forState:UIControlStateNormal];
    [_addrBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    _sendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_sendBtn setImage:[UIImage imageNamed:@"upload"] forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_textInfo];
    [_bgView addSubview:_leftBtn];
    [_bgView addSubview:_rightBtn];
    [_bgView addSubview:_titleText];
    [_bgView addSubview:_plusBtn];
    [_bgView addSubview:_minusBtn];
    [_bgView addSubview:_img1];
    [_bgView addSubview:_img2];
    [_bgView addSubview:_img3];
    [_bgView addSubview:_addrBtn];
    [_bgView addSubview:_addrText];
    [_bgView addSubview:_sendBtn];
    [_leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bgView.mas_top).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    [_titleText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_bgView.mas_centerX);
        make.top.mas_equalTo(_bgView.mas_top).offset(10);
        make.height.mas_equalTo(30);
    }];
    [_rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bgView.mas_top).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    [_textInfo mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_rightBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(150);
    }];
    [_plusBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_textInfo.mas_bottom).offset(30);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    [_minusBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.mas_equalTo(_textInfo.mas_bottom).offset(30);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    [_img1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(5);
        make.top.mas_equalTo(_plusBtn.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    [_img2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(0);
        make.top.mas_equalTo(_plusBtn.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    [_img3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-5);
        make.top.mas_equalTo(_plusBtn.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    [_addrBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_bgView.mas_centerX);
        make.top.mas_equalTo(_img1.mas_bottom).offset(20);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(30);
    }];
    [_addrText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(_addrBtn.mas_bottom).offset(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(30);
    }];
    [_sendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeView{
    NSLog(@"ee");
}

- (void)addPic:(UIButton *)btn{
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform=CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform=CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

- (void)removeAll:(UIButton *)btn{
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform=CGAffineTransformRotate(btn.transform,M_PI_4*90);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
        btn.transform=CGAffineTransformRotate(btn.transform,-M_PI_4*90);
        }];
    }];
}

- (void)send{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"确定上传" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *no=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:yes];
    [controller addAction:no];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
