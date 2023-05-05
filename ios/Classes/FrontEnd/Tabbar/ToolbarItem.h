//
//  ToolbarItem.h
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/17.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ToolbarItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) UIViewController *viewController;
- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName viewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
