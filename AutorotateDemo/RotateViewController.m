//
//  ViewController.m
//  AutorotateDemo
//
//  Created by 永强 on 2019/5/23.
//  Copyright © 2019 永强. All rights reserved.
//

#import "RotateViewController.h"

@interface RotateViewController ()

@end

@implementation RotateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    UITextField *fiels = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    fiels.backgroundColor = [UIColor redColor];
    [self.view addSubview:fiels];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    button.frame = CGRectMake(200, 100, 100, 30);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(closePage) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)closePage
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
