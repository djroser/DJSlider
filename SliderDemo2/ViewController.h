//
//  ViewController.h
//  SliderDemo2
//
//  Created by user on 15/7/30.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height
#import <UIKit/UIKit.h>


@interface ViewController : UIViewController


//左侧窗控制器
@property (nonatomic, strong) UIViewController *leftVC;

@property (nonatomic,strong) UIViewController *mainVC;

//滑动手势控制器
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (assign, nonatomic) CGFloat distance;

- (instancetype)initWithLeftView:(UIViewController *)leftVC andMainView:(UIViewController *)mainVC;

- (void)showLeft;

- (void)showHome;

@end

