# Schedule.Navigator
Classy way web browsing

我知道这是一篇较旧的帖子，但对于Xcode 8，iOS 9.3（iPad 2 / iPad Mini），React Native 0.24.1，我在RCTScrollView.m中进行了此修改作为修复。

@implementation RCTCustomScrollView
{
  __weak UIView *_dockedHeaderView;

 // Added the following line
 RCTRefreshControl *_refreshControl;
}
// Also added this
@synthesize refreshControl = _refreshControl;