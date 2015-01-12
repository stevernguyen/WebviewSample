//
//  ViewController.m
//  WebviewSample
//
//  Created by Quynh Nguyen Van on 1/12/15.
//  Copyright (c) 2015 Quynh Nguyen Van. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#define NCT     @"http://www.nhaccuatui.com/video.html"
#define mp3zing @"http://mp3.zing.vn/the-loai-video/Viet-Nam/IWZ9Z08I.html"
#define youtube @"https://www.youtube.com/watch?v=JpiBjztPf1k"

@interface ViewController ()
{
    NSString * currentURL;
}
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initNotificationObservers];
    
    NSURL *url = [NSURL URLWithString:mp3zing];
    [self.webview loadRequest:[[NSURLRequest alloc] initWithURL:url]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)playerItemBecameCurrent:(NSNotification*)notification {
    AVPlayerItem *playerItem = [notification object];
    if(playerItem == nil) return;
    
    // Break down the AVPlayerItem to get to the path
    AVURLAsset *asset = (AVURLAsset*)[playerItem asset];
    NSURL *url = [asset URL];
    NSString *path = [url absoluteString];
    
    NSLog(@"\n");
    NSLog(@"\n\n==> CONTENT URL: %@\n\n",path);
    NSLog(@"\n");
}

- (void)initNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemBecameCurrent:)
                                                 name:@"AVPlayerItemBecameCurrentNotification"
                                               object:nil];
    
}

@end
