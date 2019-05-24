//
//  BaseNaviViewController.m
//  AutorotateDemo
//
//  Created by 永强 on 2019/5/23.
//  Copyright © 2019 永强. All rights reserved.
//

#import "BaseNaviViewController.h"

@interface BaseNaviViewController ()

@end

@implementation BaseNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotate {
    return self.viewControllers.lastObject.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.viewControllers.lastObject.supportedInterfaceOrientations;
}

@end
