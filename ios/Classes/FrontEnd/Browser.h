//
//  Browser.h
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/21.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Browser : NSObject
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign, readonly) BOOL canGoBack;
@property (nonatomic, assign, readonly) BOOL canGoForward;

// JS获取当前浏览器地址
- (NSString *)url;
- (NSString *)title;
- (UIWebView *)view;
- (void)goBack;
- (void)goForward;
- (void)loadRequest:(NSURLRequest *)urlRequest;
- (void)loadRequestWithUrlString:(NSString *)url;
- (void)loadRequestWithURL:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
