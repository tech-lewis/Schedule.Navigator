//
//  TabTrayController.h
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/23.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TabManager;
@interface TabTrayController : UIViewController
@property (nonatomic, strong) TabManager *tabManager;
@end

NS_ASSUME_NONNULL_END
