//
//  BrowserToolbar.h
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/21.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BrowserToolbarDelegate <NSObject>
- (void)didClickBack;
- (void)didClickForward;
- (void)didEnterURL:(NSURL *)url;
- (void)didClickAddTab;
@end
@class ToolbarTextField;
@interface BrowserToolbar : UIView
@property (nonatomic, strong) ToolbarTextField *toolbarTextField;
@property (nonatomic, weak) id<BrowserToolbarDelegate> browserToolbarDelegate;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)updateTabCount:(NSInteger)count;
- (void)updateUrlAddress:(NSString *)address;
@end

NS_ASSUME_NONNULL_END
