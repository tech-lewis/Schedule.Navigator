//
//  SettingsViewController.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/18.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "SettingsViewController.h"
#import "RCTRootView.h"
#import "AppDelegate.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor lightGrayColor];
 [self setupUI];
}

- (void)setupUI
{
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
  imageView.center = self.view.center;
  imageView.image = [UIImage imageNamed:@"AppIcon"];
  [self.view addSubview:imageView];
  
  UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(imageView.frame)-50, [UIScreen mainScreen].bounds.size.width, 50)];
  [self.view addSubview:versionLabel];
  versionLabel.textAlignment = NSTextAlignmentCenter;
  NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
  NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
  versionLabel.text = app_Version;
}
@end
