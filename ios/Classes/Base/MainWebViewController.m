//
//  MainTableViewController.m
//  Calculator_NET
//
//  Created by Mark Lewis on 16-3-10.
//  Copyright (c) 2016年 Mark Lewis. All rights reserved.
//

#import "MainWebViewController.h"
#import "RCTRootView.h"
#import "AppDelegate.h"
#import "Masonry.h"
#import "Browser.h"
#import "BrowserToolbar.h"
#import "TabManager.h"
#import "TabTrayController.h"
#import "ToolbarTextField.h"
#define kSreenH [UIScreen mainScreen].bounds.size.height
#define kSreenW [UIScreen mainScreen].bounds.size.width
@interface MainWebViewController ()<UIAlertViewDelegate, UIWebViewDelegate, UIScrollViewDelegate, BrowserToolbarDelegate, TabManagerDelegate>
@property (nonatomic, strong) TabManager *manager;
@property (nonatomic, strong) BrowserToolbar *toolbar;
@property (nonatomic, assign) CGFloat lastOffSetY;
@end

@implementation MainWebViewController
#pragma mark - Lifecycle
- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupWebUI];
  [self loadWebContent];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
  [self openReactNativeUI];
}


- (void)didClickAddTab
{
  TabTrayController *controller = [TabTrayController new];
  controller.tabManager = self.manager;
  [self presentViewController:controller animated:true completion:NULL];
}

- (void)didRemoveTabWithTab:(Browser *)tab
{
  [self.toolbar updateTabCount:_manager.count];
  // 移除view
  [tab.view removeFromSuperview];
}

-(void)didAddTabWithTab:(Browser *)tab
{
  [self.toolbar updateTabCount:_manager.count];
  [tab.view setHidden:true];
  [tab.view.scrollView setDelegate:self];
  
  [self.toolbar.toolbarTextField becomeFirstResponder];
  [self.view addSubview:tab.view];
  [tab.view mas_makeConstraints:^(MASConstraintMaker *make) {
  }];
  tab.view.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + 64, kSreenW, kSreenH-64-[UIApplication sharedApplication].statusBarFrame.size.height); // 去掉顶部的bar
  [tab loadRequestWithUrlString:@"http//www.baidu.com"];
}

- (void)didSelectedTabChangeWithSelected:(Browser *)selected previous:(Browser *)previous
{
  [previous.view setHidden:true];
  [selected.view setHidden:false];
  [self.toolbar updateUrlAddress:selected.url];
}


- (void)didClickBack
{
  if (self.manager.selectedTab) [self.manager.selectedTab goBack];
}

- (void)didClickForward
{
  [self.manager.selectedTab goForward];
}

- (void)didEnterURL:(NSURL *)url
{
  [self.manager.selectedTab loadRequestWithURL:url];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
// ScrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  if (scrollView.contentOffset.y - self.lastOffSetY > 0)
  {
    // [self.toolbar.toolbarTextField resignFirstResponder];
  }
  else {
    // NSLog(@"正在向下滑动");
    [UIView animateWithDuration:0.25 animations:^{
      // self.toolbar.hidden = false;
      // self.browser.view.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + 64, kSreenW, kSreenH-64-[UIApplication sharedApplication].statusBarFrame.size.height);
    }];
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  if (scrollView.contentOffset.y - self.lastOffSetY > 0)
  {
    // NSLog(@"正在向上滑动");
    // self.toolbar.hidden = true;
    
    // self.browser.view.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, kSreenW, kSreenH-[UIApplication sharedApplication].statusBarFrame.size.height);
  }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  NSLog(@"%d", self.toolbar.toolbarTextField.isFirstResponder);
  // if ([self.toolbar.toolbarTextField isFocused]) [self.toolbar.toolbarTextField resignFirstResponder];
  // NSLog(@"%f", scrollView.contentOffset.y);
  self.lastOffSetY = scrollView.contentOffset.y;
}
- (void)setupWebUI
{
  [self.navigationController.navigationBar setHidden:true];
  BrowserToolbar *toolbar = [[BrowserToolbar alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, kSreenW, 64)];
  toolbar.browserToolbarDelegate = self;
  self.toolbar = toolbar;
  [self.view addSubview:toolbar];
}

- (void)loadWebContent
{
  self.manager = [[TabManager alloc] init];
  self.manager.delegate = self;
  [[self.manager addTab] loadRequestWithUrlString:@"http://www.baidu.com"];
}
// Sandbox
- (NSString *)sandboxFilePath {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];//Documents目录
  return documentsDirectory;
}
- (void)openReactNativeUI {
  AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
  NSURL *jsCodeLocation;

  /**
   * Loading JavaScript code - uncomment the one you want.
   *
   * OPTION 1
   * Load from development server. Start the server from the repository root:
   *
   * $ npm start
   *
   * To run on device, change `localhost` to the IP address of your computer
   * (you can get this by typing `ifconfig` into the terminal and selecting the
   * `inet` value under `en0:`) and make sure your computer and iOS device are
   * on the same Wi-Fi network.
   */

//  jsCodeLocation = [NSURL URLWithString:@"http://192.168.0.103:8081/index.ios.bundle?platform=ios&dev=true"];

  /**
   * OPTION 2
   * Load from pre-bundled file on disk. The static bundle is automatically
   * generated by the "Bundle React Native code and images" build step when
   * running the project on an actual device or running the project on the
   * simulator in the "Release" build configuration.
   */
  NSString *path = [[self sandboxFilePath] stringByAppendingPathComponent:@"main.jsbundle"];
   path = [[NSBundle mainBundle] pathForResource:@"main.jsbundle" ofType:nil];
  NSFileManager *fileMgr = [NSFileManager defaultManager];
  if(![fileMgr fileExistsAtPath:path]) return;
  jsCodeLocation = [NSURL fileURLWithPath:path];
  // jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  // jsCodeLocation = [NSURL URLWithString:@"http://192.168.0.103:8081/index.ios.bundle?platform=ios&dev=true"];
  
  NSArray *imageList = @[@"http://foo.com/bar1.png",
                  @"http://foo.com/bar2.png"];
   
  NSDictionary *props = @{@"images" : imageList};
  
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"AImageDemo"
                                               initialProperties:props
                                                   launchOptions:delegate.launchOptions];
  
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  rootViewController.edgesForExtendedLayout = NO;
  rootViewController.title = @"Games";
  [self.navigationController pushViewController:rootViewController animated:true];
}
@end
