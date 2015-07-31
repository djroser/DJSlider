//
//  ViewController.m
//  SliderDemo2
//
//  Created by user on 15/7/30.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (assign, nonatomic) CGFloat FullDistance;
@property (assign, nonatomic) CGFloat Proportion;
@property (assign, nonatomic) CGPoint centerOfLeftViewAtBeginning;
@property (assign, nonatomic) CGFloat proportionOfLeftView;
@property (assign, nonatomic) CGFloat distanceOfLeftView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftbackiamge"]];
    bgImage.frame = self.view.bounds;
    bgImage.alpha = 0.9;

    [self.view addSubview:bgImage];
    
}

- (instancetype)initWithLeftView:(UIViewController *)leftVC andMainView:(UIViewController *)mainVC
{
    if (self = [super init]) {
        
        leftVC.view.center = CGPointMake(leftVC.view.center.x - 50, leftVC.view.center.y);
        leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
        self.centerOfLeftViewAtBeginning = leftVC.view.center;
        
        self.leftVC = leftVC;
        self.mainVC = mainVC;
        
        self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSigleTap:)];
        
        [singleTap setNumberOfTapsRequired:1];
        singleTap.delegate = self;
        self.pan.delegate = self;
        
        [self.mainVC.view addGestureRecognizer:self.pan];
        [self.mainVC.view addGestureRecognizer:singleTap];
        
        [self.view addSubview:self.leftVC.view];
        
        //UIView *view = [[UIView alloc]init];
//        view.frame = self.leftVC.view.bounds;
//        view.backgroundColor = [UIColor blackColor];
//        view.alpha = 0.5;
//        [self.leftVC.view addSubview:view];
        
        [self.view addSubview:self.mainVC.view];
        
        self.FullDistance = 0.78;
        self.Proportion = 0.77;
        self.proportionOfLeftView = 1;
        self.distanceOfLeftView = 50;
        
    }
    return self;
}


- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGFloat x = [recognizer translationInView:self.view].x;
    
    CGFloat tureDistance = self.distance + x;
    CGFloat tureProportion = tureDistance / (kScreenWidth * self.FullDistance);
    
    if (tureDistance >= 0) {
        
        CGFloat proportion = recognizer.view.frame.origin.x >= 0 ? -1 : 1;
        proportion *= (tureDistance / kScreenWidth);
        proportion *= 1 - self.Proportion;
        proportion /= 0.6;
        proportion += 1;
        
            if (proportion <= self.Proportion) {
                // 若比例已经达到最小，则不再继续动画
                return;
            }
        
        recognizer.view.center = CGPointMake(self.view.center.x + tureDistance, self.view.center.y);
        recognizer.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        
        CGFloat pro = 0.8 + (self.proportionOfLeftView - 0.8) * tureProportion;
        
        self.leftVC.view.center = CGPointMake(self.centerOfLeftViewAtBeginning.x + self.distanceOfLeftView * tureProportion, self.centerOfLeftViewAtBeginning.y - (self.proportionOfLeftView - 1) * self.leftVC.view.frame.size.height * tureProportion / 2);
        self.leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, pro, pro);

    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (tureDistance >= kScreenWidth * (self.Proportion / 2)) {
            [self showLeft];
        } else if (tureDistance < kScreenWidth * (self.Proportion / 2)) {
            [self showHome];
        }
        
    }
    
    
    
    
}


- (void)handleSigleTap:(UITapGestureRecognizer *)recognizer
{
    [self showHome];
}


- (void)showLeft
{
    self.distance = self.view.center.x * (self.FullDistance + self.Proportion / 2);
    [self doTheAnimate:self.Proportion type:@"left"];
}


- (void)showHome
{
    self.distance = 0;
    [self doTheAnimate:1 type:@"home"];
}


- (void)doTheAnimate:(CGFloat)proportion type:(NSString *)type
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        
        self.mainVC.view.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y);
        self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        
        if ([type isEqualToString:@"left"]) {
            NSLog(@"equal");
            self.leftVC.view.center = CGPointMake(self.centerOfLeftViewAtBeginning.x + self.distanceOfLeftView, self.leftVC.view.center.y);
            self.leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.proportionOfLeftView, self.proportionOfLeftView);
        }
        
    } completion:^(BOOL finished) {
        
    }];
}




@end
