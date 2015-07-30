//
//  MainViewController.m
//  SliderDemo2
//
//  Created by user on 15/7/30.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
@interface MainViewController ()
- (IBAction)leftSlider:(id)sender;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];
}


- (IBAction)leftSlider:(id)sender {
    
    AppDelegate *mydelegate = [[UIApplication sharedApplication]delegate];
    
    if (mydelegate.myVC.distance == 0) {
        [mydelegate.myVC showLeft];
        
    } else {
        [mydelegate.myVC showHome];
        
    }
    
    
}
@end
