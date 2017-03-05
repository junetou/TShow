//
//  CustomerMAPointAnnotationView.h
//  ZuZu
//
//  Created by 陈锦滔 on 2017/2/28.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomerMAPointAnnotation.h"

@interface CustomerMAPointAnnotationView : MAAnnotationView
@property (strong,nonatomic) CustomerMAPointAnnotation *annotations;
@end
