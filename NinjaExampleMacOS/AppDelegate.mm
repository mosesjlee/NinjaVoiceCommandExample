//
//  AppDelegate.m
//  NinjaExampleMacOS
//
//  Created by Moses Lee on 2/19/16.
//  Copyright (c) 2016 Moses Lee. All rights reserved.
//

#import "AppDelegate.h"
#import "GameScene.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    CGSize size = CGSizeMake(1024, 768);
    SKScene *scene = [GameScene sceneWithSize:size];
    
    NSLog(@"Scaling the screen");
    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = SKSceneScaleModeAspectFit;
    
    NSLog(@"Presenting the screen");
    [self.skView presentScene:scene];

    /* Sprite Kit applies additional optimizations to improve rendering performance */
    self.skView.ignoresSiblingOrder = YES;
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    
    //Initialize the wrapper
    NSString * bundlePath = [[NSBundle mainBundle] resourcePath];
    self.pSphinx = new PocketSphinxWrapper([bundlePath cStringUsingEncoding:1]);
    
    //For novocaine stuff to capture audio
    self.audioManager = [Novocaine audioManager];
    
    self.ringBuffer = new RingBuffer(32768, 2);
    
    __weak AppDelegate * wself = self;
    
    //This is where you get stream from microphone
    [self.audioManager setInputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels) {

    }];

    //Start the audio process
    [self.audioManager play];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    [self.audioManager pause];
    return YES;
}

@end
