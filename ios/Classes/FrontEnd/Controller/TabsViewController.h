//
//  TabsViewController.h
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/18.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabsViewController : UITableViewController
@property (nonatomic, assign) int first;
@property (nonatomic, assign) int last;
- (instancetype)initWithStart:(int)first end:(int)last;
@end

NS_ASSUME_NONNULL_END
