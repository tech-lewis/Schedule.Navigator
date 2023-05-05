//
//  TabBarViewController.h
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/17.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ToolbarItem;
@class ToolbarButton;
NS_ASSUME_NONNULL_BEGIN

@interface TabBarViewController : UIViewController
@property (nonatomic, assign) NSInteger selectedButtonIndex; // defaut -1
@property (nonatomic, strong) NSArray<ToolbarItem *> *items;
@property (nonatomic, strong) NSArray<ToolbarButton *> *buttons;
@end

NS_ASSUME_NONNULL_END
