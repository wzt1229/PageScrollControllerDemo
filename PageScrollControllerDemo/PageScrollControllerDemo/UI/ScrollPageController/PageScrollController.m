//
//  PageScrollController.m
//  PageScrollControllerDemo
//
//  Created by TJ-iOS on 2017/2/21.
//  Copyright © 2017年 TJ-iOS. All rights reserved.
//

#import "PageScrollController.h"

#define  DEVICE_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define  DEVICE_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define  HEAD_HEIGHT 45.0
#define  MRRed 209.0
#define  MRGreen 43.0
#define  MRBlue 51.0
#define  TITILE_FONT 15

@interface PageScrollController ()<UIScrollViewDelegate>
{
    UIViewController *currentBaseController;
}
@property (assign, nonatomic) CGFloat titleWidth;
@property (strong, nonatomic) UIScrollView *contentScrView;
@property (strong, nonatomic) UIScrollView *headScrView;
@property (strong, nonatomic) UIButton *curruntBtn;

@end

@implementation PageScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_viewControllers.count<=5) {
        _titleWidth = DEVICE_WIDTH/_viewControllers.count;
    }else{
        _titleWidth = DEVICE_WIDTH/5;
    }
    
    if (!_lineHeight) {
        _lineHeight = 2;
    }
    if (!_selectedColor) {
        _selectedColor = [UIColor redColor];
    }
    if (!_headBackColor) {
        _headBackColor = [UIColor whiteColor];
    }
    
    if (_selectedIndex>_viewControllers.count-1) {
        _selectedIndex = 0;
    }
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)initUI{
    
    CGFloat W = self.view.frame.size.width;
    CGFloat H = self.view.frame.size.height;
    
    //头部标题
    UIScrollView *headScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, W, HEAD_HEIGHT)];
    headScrView.backgroundColor = _headBackColor;
    for (int i = 0; i <_viewControllers.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(_titleWidth*i, 0, _titleWidth, HEAD_HEIGHT)];
        btn.tag = i;
        [btn addTarget:self action:@selector(switchViewControllers:) forControlEvents:UIControlEventTouchUpInside];
        UIViewController *vc = _viewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:TITILE_FONT];
        if (i==_selectedIndex) {
            _curruntBtn = btn;
            [self setButScale:_curruntBtn withScale:1];
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        [headScrView addSubview:btn];
        
    }
    //添加底部线条
    if (_lineShowMode!=UnDisplayMode) {
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, HEAD_HEIGHT-_lineHeight/2, W, _lineHeight/2)];
        bottom.backgroundColor = [UIColor lightGrayColor];
        [headScrView addSubview:bottom];
        UIView *line = [UIView new];
        line.tag = 891101;
        line.backgroundColor = _selectedColor;
        if (_lineShowMode == AboveShowMode) {
            line.frame = CGRectMake(0, 0, _titleWidth, _lineHeight);
        }else{
            line.frame = CGRectMake(0, HEAD_HEIGHT-_lineHeight, _titleWidth, _lineHeight);
            
        }
        [headScrView addSubview:line];
    }
    
    self.headScrView = headScrView;
    [self.view addSubview:headScrView];
    //内容
    UIScrollView *pageScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HEAD_HEIGHT, W , H-HEAD_HEIGHT-64)];
    pageScrView.contentSize = CGSizeMake(W*_viewControllers.count, pageScrView.frame.size.height);
    pageScrView.pagingEnabled = YES;
    pageScrView.showsHorizontalScrollIndicator = NO;
    pageScrView.directionalLockEnabled = YES;
    
    pageScrView.delegate = self;
    self.contentScrView = pageScrView;
    [self.view addSubview:pageScrView];
    
    for (UIViewController *vc in _viewControllers) {
        [self addChildViewController:vc];
    }
    
    // 定位到指定位置
    CGPoint offset = self.contentScrView.contentOffset;
    
    offset.x = _selectedIndex * DEVICE_WIDTH;
    [self.contentScrView setContentOffset:offset animated:NO];
    
    [self scrollViewDidEndScrollingAnimation: self.contentScrView];
    
}

#pragma mark - <UIScrollViewDelegate>

/**
 *  当scrollView进行动画结束的时候会调用这个方法, 例如调用[self.contentScrollView setContentOffset:offset animated:YES];方法的时候
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger index = offsetX / width;
    
    _curruntBtn = self.headScrView.subviews[index];
    
    UIViewController *willShowVc = self.childViewControllers[index];
    
    currentBaseController = (UIViewController*)willShowVc;
    
    if([willShowVc isViewLoaded]) return;
    
    willShowVc.view.frame = CGRectMake(index * width, 0, width, height);
    
    [scrollView addSubview:willShowVc.view];
    
}

/**
 *  当手指抬起停止减速的时候会调用这个方法
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/**
 *  scrollView滚动时调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (scale<0||scale>_viewControllers.count-1) {
        return;
    }
    // 获取需要操作的的左边的button
    NSInteger leftIndex = scale;
    UIButton *leftBtn = self.headScrView.subviews[leftIndex];
    
    // 获取需要操作的右边的button
    NSInteger rightIndex = scale+1;
    UIButton *rightBtn = (rightIndex == _viewControllers.count) ?  nil : self.headScrView.subviews[rightIndex];
    
    
    // 右边的比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1- rightScale;
    
    // 设置比例
    [self setButScale:leftBtn withScale:leftScale];
    [self setButScale:rightBtn withScale:rightScale];
    
    if (_lineShowMode!=UnDisplayMode) {
        
        UIView *line = (UIView *)[self.headScrView viewWithTag:891101];
        line.center = CGPointMake(_titleWidth*scale+_titleWidth/2, line.center.y);
    }
}
- (void)switchViewControllers:(UIButton *)btn{
    if (btn==_curruntBtn) {
        return;
    }
    _curruntBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    [_curruntBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _curruntBtn = btn;;
    
    // 定位到指定位置
    CGPoint offset = self.contentScrView.contentOffset;
    
    offset.x = btn.tag * DEVICE_WIDTH;
    [self.contentScrView setContentOffset:offset animated:NO];
    
    // 取出需要显示的控制器
    UIViewController *willShowVc = self.childViewControllers[btn.tag];
    currentBaseController = (UIViewController*)willShowVc;
    if([willShowVc isViewLoaded]) return;
    willShowVc.view.frame = CGRectMake(btn.tag * DEVICE_WIDTH, 0, DEVICE_WIDTH, self.contentScrView.frame.size.height);
    [self.contentScrView addSubview:willShowVc.view];
}

- (void)setButScale:(UIButton *)btn withScale:(CGFloat)scale {
    
    // 颜色渐变
    CGFloat red = scale*MRRed;
    CGFloat green = MRGreen*scale;
    CGFloat blue = MRBlue*scale;
    
    [btn setTitleColor:[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    // 大小缩放比例
    CGFloat transformScale = 1 + (scale * 0.1);
    btn.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}

- (void)refreshTitle:(NSString *)title{
    UIButton *btn = (UIButton *)[self.headScrView viewWithTag:_viewControllers.count-1];
    
    [btn setTitle:title forState:UIControlStateNormal];
}

//当前显示的控制器视图
-(UIViewController*)getCurrentShowViewController
{
    return currentBaseController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
