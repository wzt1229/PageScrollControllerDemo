//
//  HomeController2.m
//  PageScrollControllerDemo
//
//  Created by TJ-iOS on 2017/2/21.
//  Copyright © 2017年 TJ-iOS. All rights reserved.
//

#import "HomeController2.h"

@interface HomeController2 ()

@end

@implementation HomeController2

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
