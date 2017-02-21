//
//  TJMainTabBarViewController.m
//  webhall
//
//  Created by Apple on 16/9/19.
//  Copyright © 2016年 深圳太极软件有限公司. All rights reserved.
//

#import "TJMainTabBarViewController.h"
#import "HomeController.h"
#import "HomeController2.h"

//导航栏颜色
#define NavigationBarColor_Red    UIColorFromRGB(0xd12b33)
#define NavigationBarColor_Blue   UIColorFromRGB(0x1984d4)
//颜色rgb - 16进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface TJMainTabBarViewController ()<UITabBarControllerDelegate>

@property (strong, nonatomic) UINavigationController *currunNav;

@end

@implementation TJMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initRootViewController];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
//初始化根视图控制器
- (void)initRootViewController{
    
    //测试1
    HomeController *home1 = [HomeController new];
    home1.title = @"Home1";
    
    //测试2
    HomeController2 *home2 = [HomeController2 new];
    home2.title = @"Home2";
    
    NSArray *viewControllers = @[home1, home2];
    //正常图片
    NSArray *normalImgs = @[@"foot_gov",@"foot_msg"];
    
    //选中图片
    NSArray *selectedImgs = @[@"foot_gov_hover", @"foot_msg_hover"];
    
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:viewControllers.count];
    for (int i = 0; i < viewControllers.count;i++) {
        UIViewController *vc = viewControllers[i];
        vc.tabBarItem.image = [[UIImage imageNamed:normalImgs[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImgs[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NavigationBarColor_Red} forState:UIControlStateSelected];

        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [newArray addObject:nav];
    }

    self.viewControllers = newArray;
    self.delegate = self;
    _currunNav = self.viewControllers[0];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

    UINavigationController *nav = (UINavigationController*)viewController;
    _currunNav = nav;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
