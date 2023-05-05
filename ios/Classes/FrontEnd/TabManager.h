//
//  TabManager.h
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/23.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Browser.h"
@protocol TabManagerDelegate

- (void)didSelectedTabChangeWithSelected:(Browser *_Nullable)selected previous:(Browser *_Nullable)previous;
- (void)didAddTabWithTab:(Browser *_Nonnull)tab;
- (void)didRemoveTabWithTab:(Browser *_Nonnull)tab;

@end

@interface TabManager : NSObject

@property (nonatomic, weak, nullable) id<TabManagerDelegate> delegate;

@property (nonatomic, readonly) NSInteger count;
@property (nonatomic, readonly, nullable) Browser *selectedTab;
@property (nonatomic, readonly, nonnull) NSArray<Browser *> *tabs;

- (Browser * _Nonnull)getTabAtIndex:(NSInteger)index;
- (void)selectTab:(Browser *_Nullable)tab;
- (Browser *_Nonnull)addTab;
- (void)removeTab:(Browser *_Nonnull)tab;

@end
