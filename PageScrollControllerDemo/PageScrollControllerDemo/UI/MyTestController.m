//
//  MyTestController.m
//  PageScrollControllerDemo
//
//  Created by TJ-iOS on 2017/2/20.
//  Copyright © 2017年 TJ-iOS. All rights reserved.
//

#import "MyTestController.h"

@interface MyTestController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MyTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.titleLabel.text = [NSString stringWithFormat:@"这是%@列表界面", self.title];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
