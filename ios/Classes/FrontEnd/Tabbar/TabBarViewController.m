//
//  TabBarViewController.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/17.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "TabBarViewController.h"
#import "ToolbarItem.h"
#import "ToolbarButton.h"
#import "ToolbarContainerView.h"
#import "TabsViewController.h"
#import "BookmarksViewController.h"
#import "HistoryViewController.h"
#import "SiteTableViewController.h"
#import "SettingsViewController.h"
#import "RCTRootView.h"
#import "AppDelegate.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)buttonTapped:(UIButton *)sender {
  self.selectedButtonIndex = sender.tag;
}

#pragma mark - Lifecycle
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor blackColor];
  [self.navigationController.navigationBar setHidden:true];
  // 初始化 items 数组
  self.items = @[
      [[ToolbarItem alloc] initWithTitle:@"Calcs" imageName:@"bookmarks" viewController:[[TabsViewController alloc] initWithStart:1 end:900]],
//      [[ToolbarItem alloc] initWithTitle:@"About" imageName:@"bookmarks" viewController:[self setupReactNativeUI]],
//      [[ToolbarItem alloc] initWithTitle:@"History" imageName:@"bookmarks" viewController:[[HistoryViewController alloc] init]],
//      [[ToolbarItem alloc] initWithTitle:@"Transfer" imageName:@"bookmarks" viewController:[[SiteTableViewController alloc] init]],
      [[ToolbarItem alloc] initWithTitle:@"About" imageName:@"bookmarks" viewController:[[SettingsViewController alloc] init]]
  ];
    
  // 添加按钮到容器
  CGFloat h = [[UIApplication sharedApplication] statusBarFrame].size.height;
  ToolbarContainerView *containerView = [[ToolbarContainerView alloc] initWithFrame:CGRectMake(0, h, self.view.bounds.size.width, 56)];
  [self.view addSubview:containerView];
  [containerView setTag:1];

  // 创建按钮
  NSMutableArray<ToolbarButton *> *buttons = [NSMutableArray array];
  int buttonIndex = 0;
  for (ToolbarItem *item in self.items) {
    ToolbarButton *button = [[ToolbarButton alloc] initWithToolbarItem:item];
    [containerView addSubview:button];
    // 绑定事件
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [buttons addObject:button];
    [button setTag:buttonIndex++];
  }
  // 响应按钮点击事件
  // __weak typeof(self) weakSelf = self;
  self.buttons = buttons;
  // 初始选择第一个按钮
  self.selectedButtonIndex = 0;
}
- (void)setSelectedButtonIndex:(NSInteger)newButtonIndex {
    if (_selectedButtonIndex != -1) {
        ToolbarButton *currentButton = self.buttons[_selectedButtonIndex];
        currentButton.selected = false;
      // NSLog(@"取消选择 %@", currentButton.titleLabel.text);
    }
    ToolbarButton *newButton = self.buttons[newButtonIndex];
    newButton.selected = true;
    _selectedButtonIndex = newButtonIndex;
    // NSLog(@"选择 %@", newButton.titleLabel.text);
    // 更新活动视图控制器
    UIView *buttonContainerView = [self.view viewWithTag:1];
    if (buttonContainerView) {
      CGFloat statusbarH = [[UIApplication sharedApplication] statusBarFrame].size.height;
      CGRect onScreenFrame = self.view.frame;
      onScreenFrame.size.height -= buttonContainerView.frame.size.height;
      onScreenFrame.origin.y += buttonContainerView.frame.size.height;
      onScreenFrame.origin.y += statusbarH;
      CGRect offScreenFrame = onScreenFrame;
      offScreenFrame.origin.y += offScreenFrame.size.height;
        if (_selectedButtonIndex == -1) {
            UIViewController *visibleViewController = self.items[newButtonIndex].viewController;
            visibleViewController.view.frame = onScreenFrame;
            [self addChildViewController:visibleViewController];
            [self.view addSubview:visibleViewController.view];
            [visibleViewController didMoveToParentViewController:self];
        } else {
            UIViewController *visibleViewController = self.items[_selectedButtonIndex].viewController;
            UIViewController *newViewController = self.items[newButtonIndex].viewController;
            [visibleViewController willMoveToParentViewController:nil];
             newViewController.view.frame = offScreenFrame;
            [self addChildViewController:newViewController];
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];

            [self transitionFromViewController:visibleViewController
                              toViewController:newViewController
                                      duration:0.25
                                       options:UIViewAnimationOptionTransitionNone
                                    animations:^{
                                        visibleViewController.view.frame = offScreenFrame;
                                    }
                                    completion:^(BOOL finished) {
                                        [visibleViewController.view removeFromSuperview];
                                        [self.view addSubview:newViewController.view];
                                        newViewController.view.frame = offScreenFrame;
                                        [UIView animateWithDuration:0.25
                                                         animations:^{
                                                             newViewController.view.frame = onScreenFrame;
                                                         }
                                                         completion:^(BOOL finished) {
                                                             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                                         }];
                                    }];
        }
    }
}

- (UIViewController *)setupReactNativeUI
{
  NSString *path = [[self sandboxFilePath] stringByAppendingPathComponent:@"main.jsbundle"];
  NSURL *jsCodeLocation =  [NSURL fileURLWithPath:path];
  AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"AImageDemo"
                                               initialProperties:nil
                                                   launchOptions:delegate.launchOptions];
  
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  rootViewController.edgesForExtendedLayout = NO;
  rootViewController.title = @"Web Browser";
  return rootViewController;
}
// Sandbox
- (NSString *)sandboxFilePath {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];//Documents目录
  return documentsDirectory;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskPortrait;
}
@end
