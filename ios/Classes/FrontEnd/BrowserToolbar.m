//
//  BrowserToolbar.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/21.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "BrowserToolbar.h"
#import "ToolbarTextField.h"
#import "Masonry.h"
@interface BrowserToolbar ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *forwardButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *tabsButton;
@end


@implementation BrowserToolbar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self viewDidInit];
    }
    return self;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self viewDidInit];
  }
  return self;
}

- (void) beginEditing {
  NSLog(@"---------");
  [self arrangeToolbarWithEditing:true];
}
- (void)viewDidInit {
  self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
  self.backButton = [[UIButton alloc] init];
  [self.backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.backButton setTitle:@"<" forState:UIControlStateNormal];
  [self.backButton addTarget:self action:@selector(didClickBack) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.backButton];

  self.forwardButton = [[UIButton alloc] init];
  [self.forwardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.forwardButton setTitle:@">" forState:UIControlStateNormal];
  [self.forwardButton addTarget:self action:@selector(didClickForward) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.forwardButton];

  self.toolbarTextField = [[ToolbarTextField alloc] init];
  self.toolbarTextField.keyboardType = UIKeyboardTypeURL;
  self.toolbarTextField.autocorrectionType = UITextAutocorrectionTypeNo;
  self.toolbarTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.toolbarTextField.returnKeyType = UIReturnKeyGo;
  self.toolbarTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.toolbarTextField.layer.backgroundColor = [UIColor whiteColor].CGColor;
  self.toolbarTextField.layer.cornerRadius = 8;
  [self.toolbarTextField setContentHuggingPriority:0 forAxis:UILayoutConstraintAxisHorizontal];
  self.toolbarTextField.delegate = self;
  self.toolbarTextField.placeholder = @"Please enter site address";
  [self addSubview:self.toolbarTextField];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing) name:UITextFieldTextDidBeginEditingNotification object:self.toolbarTextField];

  self.cancelButton = [[UIButton alloc] init];
  [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
  [self.cancelButton addTarget:self action:@selector(didClickCancel) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.cancelButton];

  _tabsButton = [[UIButton alloc] init];
  
  [_tabsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  // [_tabsButton setBackgroundColor:[UIColor grayColor]];
  _tabsButton.titleLabel.layer.borderColor = [UIColor blackColor].CGColor;
  _tabsButton.titleLabel.layer.cornerRadius = 4;
  _tabsButton.titleLabel.layer.borderWidth = 1;
  _tabsButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
  _tabsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
  [_tabsButton.titleLabel sizeToFit];
  [_tabsButton addTarget:self action:@selector(didClickAddTab) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:_tabsButton];
  [self arrangeToolbarWithEditing:NO];
}

- (void)arrangeToolbarWithEditing:(BOOL)editing {
    [UIView animateWithDuration:0.5 animations:^{
        if (editing) {
          // These two buttons are off screen
          [self.backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.right.equalTo(self.forwardButton.mas_left);
              make.centerY.equalTo(self);
              make.width.height.equalTo(@44);
          }];

          [self.forwardButton  mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.right.equalTo(self.toolbarTextField.mas_left);
              make.centerY.equalTo(self);
              make.width.height.equalTo(@44);
          }];

          [self.toolbarTextField  mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self).offset(8);
              make.centerY.equalTo(self);
          }];

          [self.cancelButton  mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self.toolbarTextField.mas_right).offset(8);
              make.centerY.equalTo(self);
              make.right.equalTo(self).offset(-8);
          }];
          // Tabs button is off the screen.
          [self.tabsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cancelButton.mas_right);
            make.centerY.equalTo(self);
            make.width.height.equalTo(@44);
          }];
        } else {
          [self.backButton  mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self);
              make.centerY.equalTo(self);
              make.width.height.equalTo(@44);
          }];

          [self.forwardButton mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self.backButton.mas_right);
              make.centerY.equalTo(self);
              make.width.height.equalTo(@44);
          }];

          [self.toolbarTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(self.forwardButton.mas_right);
              make.centerY.equalTo(self);
          }];
          self.tabsButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
          [self.tabsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.toolbarTextField.mas_right);
            make.centerY.equalTo(self);
            make.width.height.equalTo(@44);
            make.right.equalTo(self).offset(-8);
          }];
          // The cancel button is off screen
          [self.cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tabsButton.mas_right).offset(8);
          
            make.centerY.equalTo(self);
          }];
        }
    }];
}

- (void)didClickBack {
  if ([self.browserToolbarDelegate respondsToSelector:@selector(didClickBack)])
  {
    [self.browserToolbarDelegate didClickBack];
  }
}

- (void)didClickForward {
  if ([self.browserToolbarDelegate respondsToSelector:@selector(didClickForward)])
  {
    [self.browserToolbarDelegate didClickForward];
  }
}

- (void)didClickCancel {
    // toolbarTextField.text = webView.location TODO Can't do this right now because we can't access the webview
    [self.toolbarTextField resignFirstResponder];
    [self arrangeToolbarWithEditing:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   [self arrangeToolbarWithEditing:false];
    NSString *urlString = self.toolbarTextField.text;
    if (![urlString hasPrefix:@"http://"]) urlString = [NSString stringWithFormat:@"http://%@", urlString];
    // again. We can probably do some smarter things here but I think this is a
    // decent start that at least lets
     NSURL *url = [NSURL URLWithString:urlString];
    if (urlString == nil) {
        NSLog(@"Error parsing URL: %@", urlString);
        return NO;
    }

    // [self.browserToolbarDelegate didEnterURL:url];
    if ([self.browserToolbarDelegate respondsToSelector:@selector(didEnterURL:)]) [self.browserToolbarDelegate didEnterURL:url];
    [textField resignFirstResponder];
    return true;
}


#pragma - mark Action
- (void)updateTabCount:(NSInteger)count
{
  count > 1 ?
    count >= 10 ?
    [_tabsButton setTitle:[NSString stringWithFormat:@" %ld\t", count] forState:UIControlStateNormal]:
    [_tabsButton setTitle:[NSString stringWithFormat:@"%ldtabs", count] forState:UIControlStateNormal]:
  [_tabsButton setTitle:[NSString stringWithFormat:@"%ldtab ", count] forState:UIControlStateNormal];
}

- (void)updateUrlAddress:(NSString *)address
{
  self.toolbarTextField.text = [address hasPrefix:@"about:blank"] ? @"" : address;
}

- (void)didClickAddTab{
  if ([self.browserToolbarDelegate respondsToSelector:@selector(didClickAddTab)])
  {
    [self.browserToolbarDelegate didClickAddTab];
  }
}
@end
