//
//  ViewController.m
//  ijkPlayer自定义
//
//  Created by wangyue on 16/10/21.
//  Copyright © 2016年 www.hopechina.cc 中和黄埔. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"
#import "IJKMoviePlayerViewController.h"

#import "IJKMoviePlayerVC.h"
#import "ZFNormalViewController.h"




#define TopMargin 20

#define MinPlayerHeight (kDWidth / 16 * 9)
@interface ViewController ()

@property (nonatomic, strong)UIView             *headerView;

@property (nonatomic, strong) IJKMoviePlayerVC *playerVC;

@property (nonatomic, strong) ZFNormalViewController *normalViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
/*
    ijk支持265编码
    编译好的 IJKMediaFramework：https://gitee.com/renzifeng/IJKMediaFramework
 */


- (IBAction)action1:(id)sender {
    // 可以遵循ZFPlayerMediaControl协议，可以自定义播放器和控件视图：https://github.com/bilibili/ijkplayer
    //NSURL *url = [NSURL URLWithString:@"http://vjs.zencdn.net/v/oceans.mp4"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"265" withExtension:@"mp4"];
    [IJKVideoViewController presentFromViewController:self withTitle:@"测试265" URL:url completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

- (IBAction)action2:(id)sender {
    // 基于ijk
    //NSURL *url = [[NSBundle mainBundle] URLForResource:@"265" withExtension:@"mp4"];
    IJKMoviePlayerVC *vc = [[IJKMoviePlayerVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)action3:(id)sender {
    // https://github.com/renzifeng/ZFPlayer
    self.normalViewController = [[ZFNormalViewController alloc] init];
    [self.navigationController pushViewController:self.normalViewController animated:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
     
}


@end
