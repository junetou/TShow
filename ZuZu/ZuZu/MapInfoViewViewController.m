//
//  CommentViewViewController.m
//  TShow
//
//  Created by 陈锦滔 on 2017/2/24.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "MapInfoViewViewController.h"
#import <Masonry.h>
#import <YYText.h>

@interface MapInfoViewViewController ()
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIImageView *headImg;
@property (strong,nonatomic) UILabel *userName;
@property (strong,nonatomic) UILabel *prestige;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *addr;
@property (strong,nonatomic) UILabel *timer;
@property (strong,nonatomic) UILabel *money;
@property (strong,nonatomic) UITextView *infoView;
@property (strong,nonatomic) UIImageView *img1Img;
@property (strong,nonatomic) UIImageView *img2Img;
@property (strong,nonatomic) UIImageView *img3Img;
@property (strong,nonatomic) UIView *imgBackground;
@property (strong,nonatomic) NSString *fontErrorMessage;
@property (strong,nonatomic) UIView *lineView;
@property (strong,nonatomic) UIView *commentLineView;
@end

@implementation MapInfoViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(popView)];
    self.navigationItem.leftBarButtonItem=leftBtn;
    self.navigationItem.title=@"Message";
    self.view.backgroundColor=[UIColor whiteColor];
    self.view.frame=[UIScreen mainScreen].bounds;
    _scrollView=[[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.backgroundColor=[UIColor colorWithWhite:0.7 alpha:0.7];
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.frame.size.height);
    }];

    _headImg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _headImg.image=[UIImage imageNamed:@"123"];
    _headImg.layer.borderColor=[UIColor purpleColor].CGColor;
    _headImg.layer.borderWidth=2;
    [_scrollView addSubview:_headImg];
    [_headImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_scrollView.mas_centerX).offset(0);
        make.top.mas_equalTo(_scrollView.mas_top).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];

    _userName=[[UILabel alloc] init];
    _userName.text=@"用户名:T.x";
    _userName.textColor=[UIColor blackColor];
    _userName.font=[UIFont systemFontOfSize:15];
    [_scrollView addSubview:_userName];
    [_userName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_headImg.mas_centerX).offset(-50);
        make.top.mas_equalTo(_headImg.mas_bottom).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25);
    }];
    _prestige=[[UILabel alloc] init];
    _prestige.text=@"用户信誉:15";
    _prestige.textColor=[UIColor redColor];
    _prestige.font=[UIFont systemFontOfSize:15];
    [_scrollView addSubview:_prestige];
    [_prestige mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userName.mas_right).offset(10);
        make.top.mas_equalTo(_headImg.mas_bottom).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(25);
    }];
    
    _name=[[UILabel alloc] init];
    _name.text=@"名称:3/天";
    _name.font=[UIFont systemFontOfSize:15];
    [_scrollView addSubview:_name];
    [_name mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_userName.mas_bottom);
        make.width.mas_equalTo(self.view.frame.size.width/3);
        make.height.mas_equalTo(25);
    }];
    _timer=[[UILabel alloc] init];
    _timer.text=@"可用时间:3/天";
    _timer.font=[UIFont systemFontOfSize:15];
    [_scrollView addSubview:_timer];
    [_timer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(-10);
        make.top.mas_equalTo(_userName.mas_bottom);
        make.width.mas_equalTo(self.view.frame.size.width/3);
        make.height.mas_equalTo(25);
    }];
    _money=[[UILabel alloc] init];
    _money.text=@"价格¥:3(每天)";
    _money.font=[UIFont systemFontOfSize:15];
    [_scrollView addSubview:_money];
    [_money mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-2);
        make.top.mas_equalTo(_userName.mas_bottom).offset(0);
        make.width.mas_equalTo(self.view.frame.size.width/3);
        make.height.mas_equalTo(25);
    }];

    _addr=[[UILabel alloc] init];
    _addr.numberOfLines=2;
    _addr.text=@"广东省佛山市禅城区张槎街道张槎中学旁";
    _addr.textAlignment=NSTextAlignmentCenter;
    [_addr setFont:[UIFont systemFontOfSize:14]];
    [_scrollView addSubview:_addr];
    [_addr mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left).offset(5);
        make.top.mas_equalTo(_money.mas_bottom).offset(10);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(15);
    }];
  
    _infoView=[[UITextView alloc] init];
    _infoView.text=@"是任天堂最初于2011年推出的第四代便携式游戏机，是任天堂DS的后续机种。其利用了视差障壁技术，让玩家不需配戴特殊眼镜即可感受到裸眼3D图像。该平台向下兼容任天堂DS软件。2012年9月发行繁体中文版";
    CGRect rect=[_infoView.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    _infoView.userInteractionEnabled=NO;
    [_scrollView addSubview:_infoView];
    [_infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.top.mas_equalTo(_addr.mas_bottom).offset(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        if(rect.size.height<40){
        make.height.mas_equalTo(40);
        }else{
        make.height.mas_equalTo(rect.size.height*1.3);
        }
     }];
  
    _lineView=[[UIView alloc] init];
    _lineView.backgroundColor=[UIColor orangeColor];
    [_scrollView addSubview:_lineView];
    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left).offset(20);
         make.right.mas_equalTo(_scrollView.mas_right).offset(-20);
        make.top.mas_equalTo(_addr.mas_bottom).offset(0);
        make.width.mas_equalTo(self.view.frame.size.width/1.2);
        make.height.mas_equalTo(1);
    }];
  
    _imgBackground=[[UIImageView alloc] init];
    _imgBackground.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.5];
    _imgBackground.layer.borderColor=[UIColor purpleColor].CGColor;
    [_scrollView addSubview:_imgBackground];
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(5);
        make.top.equalTo(_infoView.mas_bottom).offset(30);
        make.width.mas_equalTo(self.view.mas_width).offset(-10);
        make.height.mas_equalTo(90);
    }];
    [self FontDownloaded:@"STXingkai-SC-Light"];
    [self drawHead];
   /*
    _img1Img=[[UIImageView alloc] init];
    _img1Img.image=[UIImage imageNamed:@"123"];
    _img2Img=[[UIImageView alloc] init];
    _img2Img.image=[UIImage imageNamed:@"123"];
    _img3Img=[[UIImageView alloc] init];
    _img3Img.image=[UIImage imageNamed:@"123"];
    [_imgBackground addSubview:_img1Img];
    [_imgBackground addSubview:_img2Img];
    [_imgBackground addSubview:_img3Img];
    [_img1Img mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_imgBackground.mas_left).offset(5);
                make.top.mas_equalTo(_infoView.mas_bottom).offset(0);
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(60);
    }];
    [_img2Img mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_img1Img.mas_right).offset(5);
                make.top.mas_equalTo(_infoView.mas_bottom).offset(0);
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(60);
    }];
    [_img3Img mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_img2Img.mas_right).offset(5);
                make.right.mas_equalTo(_imgBackground.mas_right).offset(-5);
                make.top.mas_equalTo(_infoView.mas_bottom).offset(0);
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(60);
    }];
    
    _commentLineView=[[UIView alloc] init];
    _commentLineView.backgroundColor=[UIColor orangeColor];
    [_scrollView addSubview:_commentLineView];
    [_commentLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.top.mas_equalTo(_imgBackground.mas_bottom).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(1);
    }];
     */
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _scrollView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-50);
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, _headImg.frame.size.height+_imgBackground.frame.size.height+_addr.frame.size.height+_infoView.frame.size.height);
}

- (void)popView{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)FontDownloaded:(NSString *)fontName{
    UIFont* aFont = [UIFont fontWithName:fontName size:12.];
    //如果字体已经下载
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        _infoView.font = [UIFont fontWithName:fontName size:12.0];
        _name.font = [UIFont fontWithName:fontName size:12.0];
        _userName.font = [UIFont fontWithName:fontName size:12.0];
        _prestige.font = [UIFont fontWithName:fontName size:12.0];
        _timer.font = [UIFont fontWithName:fontName size:12.0];
        _addr.font = [UIFont fontWithName:fontName size:12.0];
        _money.font = [UIFont fontWithName:fontName size:12.0];
        return;
    }
    // 用字体的 PostScript 名字创建一个 Dictionary
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];
    // 创建一个字体描述对象 CTFontDescriptorRef
    CTFontDescriptorRef desc=CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    // 将字体描述对象放到一个 NSMutableArray 中
    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)desc];
    CFRelease(desc);
    
    __block BOOL errorDuringDownload = NO;
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler( (__bridge CFArrayRef)descs, NULL,  ^(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {
        
        if (state == kCTFontDescriptorMatchingDidBegin) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                _infoView.font  = [UIFont systemFontOfSize:12.0];
                _name.font = [UIFont systemFontOfSize:12.0];
                _userName.font = [UIFont systemFontOfSize:12.0];
                _prestige.font = [UIFont systemFontOfSize:12.0];
                _timer.font = [UIFont systemFontOfSize:12.0];
                _addr.font = [UIFont systemFontOfSize:12.0];
                _money.font = [UIFont systemFontOfSize:12.0];
            });
        } else if (state == kCTFontDescriptorMatchingDidFinish) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                if (!errorDuringDownload) {
                    _infoView.font =[UIFont fontWithName:fontName size:12.0];
                    _name.font = [UIFont fontWithName:fontName size:12.0];
                    _userName.font = [UIFont fontWithName:fontName size:12.0];
                    _prestige.font = [UIFont fontWithName:fontName size:12.0];
                    _timer.font = [UIFont fontWithName:fontName size:12.0];
                    _addr.font = [UIFont fontWithName:fontName size:12.0];
                    _money.font = [UIFont fontWithName:fontName size:12.0];
                }
            });
        }
        else if (state == kCTFontDescriptorMatchingDidFailWithError) {
            NSLog(@"error!");
        }
        return (bool)YES;
    });
}

- (void)drawHead{
    self.headImg.layer.shadowColor=[[UIColor purpleColor] colorWithAlphaComponent:0.5].CGColor;
    self.headImg.layer.shadowOffset=CGSizeMake(0, 0);
    self.headImg.layer.shadowOpacity=1;
    self.headImg.layer.shadowRadius=2;
    UIBezierPath *path=[UIBezierPath bezierPath];
    float width=self.headImg.frame.size.width;
    float height=self.headImg.frame.size.height;
    float x=_headImg.frame.origin.x;
    float y=_headImg.frame.origin.y;
    float WH=5;
    NSLog(@"%f,%f,%f",height,x,y);
    
    CGPoint topLeft=_headImg.bounds.origin;
    CGPoint topMiddle=CGPointMake(x+width/2, y-WH);
    CGPoint topRight=CGPointMake(x, y+width);
    
    CGPoint rightMiddle=CGPointMake(x+width+WH,y+height/2);
    
    CGPoint bottomLeft=CGPointMake(x, y+height);
    CGPoint bottomMiddle=CGPointMake(x+width/2,y+height+WH);
    CGPoint bottomRight=CGPointMake(x+width, y+height);
    
    CGPoint leftMiddle=CGPointMake(x-WH,y+height);
    
    [path moveToPoint:topLeft];
    [path addQuadCurveToPoint:topRight controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft controlPoint:leftMiddle];
    
    _headImg.layer.shadowPath=path.CGPath;
}

@end
