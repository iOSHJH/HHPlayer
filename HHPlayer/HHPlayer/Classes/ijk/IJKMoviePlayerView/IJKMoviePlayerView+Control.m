//
//  IJKMoviePlayerView+Control.m
//  ijkPlayer自定义
//
//  Created by Ansjer on 2020/9/28.
//  Copyright © 2020 www.hopechina.cc 中和黄埔. All rights reserved.
//

#import "IJKMoviePlayerView+Control.h"

@implementation IJKMoviePlayerView (Control)

- (void)initControlView {
    UIButton *titleButton = [[UIButton alloc] init];
    [titleButton setTitle:self.title forState:(UIControlStateNormal)];
    [titleButton addTarget:self action:@selector(titleAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:titleButton];
    [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
    }];
    
    UIView *playerBottomView = [[UIView alloc] init];
    self.playerBottomView = playerBottomView;
    playerBottomView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    [self addSubview:playerBottomView];
    [playerBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@(40));
    }];
    
    UIButton *playPauseButton = [[UIButton alloc] init];
    self.playPauseButton = playPauseButton;
    [playPauseButton setImage:[UIImage imageNamed:@"icon_pause"] forState:(UIControlStateNormal)];
    [playPauseButton setImage:[UIImage imageNamed:@"icon_play"] forState:(UIControlStateSelected)];
    [playPauseButton addTarget:self action:@selector(playPauseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [playerBottomView addSubview:playPauseButton];
    [playPauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(playerBottomView);
        make.size.equalTo(@(CGSizeMake(40, 40)));
    }];
    
    
    UILabel *currentTimeLabel = [[UILabel alloc] init];
    self.currentTimeLabel = currentTimeLabel;
    currentTimeLabel.text = @"00:00";
    currentTimeLabel.textColor = UIColor.whiteColor;
    currentTimeLabel.font = [UIFont systemFontOfSize:12];
    [playerBottomView addSubview:currentTimeLabel];
    [currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(playPauseButton.mas_right).offset(0);
        make.centerY.equalTo(playerBottomView);
    }];
    
    UIButton *fullScreenButton = [[UIButton alloc] init];
    [fullScreenButton setImage:[UIImage imageNamed:@"icon_full"] forState:(UIControlStateNormal)];
    [fullScreenButton addTarget:self action:@selector(fullScreenAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [playerBottomView addSubview:fullScreenButton];
    [fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.centerY.equalTo(playerBottomView);
        make.size.equalTo(@(CGSizeMake(40, 40)));
    }];
    
    UILabel *totalDurationLabel = [[UILabel alloc] init];
    self.totalDurationLabel = totalDurationLabel;
    totalDurationLabel.text = @"--:--";
    totalDurationLabel.textColor = UIColor.whiteColor;
    totalDurationLabel.font = [UIFont systemFontOfSize:12];
    [playerBottomView addSubview:totalDurationLabel];
    [totalDurationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(fullScreenButton.mas_left).offset(0);
        make.centerY.equalTo(playerBottomView);
    }];
    
    UISlider *progressSlider = [[UISlider alloc] init];
    self.progressSlider = progressSlider;
    [self.progressSlider addTarget:self action:@selector(sliderProgressChange:) forControlEvents:UIControlEventValueChanged];
    [self.progressSlider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self.progressSlider addTarget:self action:@selector(sliderTouchUpInSide:) forControlEvents:UIControlEventTouchUpInside];
    [playerBottomView addSubview:progressSlider];
    [progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.right.equalTo(@(-80));
        make.centerY.equalTo(playerBottomView);
    }];
    
    
    

    
    
}

#pragma mark - Action

- (void)titleAction {
    
}

- (void)playPauseAction:(UIButton *)button {
    button.selected = !button.isSelected;
    
    if (button.isSelected == YES) {
        [self.player pause];
    }else {
        [self.player play];
    }
}

- (void)fullScreenAction:(UIButton *)button {
    NSLog(@"============fullScreenAction");
    self.isFullscreen = !self.isFullscreen;
    if (self.isFullscreen == YES) {
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    }else {
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    }
    if ([self.delegate respondsToSelector:@selector(playerView:isFullscreen:)]) {
        [self.delegate playerView:self isFullscreen:self.isFullscreen];
    }
}

/// 值改变
- (void)sliderProgressChange:(UISlider *)slider {
    
    NSLog(@"value = %f", slider.value);
    
}

/// 触摸按下
- (void)sliderTouchDown:(UISlider *)slider {
    
    NSLog(@"开始？value = %f", slider.value);
    
}

/// 触摸抬起
- (void)sliderTouchUpInSide:(UISlider *)slider {
    
    NSLog(@"结束？value = %f", slider.value);
    self.player.currentPlaybackTime = slider.value;
}

- (void)refreshMediaControl {
    
    // duration
    NSTimeInterval duration = self.player.duration;
    NSInteger intDuration = duration + 0;
    if (intDuration > 0) {
        self.progressSlider.maximumValue = duration;
        self.totalDurationLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)(intDuration / 60), (int)(intDuration % 60)];
    } else {
        self.totalDurationLabel.text = @"--:--";
        self.progressSlider.maximumValue = 1.0f;
    }
    
    // position
    NSTimeInterval position = 0.0;
    position = self.player.currentPlaybackTime;
    NSInteger intPosition = position + 0;
    if (intDuration > 0) {
        self.progressSlider.value = position;
    } else {
        self.progressSlider.value = 0.0f;
    }
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)(intPosition / 60), (int)(intPosition % 60)];
    
    if (self.playerBottomView.isHidden == NO && self.player.isPlaying == YES) {
        [self performSelector:@selector(refreshMediaControl) withObject:nil afterDelay:1];
    }
}

@end
