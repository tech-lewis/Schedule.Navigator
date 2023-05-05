//
//  TabTrayController.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/23.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "TabTrayController.h"
#import "TabManager.h"
#import "TabTableDelegate.h"
#import "TabTableDataSource.h"
#import "Masonry.h"
#define StatusBarHeight 20
@interface TabTrayController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TabTableDataSource *tabDataSource;
@property (nonatomic, strong) TabTableDelegate *tabDelegate;
@property (nonatomic, strong) UITableView *tabTableView;
@property (nonatomic, strong) UIToolbar *toolbar;
@end

@implementation TabTrayController

- (instancetype)initWithTabManager:(TabManager *)tabManager {
    self = [super init];
    if (self) {
        self.tabManager = tabManager;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.toolbar = [[UIToolbar alloc] init];
    [self.view addSubview:self.toolbar];

    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didClickDone)];
    UIBarButtonItem *addTabItem = [[UIBarButtonItem alloc] initWithTitle:@"Add tab" style:UIBarButtonItemStylePlain target:self action:@selector(didClickAddTab)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.toolbar.items = @[doneItem, spacer, addTabItem];

    self.tabTableView = [[UITableView alloc] init];
    if (self.tabManager && self.tabManager.tabs) {
        NSArray *tabs = self.tabManager.tabs;
        self.tabDataSource = [[TabTableDataSource alloc] initWithTabs:[tabs mutableCopy] selectedTab:[self.tabManager selectedTab] removeCallback:^(Browser *tab) {
            [self.tabManager removeTab:tab];
            self.tabDataSource.selectedTab = self.tabManager.selectedTab;
        }];
        self.tabDelegate = [[TabTableDelegate alloc] initWithTabs:tabs selectCallback:^(Browser *tab) {
            [self.tabManager selectTab:tab];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
//        self.tabTableView.dataSource = self.tabDataSource;
//        self.tabTableView.delegate = self.tabDelegate;
    }
    [self.view addSubview:self.tabTableView];

    [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(StatusBarHeight);
        make.left.right.equalTo(self.view);
    }];

    [self.tabTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toolbar.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)didClickDone {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didClickAddTab {
    [self.tabManager addTab];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Browser *tab = self.tabDataSource.tabs[indexPath.item];
    self.tabDelegate.selectCallback(tab);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tabDataSource.tabs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Browser *tab = self.tabDataSource.tabs[indexPath.item];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.textLabel.text = tab.title;
    cell.detailTextLabel.text = tab.url;
    cell.selected = (tab == self.tabDataSource.selectedTab);
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  Browser *tab = self.tabDataSource.tabs[indexPath.item];
  [self.tabDataSource.tabs removeObjectAtIndex:indexPath.item];
  [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
  self.tabDataSource.removeCallback(tab);
}
@end
#pragma mark - Private Classes
