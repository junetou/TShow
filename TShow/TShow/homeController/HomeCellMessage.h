//
//  HomeCellMessage.h
//  TShow
//
//  Created by 陈锦滔 on 2017/2/22.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCellMessage : NSObject
@property (strong,nonatomic)NSString *headPic;
@property (strong,nonatomic)NSString *userName;
@property (strong,nonatomic)NSString *sendTimer;
@property (strong,nonatomic)NSString *sendAddr;
@property (strong,nonatomic)NSString *info;
@property (strong,nonatomic)NSArray  *picArray;
@end
