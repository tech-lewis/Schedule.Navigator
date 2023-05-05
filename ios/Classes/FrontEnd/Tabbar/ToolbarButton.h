//
//  ToolbarButton.h
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/17.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ToolbarItem;
NS_ASSUME_NONNULL_BEGIN

@interface ToolbarButton : UIButton
@property (nonatomic, strong) ToolbarItem *item;
- (instancetype)initWithToolbarItem:(ToolbarItem *)item;
@end

NS_ASSUME_NONNULL_END
