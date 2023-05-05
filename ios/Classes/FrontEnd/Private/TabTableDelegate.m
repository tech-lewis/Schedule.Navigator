//
//  TabTableDelegate.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/23.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "TabTableDelegate.h"
#import "Browser.h"
@interface TabTableDelegate ()

@end

@implementation TabTableDelegate

- (instancetype)initWithTabs:(NSArray *)tabs selectCallback:(void (^)(Browser *))selectCallback {
    self = [super init];
    if (self) {
        self.tabs = tabs;
        self.selectCallback = selectCallback;
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Browser *tab = self.tabs[indexPath.item];
    self.selectCallback(tab);
}

@end
