//
//  CustomerMAPointAnnotation.h
//  ZuZu
//
//  Created by 陈锦滔 on 2017/2/27.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CustomerMAPointAnnotation : MAPointAnnotation
/*!
 @brief 用来判断是需求还是出租，yes是需求，no是出租
 @return 生成的标注View
 */
@property (assign,nonatomic) BOOL barCode;//判断是需求还是出租
/*!
 @brief 需求的ID
 @return 生成的标注View
 */
@property (strong,nonatomic) NSString* identification;//ID

@property (strong,nonatomic) NSString *userId;

@property (strong,nonatomic) NSString* userName;

@property (strong,nonatomic) NSString* userPrestige;

@property (strong,nonatomic) NSString* name;

@property (strong,nonatomic) NSString* addr;

@property (strong,nonatomic) NSString* money;

@property (strong,nonatomic) NSString* timer;

@property (strong,nonatomic) NSString* info;

@property (strong,nonatomic) NSString *pic1;

@property (strong,nonatomic) NSString *pic2;

@property (strong,nonatomic) NSString *pic3;

@end
