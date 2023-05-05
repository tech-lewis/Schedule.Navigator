//
//  TabTableDelegate.h
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/23.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Browser;
NS_ASSUME_NONNULL_BEGIN
@interface TabTableDelegate: NSObject

@property (nonatomic, strong) NSArray *tabs;
@property (nonatomic, copy) void (^selectCallback)(Browser *);
- (instancetype)initWithTabs:(NSArray *)tabs selectCallback:(void (^)(Browser *))selectCallback;
@end
NS_ASSUME_NONNULL_END
