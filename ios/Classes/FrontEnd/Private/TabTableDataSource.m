//
//  TabTableDataSource.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/23.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "TabTableDataSource.h"
#import "Browser.h"
@implementation TabTableDataSource

- (instancetype)initWithTabs:(NSMutableArray *)tabs selectedTab:(Browser *)selectedTab removeCallback:(void (^)(Browser *))removeCallback {
    self = [super init];
    if (self) {
        self.tabs = tabs;
        self.selectedTab = selectedTab;
        self.removeCallback = removeCallback;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tabs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Browser *tab = self.tabs[indexPath.item];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.textLabel.text = tab.title;
    cell.detailTextLabel.text = tab.url;
    cell.selected = (tab == self.selectedTab);
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  Browser *tab = self.tabs[indexPath.item];
  [self.tabs removeObjectAtIndex:indexPath.item];
  [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
  self.removeCallback(tab);
}

@end
