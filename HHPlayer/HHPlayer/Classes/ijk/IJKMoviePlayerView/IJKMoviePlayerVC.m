//
//  IJKMoviePlayerVC.m
//  ZSIJKPlayer_Demo
//
//  Created by Ansjer on 2020/9/28.
//  Copyright © 2020 ichange. All rights reserved.
//

#import "IJKMoviePlayerVC.h"
#import "AppDelegate.h"

#import "IJKMoviePlayerView.h"

@interface IJKMoviePlayerVC ()
//<IJKMoviePlayerViewDelegate>

@property (nonatomic, strong) IJKMoviePlayerView *playerView;

@end

@implementation IJKMoviePlayerVC

- (void)dealloc {
    NSLog(@"我上天了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    
    UIButton *lastButton = [[UIButton alloc] init];
    [lastButton setTitle:@"last" forState:(UIControlStateNormal)];
    [lastButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [lastButton addTarget:self action:@selector(lastAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:lastButton];
    [lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.centerX.equalTo(@-60);
    }];
    
    UIButton *nextButton = [[UIButton alloc] init];
    [nextButton setTitle:@"next" forState:(UIControlStateNormal)];
    [nextButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.centerX.equalTo(@60);
    }];
    
    [self lastAction];
}

- (void)lastAction {
    [self.playerView viewDidDisappear];
    [self.playerView removeFromSuperview];
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"265" withExtension:@"mp4"];
    NSURL *url = [NSURL URLWithString:@"http://47.115.134.251/m3u8/265.m3u8"];
    
    IJKMoviePlayerView *playerView = [[IJKMoviePlayerView alloc] initWithURL:url title:@"视频标题"];
    self.playerView = playerView;
    //playerView.delegate = self;
    [self.view addSubview:playerView];
    [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@88);
        make.height.equalTo(@(self.view.bounds.size.width * 9 /16));
    }];
}

- (void)nextAction {
    [self.playerView viewDidDisappear];
    [self.playerView removeFromSuperview];
    
    
    NSURL *url = [NSURL URLWithString:@"http://vjs.zencdn.net/v/oceans.mp4"];
    
    IJKMoviePlayerView *playerView = [[IJKMoviePlayerView alloc] initWithURL:url title:@"视频标题"];
    self.playerView = playerView;
    playerView.delegate = self;
    [self.view addSubview:playerView];
    [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@88);
        make.height.equalTo(@(self.view.bounds.size.width * 9 /16));
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    appDelegate.allowOrentitaionRotation = YES;
    
    [self.playerView viewWillAppear];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    appDelegate.allowOrentitaionRotation = NO;
    
    [self.playerView viewDidDisappear];
}


#pragma mark - 横竖屏

/// 横竖屏切换
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    if ([UIDevice currentDevice].orientation ==UIDeviceOrientationLandscapeLeft||[UIDevice currentDevice].orientation ==UIDeviceOrientationLandscapeRight){
        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }else{
        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(@88);
            CGFloat value = self.view.bounds.size.width;
            if (self.view.bounds.size.height < self.view.bounds.size.width) {
                value = self.view.bounds.size.height;
            }
            make.height.equalTo(@(value * 9 /16));
        }];
    }
}

//#pragma mark - IJKMoviePlayerViewDelegate
//- (void)playerView:(IJKMoviePlayerView *)player isFullscreen:(BOOL)isFullscreen {
//    if (isFullscreen == YES) {
//        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view);
//        }];
//    }else {
//        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self.view);
//            make.top.equalTo(@88);
//            make.height.equalTo(@(self.view.bounds.size.width * 9 /16));
//        }];
//    }
//}



@end
