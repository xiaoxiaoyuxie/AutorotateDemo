//
//  RootViewController.m
//  AutorotateDemo
//
//  Created by 永强 on 2019/5/23.
//  Copyright © 2019 永强. All rights reserved.
//

#import "RootViewController.h"
#import "BaseNaviViewController.h"
#import "RotateViewController.h"
#import "PortraitViewController.h"

#import <objc/runtime.h>

@interface RootViewController ()<UITabBarControllerDelegate>
@property (nonatomic,strong,readonly)NSArray *titleArray;
@property (nonatomic,strong,readonly)NSArray *defaultImageNameArray;
@property (nonatomic,strong,readonly)NSArray *selectImageNameArray;
@property (nonatomic,strong,readonly)NSArray *classNameArray;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    [self setViewControllers:[self getViewcontrollers] animated:YES];
    // Do any additional setup after loading the view.
}

-(NSArray *)getViewcontrollers
{
    // ========== 各按钮 ==========
    _titleArray = @[@"Push旋转",@"Present旋转",@"Push竖直",@"Present竖直"];
    _defaultImageNameArray=@[@"tab_btn_home_default",@"tab_btn_Answer_default",@"tab_btn_1v1_default",@"tab_btn_mine_default"];
    _selectImageNameArray = @[@"tab_btn_home_pressed",@"tab_btn_Answer_pressed",@"tab_btn_1v1_pressed",@"tab_btn_mine_pressed"];
    _classNameArray =@[@"BaseViewController",@"BaseViewController",@"BaseViewController",@"BaseViewController"];
    
    NSMutableArray *naVCArray=[NSMutableArray array];
    NSMutableArray *topVCArray=[NSMutableArray array];
    for (int i=0; i<_classNameArray.count; i++) {
        const char *className = [_classNameArray[i] cStringUsingEncoding:NSASCIIStringEncoding];
        Class newClass = objc_getClass(className);
        UIViewController *controller=[newClass new];
        if (!controller) {
            continue;
        }
#if FUDAOBZ_IM_SUPPORT
        UIButton * button = (UIButton *)[[YXMediator sharedInstance] Mediator_chatAlertView]; //消息模块替换红点视图
        controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
#endif
        [topVCArray addObject:controller];
        controller.hidesBottomBarWhenPushed=NO;
        BaseNaviViewController *navc =[[BaseNaviViewController alloc] initWithRootViewController:controller];
        controller.title=_titleArray[i];
        UITabBarItem *tabbar=[[UITabBarItem alloc] initWithTitle:_titleArray[i] image:[UIImage imageNamed:_defaultImageNameArray[i]] selectedImage:[UIImage imageNamed:_selectImageNameArray[i]]];
        controller.tabBarItem=tabbar;
        [naVCArray addObject:navc];
    }
//    _topViewControllers=topVCArray;
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
    [UITabBar appearance].backgroundColor = [UIColor whiteColor];
    [UITabBar appearance].translucent=NO;
    [UITabBarItem appearance].titlePositionAdjustment = UIOffsetMake(0, -2);
    return naVCArray;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        switch (self.selectedIndex) {
            case 0:
            {
                UINavigationController *navc = self.selectedViewController;
                [navc pushViewController:[RotateViewController new] animated:YES];
            }
                break;
            case 1:
            {
                BaseNaviViewController *navVC = [[BaseNaviViewController alloc] initWithRootViewController:[RotateViewController new]];
                [self.selectedViewController presentViewController:navVC animated:YES completion:^{
                    
                }];
            }
                break;
            case 2:
            {
                UINavigationController *navc = self.selectedViewController;
                [navc pushViewController:[PortraitViewController new] animated:YES];
            }
                break;
            case 3:
            {
                BaseNaviViewController *navVC = [[BaseNaviViewController alloc] initWithRootViewController:[PortraitViewController new]];
                [self.selectedViewController presentViewController:navVC animated:YES completion:^{
                    
                }];
            }
                break;
                
            default:
                break;
        }
    });
}

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

@end
