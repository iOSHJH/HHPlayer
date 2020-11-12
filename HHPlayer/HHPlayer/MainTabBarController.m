//
//  MainTabBarController.m
//  AJCamera
//
//  Created by Ansjer on 2020/6/2.
//  Copyright © 2020 Ansjer. All rights reserved.
//

#import "MainTabBarController.h"
#import "ZFViewController.h"
#import "ZFNotAutoPlayViewController.h"
#import "IJKTestViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZFViewController *vc1 = [[ZFViewController alloc] init];
    [self addChildViewController:vc1 title:@"main" imageName:@"home_Tab_vidicon_"];

    ZFNotAutoPlayViewController *vc2 = [[ZFNotAutoPlayViewController alloc] init];
    [self addChildViewController:vc2 title:@"auto" imageName:@"home_Tab_vidicon_"];
    
    IJKTestViewController *vc3 = [[IJKTestViewController alloc] init];
    [self addChildViewController:vc3 title:@"ijk" imageName:@"home_Tab_vidicon_"];
    
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName {
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:[imageName stringByAppendingString:@"nor"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:[imageName stringByAppendingString:@"pre"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    nav.navigationBarHidden = YES;
    [self addChildViewController:nav];
}


@end
