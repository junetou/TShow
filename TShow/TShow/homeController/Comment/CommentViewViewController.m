//
//  CommentViewViewController.m
//  TShow
//
//  Created by 陈锦滔 on 2017/2/24.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "CommentViewViewController.h"
#import <Masonry.h>
#import <YYText.h>
#import <UIImageView+WebCache.h>
#import "CommentMessage.h"
#import "HeroModel.h"
#import "ViewController.h"

@interface CommentViewViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIImageView *headImg;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *addr;
@property (strong,nonatomic) UILabel *timer;
@property (strong,nonatomic) UITextView *infoView;
@property (strong,nonatomic) UIImageView *img1Img;
@property (strong,nonatomic) UIImageView *img2Img;
@property (strong,nonatomic) UIImageView *img3Img;
@property (strong,nonatomic) UIView *imgBackground;
@property (strong,nonatomic) NSString *fontErrorMessage;
@property (strong,nonatomic) UIView *lineView;
@property (strong,nonatomic) UIView *commentLineView;
@property (strong,nonatomic) UITableView *commentTableView;
@property (strong,nonatomic) UIView *sendView;
@property (strong,nonatomic) UITextField *send;
@property (strong,nonatomic) UIButton *sendBtn;
@end

@implementation CommentViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(popView)];
    self.navigationItem.leftBarButtonItem=leftBtn;
    self.navigationItem.title=@"Message";
    self.view.backgroundColor=[UIColor whiteColor];
    self.view.frame=[UIScreen mainScreen].bounds;
    _scrollView=[[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.scrollEnabled=YES;
    UITapGestureRecognizer *tag=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerborderStyle)];
    [self.view addGestureRecognizer:tag];
    [self.view addSubview:_scrollView];
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.frame.size.height);
    }];
    
    _headImg=[[UIImageView alloc] init];
    [_headImg sd_setImageWithURL:[NSURL URLWithString:self.cellMessage.headPic] placeholderImage:[UIImage imageNamed:@"123"]];
    _headImg.layer.borderColor=[UIColor purpleColor].CGColor;
    _headImg.layer.borderWidth=2;
    [_scrollView addSubview:_headImg];
    [_headImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left).offset(5);
        make.top.mas_equalTo(_scrollView.mas_top).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    _name=[[UILabel alloc] init];
    _name.text=self.cellMessage.userName;
    _name.textColor=[UIColor blackColor];
    [_scrollView addSubview:_name];
    [_name mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImg.mas_right).offset(5);
        make.top.mas_equalTo(_scrollView.mas_top).offset(0);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(25);
    }];
    _timer=[[UILabel alloc] init];
    _timer.text=self.cellMessage.sendTimer;
    [_scrollView addSubview:_timer];
    [_timer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImg.mas_right).offset(5);
        make.top.mas_equalTo(_name.mas_bottom).offset(0);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(25);
    }];
    
    _addr=[[UILabel alloc] init];
    _addr.numberOfLines=2;
    _addr.text=self.cellMessage.sendAddr;
    [_scrollView addSubview:_addr];
    [_addr mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left).offset(5);
        make.top.mas_equalTo(_headImg.mas_bottom).offset(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(15);
    }];
    
    _infoView=[[UITextView alloc] init];
    _infoView.text=self.cellMessage.info;
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
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(_addr.mas_bottom).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(1);
    }];
    
    [self FontDownloaded:@"DFWaWaSC-W5"];
    
    _imgBackground=[[UIImageView alloc] init];
    _imgBackground.backgroundColor=[[UIColor purpleColor] colorWithAlphaComponent:0.5];
    _imgBackground.layer.borderColor=[UIColor purpleColor].CGColor;
    [_scrollView addSubview:_imgBackground];
    [_imgBackground mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.mas_equalTo(_infoView.mas_bottom).offset(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(60);
    }];
    NSInteger num=0;
    for(NSInteger i=0;i<self.cellMessage.picArray.count;i++) {
        HeroModel *model=self.cellMessage.picArray[i];
        switch (i) {
            case 0:
            {
                _img1Img=[[UIImageView alloc] init];
                [_img1Img sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:[UIImage imageNamed:@"123"]];
                num++;
                break;
            }
                break;
            case 1:{
                 _img2Img=[[UIImageView alloc] init];
                 [_img2Img sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:[UIImage imageNamed:@"123"]];
                num++;
                break;
            }
                break;
            case 2:{
                 _img3Img=[[UIImageView alloc] init];
                 [_img3Img sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:[UIImage imageNamed:@"123"]];
                num++;
                break;
            }
                break;
            default:
                break;
        }
    }
    
    switch (num) {
        case 1:
        {
            [_imgBackground addSubview:_img1Img];
            [_img1Img mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_imgBackground.mas_left).offset(0);
                make.top.mas_equalTo(_infoView.mas_bottom).offset(20);
                make.width.mas_equalTo(_imgBackground.frame.size.width);
                make.height.mas_equalTo(60);
            }];
            break;
        }
            break;
        case 2:
        {
            [_imgBackground addSubview:_img1Img];
            [_imgBackground addSubview:_img2Img];
            [_img1Img mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_imgBackground.mas_left).offset(5);
                make.top.mas_equalTo(_infoView.mas_bottom).offset(0);
                make.width.mas_equalTo(150);
                make.height.mas_equalTo(60);
            }];
            [_img2Img mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_imgBackground.mas_right).offset(5);
                make.top.mas_equalTo(_infoView.mas_bottom).offset(0);
                make.width.mas_equalTo(150);
                make.height.mas_equalTo(60);
            }];
            break;
        }
            break;
        case 3:
        {
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
            break;
        }
            break;
        default:
            break;
    }
    
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
    
    _commentTableView=[[UITableView alloc] init];
    _commentTableView.delegate=self;
    _commentTableView.dataSource=self;
    _commentTableView.scrollEnabled=NO;
    [_scrollView addSubview:_commentTableView];
    [_commentTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left).offset(5);
        make.right.mas_equalTo(_scrollView.mas_right).offset(-5);
        make.top.mas_equalTo(_commentLineView.mas_bottom).offset(5);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.commentArray.count*45+10);
    }];
    
    _sendView =[[UIView alloc] init];
    _sendView.backgroundColor=[UIColor whiteColor];
    _send=[[UITextField alloc] init];
    _send.placeholder=@"请输入文字";
    _send.delegate=self;
    _send.layer.borderColor=[[UIColor grayColor] colorWithAlphaComponent:0.8].CGColor;
    _send.layer.borderWidth=1;
    _sendBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_sendBtn setTitle:@"Send" forState:UIControlStateNormal];
    _sendBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    _sendBtn.layer.borderWidth=1;
    [self.view addSubview:_sendView];
    [_sendView addSubview:_send];
    [_sendView addSubview:_sendBtn];
    [_sendView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(30);
    }];
    [_send mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(-50);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.width.mas_equalTo(self.view.frame.size.width/1.5);
        make.height.mas_equalTo(30);
    }];
    [_sendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_send.mas_right).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(30);
    }];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _scrollView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-50);
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, _headImg.frame.size.height+_imgBackground.frame.size.height+_addr.frame.size.height+_infoView.frame.size.height+_commentTableView.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    CommentMessage *message=self.commentArray[indexPath.row];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.text=message.userName;
    cell.textLabel.textColor=[UIColor redColor];
    cell.textLabel.font=[UIFont systemFontOfSize:10];
    cell.imageView.layer.masksToBounds=YES;
    cell.imageView.layer.cornerRadius=20;
    cell.imageView.layer.borderWidth=1;
    cell.imageView.layer.borderColor=[UIColor orangeColor].CGColor;
    cell.detailTextLabel.text=message.info;
    cell.detailTextLabel.font=[UIFont systemFontOfSize:9];
    cell.detailTextLabel.textColor=[UIColor orangeColor];
    cell.detailTextLabel.numberOfLines = 0;
    //绘制图片
    cell.imageView.image=[UIImage imageNamed:@"123"];
    CGSize itemSize = CGSizeMake(30, 30);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return cell;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //设置编辑text时键盘上调
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = -250;
        self.view.frame = frame;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //结束时下调键盘
    [self registerborderStyle];
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = [UIScreen mainScreen].bounds;
    }];
}

- (UIImage *)scaleTosize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)FontDownloaded:(NSString *)fontName{
    UIFont* aFont = [UIFont fontWithName:fontName size:12.];
    //如果字体已经下载
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        _infoView.font = [UIFont fontWithName:fontName size:12.0];
        _name.font=[UIFont systemFontOfSize:16.0];
        _timer.font=[UIFont  systemFontOfSize:15.0];
        _addr.font=[UIFont  systemFontOfSize:14.0];
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
                _name.font=[UIFont systemFontOfSize:20.0];
                _timer.font=[UIFont  systemFontOfSize:15.0];
                _addr.font=[UIFont  systemFontOfSize:14.0];
            });
        } else if (state == kCTFontDescriptorMatchingDidFinish) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                if (!errorDuringDownload) {
                    _infoView.font =[UIFont fontWithName:fontName size:12.0];
                    _name.font=[UIFont fontWithName:fontName size:20.0];
                    _timer.font=[UIFont fontWithName:fontName size:15.0];
                    _addr.font=[UIFont fontWithName:fontName size:14.0];
                }
            });
        }
        else if (state == kCTFontDescriptorMatchingDidFailWithError) {
            NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
            if (error != nil) {
                _fontErrorMessage = [error description];
            } else {
                _fontErrorMessage = @"ERROR MESSAGE IS NOT AVAILABLE!";
            }
            errorDuringDownload = YES;//设置标志
            dispatch_async( dispatch_get_main_queue(), ^ {
                NSLog(@"下载失败: %@", _fontErrorMessage);
            });
        }
        return (bool)YES;
    });
}

- (void)registerborderStyle{
    [_send resignFirstResponder];
}

- (void)popView{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
