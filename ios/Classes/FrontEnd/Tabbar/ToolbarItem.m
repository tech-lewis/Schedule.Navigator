//
//  ToolbarItem.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/17.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "ToolbarItem.h"

@implementation ToolbarItem

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName viewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        _title = title;
        _imageName = imageName;
        _viewController = viewController;
    }
    return self;
}

@end
