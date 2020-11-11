//
//  IJKMoviePlayerView.h
//  ijkPlayer自定义
//
//  Created by Ansjer on 2020/9/28.
//  Copyright © 2020 www.hopechina.cc 中和黄埔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>

#import "Masonry.h"

@class IJKMoviePlayerView;

NS_ASSUME_NONNULL_BEGIN


@protocol IJKMoviePlayerViewDelegate <NSObject>

/**
 *  点击 全屏/非全屏切换
 */
- (void)playerView:(IJKMoviePlayerView *)player isFullscreen:(BOOL)isFullscreen;


@end

@interface IJKMoviePlayerView : UIView

- (instancetype)initWithURL:(NSURL *)url title:(NSString *)title;

@property (nonatomic, weak) id delegate;

@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@property (nonatomic, assign) BOOL isFullscreen;

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIView *playerBottomView;
/// selected：YES暂停  NO播放
@property (nonatomic, strong) UIButton *playPauseButton;
@property (nonatomic, strong) UISlider *progressSlider;
@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) UILabel *totalDurationLabel;

- (void)viewWillAppear;

- (void)viewDidDisappear;

@end

NS_ASSUME_NONNULL_END
