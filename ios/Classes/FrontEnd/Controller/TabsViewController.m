//
//  TabsViewController.m
//  AImageDemo
//
//  Created by Mark Lewis on 2023/4/18.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "TabsViewController.h"
#define TabsViewControllerCellID @"WebCell"
@interface TabsViewController ()

@end

@implementation TabsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
}
- (instancetype)initWithStart:(int)first end:(int)last {
  if ([super init]) {
    // 设置变量并告诉他变了 view
    self.first = first;
    self.last = last;
  }
  return self;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Developing" message:@"Hello, World!" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
  [alert show];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  NSString *title = [NSString stringWithFormat:@"%ld bit", sizeof(section)];
  return title;
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return _last - _first;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TabsViewControllerCellID
  ];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TabsViewControllerCellID];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
  }
  /// NSString *test = printBinary(indexPath.row);
  cell.textLabel.text = [NSString stringWithFormat:@"%ld --> Decimal System", indexPath.section+self.first+1];
  cell.detailTextLabel.text = (indexPath.section+self.first+1 <= pow(2, 31)) ? [NSString stringWithFormat:@"Binary:%@", [self printBinary:indexPath.section+self.first+1]] : @"I'm overflow >_<!";
  cell.imageView.image = [UIImage imageNamed:@"nav-bookmarks-on"];
  return cell;
}

// 返回二进制格式的算法，封装为函数
- (NSString *)printBinary:(NSUInteger)n
{
    // int temp = sizeof(int)<<3 - 1;
    int temp = 31;
    NSString *result = @"";
    while (temp >= 0)
    {
        int value = n >> temp & 1;
        result = [NSString stringWithFormat:@"%@%d", result, value];
        
        temp--;
        
//        if ((temp + 1) % 4 == 0)
//        {
//            result = [NSString stringWithFormat:@"%@ ", result];
//        }
    }
    // result = [NSString stringWithFormat:@"%@\n", result];
    
    
    return result;
}
@end
