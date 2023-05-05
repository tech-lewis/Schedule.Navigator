//
//  ToolbarContainerView.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/17.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "ToolbarContainerView.h"
#import "ToolbarButton.h"
// 浏览器
#define DIVIDER_HEIGHT 4.0
#define BUTTON_SIZE_W 72
#define BUTTON_SIZE_H 56
#define DIVIDER_COLOR [UIColor colorWithRed:255.0/255.0 green:149.0/255.0 blue:0.0 alpha:1.0]

@implementation ToolbarContainerView
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, DIVIDER_COLOR.CGColor);
    CGContextFillRect(context, CGRectMake(0, self.frame.size.height-DIVIDER_HEIGHT, self.frame.size.width, DIVIDER_HEIGHT));
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGPoint origin = CGPointMake((self.frame.size.width - [self.subviews count] * BUTTON_SIZE_W) / 2.0f,
                                (self.frame.size.height - BUTTON_SIZE_H) / 2.0f);
  origin.y += 15 - DIVIDER_HEIGHT;
  // 添加到顶部
  for (UIView *view in self.subviews) {
      view.frame = CGRectMake(origin.x, origin.y, view.frame.size.width, view.frame.size.height);
      origin.x += BUTTON_SIZE_W;
  }
}

@end
