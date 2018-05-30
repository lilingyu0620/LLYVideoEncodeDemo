//
//  ViewController.m
//  LLYVideoEncodeDemo
//
//  Created by lly on 2018/5/30.
//  Copyright © 2018年 lly. All rights reserved.
//

#import "ViewController.h"
#import "ELPushStreamConfigeration.h"

#import "ELImageVideoCamera.h"
#import "ELImageView.h"
#import "ELImageVideoEncoder.h"

@interface ViewController ()<ELVideoEncoderStatusDelegate>


@property (nonatomic, strong) ELImageVideoCamera *videoCamera;
@property (nonatomic, strong) ELImageView *imageView;
@property (nonatomic, strong) ELImageVideoEncoder *videoEncode;

@property (nonatomic, assign) BOOL started;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.started = NO;
    
    self.videoCamera = [[ELImageVideoCamera alloc]initWithFPS:kFrameRate];
    [self.videoCamera startCapture];
    
    self.imageView = [[ELImageView alloc]initWithFrame:self.view.bounds];
    [self.view insertSubview:self.imageView atIndex:0];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.videoCamera addTarget:self.imageView];
    
}
- (IBAction)startBtnClicked:(id)sender {
    
    if (self.started) {
        [self.videoCamera removeTarget:self.videoEncode];
        [self.videoEncode stopEncode];
        self.videoEncode = nil;
        self.started = NO;
        [self.startBtn setTitle:@"开始录制" forState:UIControlStateNormal];
    }
    else{
         self.videoEncode = [[ELImageVideoEncoder alloc] initWithFPS:kFrameRate maxBitRate:kMaxVideoBitRate avgBitRate:kAVGVideoBitRate encoderWidth:kDesiredWidth encoderHeight:kDesiredHeight encoderStatusDelegate:self];
        [self.videoCamera addTarget:self.videoEncode];
        self.started = YES;
        [self.startBtn setTitle:@"结束录制" forState:UIControlStateNormal];
    }
    
}

- (void) onEncoderInitialFailed{}

- (void) onEncoderEncodedFailed{}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
