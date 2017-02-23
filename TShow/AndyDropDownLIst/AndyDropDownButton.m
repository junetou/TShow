//
//  AndyDropDownButton.m
//  TShow
//
//  Created by 陈锦滔 on 2017/2/23.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "AndyDropDownButton.h"

@interface AndyDropDownButton()
@end

@implementation AndyDropDownButton
- (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)array{
    if(self=[super initWithFrame:frame]){
        self.arrayList=array;
    }
    return self;
}

- (void)showList{
    
}

- (void)hideList{

}

@end
