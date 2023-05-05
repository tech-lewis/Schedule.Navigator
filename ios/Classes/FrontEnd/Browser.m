//
//  Browser.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/21.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "Browser.h"
#import <objc/message.h>
@interface Browser()
id setBeingRemoved(id self, SEL selector, ...);
id willBeRemoved(id self, SEL selector, ...);
@end

@implementation Browser


id setBeingRemoved(id self, SEL selector, ...)
{
  return nil;
}

id willBeRemoved(id self, SEL selector, ...)
{
  return nil;
}
// 防止WebView崩溃的方法
- (void)webViewAddMethods{
  
  //预防报错:WebActionDisablingCALayerDelegate    willBeRemoved
  Class class = NSClassFromString(@"WebActionDisablingCALayerDelegate");
  class_addMethod(class, NSSelectorFromString(@"setBeingRemoved"), setBeingRemoved, "v@:");
  class_addMethod(class, NSSelectorFromString(@"willBeRemoved"), willBeRemoved, "v@:");
  
  class_addMethod(class, NSSelectorFromString(@"removeFromSuperview"), willBeRemoved, "v@:");
}

- (UIWebView *)view
{
  return self.webView;
}

- (NSString *)title
{
  return [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (NSString *)url
{
  return [self.webView stringByEvaluatingJavaScriptFromString:@"window.location.href"];
}


- (UIWebView *)webView
{
  if (_webView == nil) {
    _webView = [[UIWebView alloc] init];
    [self webViewAddMethods];
  }
  // webView.allowsBackForwardNavigationGestures = true
  return _webView;
}

- (void)loadRequest:(NSURLRequest *)urlRequest
{
  [self.webView loadRequest:urlRequest];
}

- (void)loadRequestWithURL:(NSURL *)url
{
  [self loadRequest:[NSURLRequest requestWithURL:url]];
}
- (void)loadRequestWithUrlString:(NSString *)url
{
  [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}
- (void)goBack
{
  [self.webView goBack];
}

- (void)goForward
{
  [self.webView goForward];
}

- (BOOL)canGoBack
{
  return [self.webView canGoBack];
}

- (BOOL)canGoForward
{
  return [self.webView canGoForward];
}

@end
