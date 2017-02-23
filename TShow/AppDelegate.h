//
//  AppDelegate.h
//  TShow
//
//  Created by 陈锦滔 on 2017/2/21.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

