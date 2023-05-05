//
//  ToolbarButton.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/17.
//  Copyright © 2023 Facebook. All rights reserved.
//
#import "ToolbarButton.h"
#import "ToolbarItem.h"
#import "ToolbarContainerView.h"
@implementation ToolbarButton

- (instancetype)initWithToolbarItem:(ToolbarItem *)item {
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/5, 56)];
    if (self) {
      self.item = item;
      [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"nav-%@-off", item.imageName]] forState:UIControlStateNormal];
      [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"nav-%@-on", item.imageName]] forState:UIControlStateSelected];
      self.titleLabel.font = [UIFont systemFontOfSize:13];
      self.titleLabel.textAlignment = NSTextAlignmentCenter;
      self.titleLabel.frame=CGRectMake(0, 56-20, [UIScreen mainScreen].bounds.size.width/5, 20);
      [self setTitle:item.title forState:UIControlStateNormal];
      [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.imageView) {
      //self.imageView.backgroundColor = [UIColor redColor];
      self.imageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
      self.imageView.frame =  CGRectMake(self.imageView.frame.origin.x, -10, self.imageView.frame.size.width, self.imageView.frame.size.height);
    }

    if (self.titleLabel) {
      self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.frame = CGRectMake(0, self.frame.size.height - self.titleLabel.frame.size.height-15, self.frame.size.width, self.titleLabel.frame.size.height);
    }
}

//    UIView *superView = sender.superview;
//    while (![superView isKindOfClass:[ToolbarContainerView class]]) {
//        superView = superView.superview;
//    }
//    ToolbarContainerView *containerView = (ToolbarContainerView *)superView;
//}

@end
