//
//  HomeTableViewCell.h
//  TShow
//
//  Created by 陈锦滔 on 2017/2/22.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCAdView.h"

@class HomeTableViewCell;
typedef NS_ENUM(NSUInteger,HomeTableViewCellType){
    HomeTableViewCellTypeLove=1000,
    HomeTableViewCellTypeBubble=1001,
    HomeTableViewCellTypeTag=1002,
    HomeTableViewCellTypeMore=1100
};

@protocol HomeTableViewCellDelegate <NSObject>

- (void)HomeTableViewCellShowContrntWithDic:(NSDictionary *)dic andCellIndexPath:(NSIndexPath *)indexPath;

@end

@interface HomeTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView *headPic;
@property (strong,nonatomic) UILabel *userName;
@property (strong,nonatomic) UILabel *sendTimer;
@property (strong,nonatomic) UILabel *sendAddr;
@property (strong,nonatomic) UIButton *ellipsis;
@property (strong,nonatomic) UILabel *info;
@property (strong,nonatomic) UIView  *picBackView;
@property (strong,nonatomic) UIView  *picRightButtomView;
@property (strong,nonatomic) UIButton *moreBtn;
@property (strong,nonatomic) UIButton *loveBtn;
@property (strong,nonatomic) UILabel  *loveNum;
@property (strong,nonatomic) UIButton *bubbleBtn;
@property (strong,nonatomic) UIButton *tagBtn;

- (void)setCellContent:(NSString *)contentStr andIsShow:(BOOL)isShow andCellIndexPath:(NSIndexPath *)indexPath
            andHeadPic:(NSString *)headPic andUserName:(NSString *)userName andSendTimer:(NSString *)sendTimer
           andsendAddr:(NSString *)sendAddr andLoveNum:(NSString *)loveNum;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier scAdViewArray:(NSArray *)scAdArray;
@property (strong,nonatomic) id<HomeTableViewCellDelegate> delegate;

@end
