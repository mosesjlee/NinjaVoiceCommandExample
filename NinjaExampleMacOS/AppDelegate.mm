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
    GameScene *scene = [GameScene sceneWithSize:size];
    
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
    __block float dbVal = 0.0;
    [self.audioManager setInputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels) {
        int flag = 0;
        vDSP_vsq(data, 1, data, 1, numFrames*numChannels);
        float meanVal = 0.0;
        vDSP_meanv(data, 1, &meanVal, numFrames*numChannels);

        float one = 1.0;
        vDSP_vdbcon(&meanVal, 1, &one, &meanVal, 1, 1, 0);
        dbVal = dbVal + 0.2*(meanVal - dbVal);
        printf("Decibel level: %f\n", dbVal);
        wself.pSphinx->listenForInputStream(data, numFrames, numChannels, &flag);
        
        if(flag > 0) {
            NSLog(@"Processing");

            wself.pSphinx->processTheInputStream();
            if(wself.pSphinx->getTheWord().compare("fire")){
                [scene fireProjectile];
            }
        }
    }];


    //Start the audio process
    [self.audioManager play];
    //self.pSphinx->readAndProcessFromFile();
    //NSLog(@"%s", self.pSphinx->getTheWord().c_str());
    self.wordLabel.stringValue = @"TESTING"; //[NSString stringWithFormat:@"%s", self.pSphinx->getTheWord().c_str()];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    //[self.audioManager pause];
    return YES;
}

@end
