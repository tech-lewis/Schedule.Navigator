//
//  TabManager.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/23.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "TabManager.h"

@implementation TabManager {
    NSMutableArray<Browser *> *_tabs;
    NSInteger _selectedIndex;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _tabs = [NSMutableArray new];
        _selectedIndex = -1;
    }
    return self;
}

- (NSInteger)count {
    return _tabs.count;
}

- (Browser *)selectedTab {
    if (_selectedIndex < 0 || _selectedIndex >= _tabs.count) {
        return nil;
    }
    return _tabs[_selectedIndex];
}

- (NSArray<Browser *> *)tabs {
    return [_tabs copy];
}

- (Browser *)getTabAtIndex:(NSInteger)index {
    return _tabs[index];
}

- (void)selectTab:(Browser *)tab {
    if (self.selectedTab == tab) {
        return;
    }

    Browser *previous = self.selectedTab;

    _selectedIndex = -1;
    for (NSInteger i = 0; i < _tabs.count; ++i) {
        if (_tabs[i] == tab) {
            _selectedIndex = i;
            break;
        }
    }

    NSAssert(self.selectedTab == tab, @"Expected tab is selected");

    if ([(NSObject *)self.delegate respondsToSelector:@selector(didSelectedTabChangeWithSelected:previous:)]) {
        [_delegate didSelectedTabChangeWithSelected:tab previous:previous];
    }
}

- (Browser *)addTab {
    Browser *tab = [Browser new];
    [_tabs addObject:tab];
    if ([(NSObject *)_delegate respondsToSelector:@selector(didAddTabWithTab:)]) {
        [_delegate didAddTabWithTab:tab];
    }
    [self selectTab:tab];
    return tab;
}

- (void)removeTab:(Browser *)tab {
    NSInteger index = [self getIndex:tab];
    NSInteger prevCount = _tabs.count;
    for (NSInteger i = 0; i < _tabs.count; ++i) {
        if (_tabs[i] == tab) {
            [_tabs removeObjectAtIndex:i];
            break;
        }
    }
    NSAssert(_tabs.count == prevCount - 1, @"Tab removed");

    if (index < _tabs.count) {
        [self selectTab:_tabs[index]];
    } else if (index - 1 >= 0) {
        [self selectTab:_tabs[index - 1]];
    } else {
        NSAssert(_tabs.count == 0, @"Removed last tab");
        [self selectTab:nil];
    }

    if ([(NSObject *)_delegate respondsToSelector:@selector(didRemoveTabWithTab:)]) {
        [_delegate didRemoveTabWithTab:tab];
    }
}

- (NSInteger)getIndex:(Browser *)tab {
    for (NSInteger i = 0; i < _tabs.count; ++i) {
        if (_tabs[i] == tab) {
            return i;
        }
    }
    NSAssert(false, @"Tab not in tabs list");
    return -1;
}

@end
