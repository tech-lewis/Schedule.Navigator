//
//  ToolbarTextField.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/21.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "ToolbarTextField.h"
@implementation ToolbarTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    return CGRectInset(rect, 5, 5);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super editingRectForBounds:bounds];
    return CGRectInset(rect, 5, 5);
}

@end
