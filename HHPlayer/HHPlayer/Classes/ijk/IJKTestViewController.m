//
//  IJKTestViewController.m
//  HHPlayer
//
//  Created by Ansjer on 2020/11/12.
//

#import "IJKTestViewController.h"
#import "IJKMoviePlayerViewController.h"
#import "IJKMoviePlayerVC.h"

@interface IJKTestViewController ()

@end

@implementation IJKTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)action1:(id)sender {
    // https://github.com/bilibili/ijkplayer
    //NSURL *url = [NSURL URLWithString:@"http://vjs.zencdn.net/v/oceans.mp4"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"265" withExtension:@"mp4"];
    [IJKVideoViewController presentFromViewController:self withTitle:@"测试265" URL:url completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

- (IBAction)action2:(id)sender {
    // 基于ijk封装的
    //NSURL *url = [[NSBundle mainBundle] URLForResource:@"265" withExtension:@"mp4"];
    IJKMoviePlayerVC *vc = [[IJKMoviePlayerVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
