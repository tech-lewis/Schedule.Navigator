//
//  TabTableDataSource.h
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/23.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Browser;
NS_ASSUME_NONNULL_BEGIN

@interface TabTableDataSource : NSObject

@property (nonatomic, strong) NSMutableArray *tabs;
@property (nonatomic, strong) Browser *selectedTab;
@property (nonatomic, copy) void (^removeCallback)(Browser *);

- (instancetype)initWithTabs:(NSMutableArray *)tabs selectedTab:(Browser *)selectedTab removeCallback:(void (^)(Browser *))removeCallback;
@end

NS_ASSUME_NONNULL_END
