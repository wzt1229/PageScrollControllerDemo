//
//  HomeController.m
//  PageScrollControllerDemo
//
//  Created by TJ-iOS on 2017/2/20.
//  Copyright © 2017年 TJ-iOS. All rights reserved.
//

#import "HomeController.h"
#import "PageScrollController.h"
#import "MyTestController.h"

@interface HomeController ()

@property (strong,nonatomic) PageScrollController *pageVC;

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    //初始化子控制视图
    [self initRootVC];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)initRootVC{
    
    PageScrollController *root = [PageScrollController new];
    self.pageVC = root;
    MyTestController *news = [MyTestController new];
    news.title = @"新闻动态";
    
    MyTestController *talentPolicy = [MyTestController new];
    talentPolicy.title = @"人才政策";
    
    root.viewControllers = [NSArray arrayWithObjects:news,talentPolicy, nil];
    root.selectedColor = NavigationBarColor_Red;
    root.lineShowMode = UnderShowMode;
    
    root.view.frame = CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-64);
    [self.view addSubview:root.view];
    [self addChildViewController:root];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
