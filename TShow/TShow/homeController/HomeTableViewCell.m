//
//  HomeTableViewCell.m
//  TShow
//
//  Created by 陈锦滔 on 2017/2/22.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "HomeTableViewCell.h"
#import <Masonry.h>
#import "SCAdView.h"
#import "SDPhotoBrowser.h"
#import "HeroModel.h"
#import <UIImageView+WebCache.h>
#import <YYText.h>
#define BOUNDS [UIScreen mainScreen].bounds

@interface HomeTableViewCell()<SCAdViewDelegate,SDPhotoBrowserDelegate>
{
      NSIndexPath *_cellIndexPath;  // 当前Cell的下标
}
@property (strong,nonatomic) NSArray *arrayList;
@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellContent:(NSString *)contentStr andIsShow:(BOOL)isShow andCellIndexPath:(NSIndexPath *)indexPath
            andHeadPic:(NSString *)headPic andUserName:(NSString *)userName andSendTimer:(NSString *)sendTimer
              andsendAddr:(NSString *)sendAddr andLoveNum:(NSString *)loveNum
{
    [_headPic sd_setImageWithURL:[NSURL URLWithString:headPic] placeholderImage:[UIImage imageNamed:@"love(1)"]];
    _userName.text=userName;
    _sendTimer.text=sendTimer;
    _sendAddr.text=sendAddr;
    _loveNum.text=loveNum;
    _info.text=contentStr;
    _cellIndexPath=indexPath;
    CGRect rect=[_info.text boundingRectWithSize:CGSizeMake(BOUNDS.size.width-30,1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    if(rect.size.height>52){
        _moreBtn.hidden=NO;
        if(isShow){
            _info.numberOfLines=0;
            [_info mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView.mas_left).offset(15);
                make.top.mas_equalTo(_headPic.mas_bottom).offset(5);
                make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width-30);
                make.height.mas_equalTo(rect.size.height+1);
            }];
        }else{
            _info.numberOfLines=3;
            [_info mas_remakeConstraints:^(MASConstraintMaker *make){
                make.left.mas_equalTo(self.contentView.mas_left).offset(15);
                make.top.mas_equalTo(_headPic.mas_bottom).offset(5);
                make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width-30);
                make.height.mas_equalTo(52);
            }];
        }
    }else{
        _info.numberOfLines=3;
        _moreBtn.hidden=YES;
        [_info mas_remakeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
            make.top.mas_equalTo(_headPic.mas_bottom).offset(5);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width-30);
            make.height.mas_equalTo(rect.size.height+1);  // 由于系统计算的那个高度有时候会有1像素到2像素的误差，所以这里把高度+1
        }];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier scAdViewArray:(NSArray *)scAdArray{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self layoutUI:scAdArray];
        self.tag=1001;
        self.backgroundColor=[UIColor whiteColor];
        _arrayList=[NSArray array];
        _arrayList=scAdArray;
        [self FontDownloaded:@"STXingkai-SC-Light"];
    }
    return self;
}

- (void)layoutUI:(NSArray *)scAdArray{
    _headPic=[[UIImageView alloc] init];
    _headPic.layer.masksToBounds=YES;
    _headPic.layer.cornerRadius=5;
    _headPic.layer.borderColor=[UIColor purpleColor].CGColor;
    _headPic.layer.borderWidth=1;
    [self.contentView addSubview:_headPic];
    [_headPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    _userName=[[UILabel alloc] init];
    _userName.text=@"";
    _userName.textColor=[UIColor blackColor];
    _userName.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headPic.mas_right).offset(5);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.width.mas_equalTo(BOUNDS.size.width/6);
        make.height.mas_equalTo(15);
    }];
    
    _sendTimer=[[UILabel alloc] init];
    _sendTimer.text=@"";
    _sendTimer.textColor=[UIColor blackColor];
    _sendTimer.font=[UIFont systemFontOfSize:9];
    [self.contentView addSubview:_sendTimer];
    [_sendTimer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headPic.mas_right).offset(5);
        make.top.mas_equalTo(_userName.mas_bottom).offset(0);
        make.width.mas_equalTo(BOUNDS.size.width/6);
        make.height.mas_equalTo(15);
    }];
    
    _ellipsis=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_ellipsis setTitle:@"•••" forState:UIControlStateNormal];
    [_ellipsis setTintColor:[UIColor grayColor]];
    _ellipsis.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_ellipsis];
    [_ellipsis mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.width.mas_equalTo(BOUNDS.size.width/6);
        make.height.mas_equalTo(30);
    }];
    
    _sendAddr=[[UILabel alloc] init];
    _sendAddr.text=@"";
    _sendAddr.textColor=[UIColor blackColor];
    _sendAddr.font=[UIFont systemFontOfSize:10];
    _sendAddr.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_sendAddr];
    [_sendAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userName.mas_right).offset(5);
        make.right.mas_equalTo(_ellipsis.mas_left).offset(0);
        make.bottom.mas_equalTo(_headPic.mas_bottom).offset(-_headPic.frame.size.height/2);
        make.height.mas_equalTo(30);  // 由于系统计算的那个高度有时候会有1像素到2像素的误差，所以这里把高度+1
    }];
    
    _info=[[UILabel alloc] init];
    _info.numberOfLines=3;
    _info.font=[UIFont systemFontOfSize:12];
    _info.textColor=[UIColor colorWithRed:107/255.0 green:90/255.0 blue:82/255.0 alpha:1.0];
    [self.contentView addSubview:_info];
    
    _moreBtn=[[UIButton alloc] init];
    _moreBtn.tag=HomeTableViewCellTypeMore;
    [_moreBtn setImage:[UIImage imageNamed:@"xiala"] forState:UIControlStateNormal];
    [_moreBtn setImage:[UIImage imageNamed:@"shangla"] forState:UIControlStateHighlighted];
    [_moreBtn addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(_info.mas_bottom).offset(-10);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_equalTo(30);
    }];
    
    SCAdView *adView = [[SCAdView alloc] initWithBuilder:^(SCAdViewBuilder *builder) {
        builder.adArray = scAdArray;
        builder.viewFrame = (CGRect){0,0,self.contentView.bounds.size.width,90};
        builder.adItemSize = (CGSize){self.contentView.bounds.size.width/2,70};
        builder.minimumLineSpacing = self.contentView.bounds.size.width/2;
        builder.secondaryItemMinAlpha = 0.6;
        builder.threeDimensionalScale = 1.45;
        builder.autoScrollDirection=YES;
        builder.allowedInfinite=YES;
        builder.infiniteCycle=3.0;
        builder.itemCellNibName = @"SCAdDemoCollectionViewCell";
    }];
    adView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    adView.delegate = self;
    _picBackView=adView;
    [self.contentView addSubview:_picBackView];
    [_picBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.top.mas_equalTo(_moreBtn.mas_bottom).offset(0);
        make.width.mas_equalTo(BOUNDS.size.width);
        make.height.mas_equalTo(90);//40
    }];
    
    _picRightButtomView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 10)];
    _picRightButtomView.backgroundColor=[UIColor clearColor];
    NSMutableString *string=[NSMutableString stringWithFormat:@""];
    for(NSInteger i=0;i<scAdArray.count;i++){
        [string stringByAppendingString:[NSString stringWithFormat:@"•"]];
    }
    UILabel *texts=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 10)];
    texts.text=string;
    texts.textAlignment=NSTextAlignmentCenter;
    texts.textColor=[[UIColor colorWithRed:252/255.0 green:157/255.0 blue:154/255.0 alpha:1.0] colorWithAlphaComponent:0.5];
    texts.textAlignment=NSTextAlignmentCenter;
    [_picRightButtomView addSubview:texts];
    [self.contentView addSubview:_picRightButtomView];
    [_picRightButtomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_picBackView.mas_centerX).offset(0);
        make.bottom.mas_equalTo(_picBackView.mas_bottom).offset(-3);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(10);//40
    }];
    
    _loveBtn=[[UIButton alloc] init];
    _loveBtn.tag=HomeTableViewCellTypeLove;
    _loveBtn.selected=NO;
    [_loveBtn setImage:[UIImage imageNamed:@"love(1)"] forState:UIControlStateNormal];
    [_loveBtn setImage:[UIImage imageNamed:@"love_p"] forState:UIControlStateSelected];
    [_loveBtn addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_loveBtn];
    [_loveBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-8);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    _loveNum=[[UILabel alloc] init];
    _loveNum.text=@"";
    _loveNum.textColor=[UIColor orangeColor];
    _loveNum.font=[UIFont systemFontOfSize:10];
    _loveNum.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_loveNum];
    [_loveNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_loveBtn.mas_right).offset(-5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-8);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);  // 由于系统计算的那个高度有时候会有1像素到2像素的误差，所以这里把高度+1
    }];
    
    _bubbleBtn=[[UIButton alloc] init];
    _bubbleBtn.tag=HomeTableViewCellTypeBubble;
    [_bubbleBtn setImage:[UIImage imageNamed:@"bubble(1)"] forState:UIControlStateNormal];
    [_bubbleBtn addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_bubbleBtn];
    [_bubbleBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(_loveNum.mas_right).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-8);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    _tagBtn=[[UIButton alloc] init];
    _tagBtn.tag=HomeTableViewCellTypeTag;
    [_tagBtn setImage:[UIImage imageNamed:@"tag(1)"] forState:UIControlStateNormal];
    [_tagBtn addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_tagBtn];
    [_tagBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.mas_equalTo(self.contentView.mas_right);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-8);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width/5);
        make.height.mas_equalTo(30);
    }];
    
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cxt, 16);
    CGContextSetStrokeColorWithColor(cxt, [UIColor colorWithRed:249/255.0 green:205/255.0 blue:173/255.0 alpha:0.3].CGColor);
    CGContextMoveToPoint(cxt, 0.0 , self.frame.size.height - 0.5);
    CGContextAddLineToPoint(cxt,self.frame.size.width , self.frame.size.height - 0.5);
    CGContextStrokePath(cxt);
    CGContextRef ref=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ref, 1);
    CGContextSetStrokeColorWithColor(ref, [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6] .CGColor);
    CGContextMoveToPoint(ref, 60, _headPic.frame.size.height+12);
    CGContextAddLineToPoint(ref,self.frame.size.width-60 , _headPic.frame.size.height+12);
    CGContextStrokePath(ref);
}

- (void)moreButtonClicked:(UIButton *)btn{
    if(btn.tag==HomeTableViewCellTypeMore){
        _moreBtn.selected=!_moreBtn.selected;
        if(_moreBtn.selected){
          [self.moreBtn setImage:[UIImage imageNamed:@"shangla"] forState:UIControlStateNormal];
        }else{
          [self.moreBtn setImage:[UIImage imageNamed:@"xiala"] forState:UIControlStateNormal];
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[NSNumber numberWithInteger:_cellIndexPath.row] forKey:@"row"];
        [dic setObject:[NSNumber numberWithBool:self.moreBtn.selected] forKey:@"isShow"];
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(HomeTableViewCellShowContrntWithDic:andCellIndexPath:)]){
            [self.delegate HomeTableViewCellShowContrntWithDic:dic andCellIndexPath:_cellIndexPath];
        }
    }else if(btn.tag<=HomeTableViewCellTypeTag && btn.tag>=HomeTableViewCellTypeLove){
        switch (btn.tag) {
            case 1000:
            {
                _loveBtn.selected=!_loveBtn.selected;
                [UIView animateWithDuration:0.3 animations:^{
                    btn.transform=CGAffineTransformMakeScale(1.2, 1.2);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        btn.transform=CGAffineTransformMakeScale(1.0, 1.0);
                    }];
                }];
                break;
            }
                break;
            default:
            {
                [UIView animateWithDuration:0.3 animations:^{
                    btn.transform=CGAffineTransformMakeScale(1.2, 1.2);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        btn.transform=CGAffineTransformMakeScale(1.0, 1.0);
                    }];
                }];
            }
                break;
        }
    }
}

- (void)FontDownloaded:(NSString *)fontName{
    UIFont* aFont = [UIFont fontWithName:fontName size:12.];
    //如果字体已经下载
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        _info.font = [UIFont fontWithName:fontName size:12.0];
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
                _info.font  = [UIFont systemFontOfSize:12.0];
            });
        } else if (state == kCTFontDescriptorMatchingDidFinish) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                if (!errorDuringDownload) {
                    _info.font =[UIFont fontWithName:fontName size:12.0];
                }
            });
        }
        else if (state == kCTFontDescriptorMatchingDidFailWithError) {
            NSLog(@"error!");
        }
        return (bool)YES;
    });
}


/*
 SCAdView Delegate
 */
-(void)sc_didClickAd:(id)adModel{
    HeroModel *index=(HeroModel *)adModel;
    SDPhotoBrowser *browser=[[SDPhotoBrowser alloc] init];
    //父视图
    browser.sourceImagesContainerView=self.contentView;
    browser.currentImageIndex=index.picTag;
    browser.imageCount=_arrayList.count;
    browser.delegate=self;
    [browser show];
}
-(void)sc_scrollToIndex:(NSInteger)index{
}

/*
 SDPhotoBrowser Delegate
 */
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    //拿到显示的图片的高清图片地
    HeroModel *model=[_arrayList objectAtIndex:index];
    NSString *string=model.imageName;
    NSURL *url =[NSURL URLWithString:string];
    return url;
}
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *image=[UIImageView new];
    HeroModel *model=[_arrayList objectAtIndex:index];
    NSString *string=model.imageName;
    [image sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:nil];
    image.frame=CGRectMake(50, 50, 100, 100);
    return image.image;
}

@end
