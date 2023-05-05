//
//  SiteTableViewController.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/18.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "SiteTableViewController.h"

@interface SiteTableViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@end

@implementation SiteTableViewController

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  [self.spinner stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  [self.spinner stopAnimating];
}

#pragma - lifecycle
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor grayColor];
}
// 显示再加载网页
- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self setup];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    // [self setupHttpServer];
    
  });
}
- (void)setup {
  // 创建WKWebView
  UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  // 将WKWebView添加到视图
  [self.view addSubview:webView];
  self.webView = webView;
  self.webView.delegate = self;
  // 设置访问的URL
  NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/s?wd='汇率计算'"];
  // 根据URL创建请求
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  // WKWebView加载请求
  [_webView loadRequest:request];
  UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  [self.view addSubview:loadingView];
  [loadingView startAnimating];
  self.spinner = loadingView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
