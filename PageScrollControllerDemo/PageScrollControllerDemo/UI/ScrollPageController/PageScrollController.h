//
//  PageScrollController.h
//  PageScrollControllerDemo
//
//  Created by TJ-iOS on 2017/2/21.
//  Copyright © 2017年 TJ-iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

//导航栏颜色
#define NavigationBarColor_Red    UIColorFromRGB(0xd12b33)
#define NavigationBarColor_Blue   UIColorFromRGB(0x1984d4)
//颜色rgb - 16进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



typedef enum{
    UnDisplayMode = 0, //不显示
    AboveShowMode, //上面
    UnderShowMode   //下面
}SelectedLineStyle;


@interface PageScrollController : UIViewController

@property(nonatomic,strong) NSArray *viewControllers;          //展示的视图
@property(nonatomic,assign) SelectedLineStyle lineShowMode;    //标题线显示模式
@property(nonatomic,strong) UIColor *selectedColor;            //选择标题颜色
@property(nonatomic,strong) UIColor *headBackColor;            //标题背景颜色
@property(nonatomic,assign) CGFloat lineHeight;                //标题线高度
@property(nonatomic,assign) NSInteger selectedIndex;           //初始化视图的编号

- (void)refreshTitle:(NSString *)title;

//当前显示的控制器视图
-(UIViewController*)getCurrentShowViewController;

@end
