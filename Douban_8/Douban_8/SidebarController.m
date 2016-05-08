//
//  SidebarController.m
//  Douban
//
//  Created by YANG on 16/5/5.
//  Copyright © 2016年 唐家文. All rights reserved.
//

#import "SidebarController.h"
#import "PlayerViewController.h"
#import "ChannelsTableViewController.h"

@interface SidebarController (){
    CDSideBarController *sideBar;//侧滑
    PlayerViewController *playerVC;//音乐播放
    ChannelsTableViewController *channelsVC;//频道播放
    UserInfoViewController *userInfoVC;//用户
    AppDelegate *appDelegate;
}

@end

@implementation SidebarController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication]delegate];
    // Do any additional setup after loading the view from its nib.
    
    //对应侧滑栏上的图片
    NSArray *imageList = @[[UIImage imageNamed:@"menuPlayer"],
                           [UIImage imageNamed:@"menuChannel"],
                           [UIImage imageNamed:@"menuLogin"],
                           [UIImage imageNamed:@"menuClose.png"]];
    
    
    sideBar = [CDSideBarController sharedInstanceWithImages:imageList];//将图片传到侧滑菜单栏上
    sideBar.delegate = self;//设置sideBar的代理为自己（）
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    playerVC = [[PlayerViewController alloc] init];
    
    channelsVC = [[ChannelsTableViewController alloc]init];
    channelsVC.delegate = (id)self;
    
    userInfoVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"userInfoVC"];
    self.viewControllers = @[playerVC, channelsVC, userInfoVC];
}





-(BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBar.hidden = YES;//当页面出现时默认侧滑菜单栏隐藏
    
    for (UIView *child in self.tabBar.subviews)
    {
        if ([child isKindOfClass:[UIControl class]])
        {
            [child removeFromSuperview];
        }
    }
    
    [sideBar insertMenuButtonOnView:self.view atPosition:CGPointMake(self.view.frame.size.width - 50, 30)];
}

#pragma mark - CDSidebar Delegate
//实现CDSidebar Delegate 里面点击按钮的方法
-(void)menuButtonClicked:(int)index{
    self.selectedIndex = index;
    switch (index) {
        case 0:
        case 1:
        case 2:
            self.selectedIndex = index;
            break;
        case 3:
            break;
    }
}

@end
