//
//  CommentViewViewController.h
//  TShow
//
//  Created by 陈锦滔 on 2017/2/24.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCellMessage.h"

@interface CommentViewViewController : UIViewController
@property (strong,nonatomic) HomeCellMessage *cellMessage;
@property (strong,nonatomic) NSArray *commentArray;
@end
