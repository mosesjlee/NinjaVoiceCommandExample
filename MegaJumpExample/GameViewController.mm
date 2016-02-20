//
//  GameViewController.m
//  MegaJumpExample
//
//  Created by Moses Lee on 2/17/16.
//  Copyright (c) 2016 Moses Lee. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    
    //Initialize and set delegate to this controller
    self.eventsObserver = [[OEEventsObserver alloc] init];
    [self.eventsObserver setDelegate:self];
    
    //Get the instance of the controller and set to active
    [[OEPocketsphinxController sharedInstance] setActive:TRUE error:nil];
    
    //List of commands that we add to accept
    NSArray *firstLanguageArray = @[@"DOWN",
                                    @"UP",
                                    @"FIRE"];
    
    
    OELanguageModelGenerator *languageModelGenerator = [[OELanguageModelGenerator alloc] init];
    
    NSError *error = [languageModelGenerator generateLanguageModelFromArray:firstLanguageArray withFilesNamed:@"FirstOpenEarsDynamicLanguageModel" forAcousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelEnglish"]];
    
    if(error) {
        NSLog(@"Dynamic language generator reported error %@", [error description]);
    } else {
        self.pathToFirstDynamicallyGeneratedLanguageModel = [languageModelGenerator pathToSuccessfullyGeneratedLanguageModelWithRequestedName:@"FirstOpenEarsDynamicLanguageModel"];
        self.pathToFirstDynamicallyGeneratedDictionary = [languageModelGenerator pathToSuccessfullyGeneratedDictionaryWithRequestedName:@"FirstOpenEarsDynamicLanguageModel"];
    }

    
    [[OEPocketsphinxController sharedInstance] setActive:TRUE error:nil];
    
    if(![OEPocketsphinxController sharedInstance].isListening) {
        [[OEPocketsphinxController sharedInstance] startListeningWithLanguageModelAtPath:self.pathToFirstDynamicallyGeneratedLanguageModel dictionaryAtPath:self.pathToFirstDynamicallyGeneratedDictionary acousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelEnglish"] languageModelIsJSGF:FALSE]; // Start speech recognition if we aren't already listening.
    }
    
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.ringBuffer = new RingBuffer(4096, 2);
//    self.audioManager = [Novocaine audioManager];
//    __weak GameViewController * wself = self;
//    __block float dbVal = 0.0;
//    [self.audioManager setInputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels) {
//
//        vDSP_vsq(data, 1, data, 1, numFrames*numChannels);
//        float meanVal = 0.0;
//        vDSP_meanv(data, 1, &meanVal, numFrames*numChannels);
//
//        float one = 1.0;
//        vDSP_vdbcon(&meanVal, 1, &one, &meanVal, 1, 1, 0);
//        dbVal = dbVal + 0.2*(meanVal - dbVal);
//        printf("Decibel level: %f\n", dbVal);
//    }];
//    __block float frequency = 440.0;
//    __block float phase = 0.0;
//    [self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels)
//     {
//
//         
//         float samplingRate = wself.audioManager.samplingRate;
//         for (int i=0; i < numFrames; ++i)
//         {
//             for (int iChannel = 0; iChannel < numChannels; ++iChannel)
//             {
//                 float theta = phase * M_PI * 2;
//                 data[i*numChannels + iChannel] = sin(theta);
//             }
//             phase += 1.0 / (samplingRate / frequency);
//             if (phase > 1.0) phase = -1;
//         }
//     }];
}



- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    if(!skView.scene){
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = YES;
    
        // Create and configure the scene.
        self.scene = [GameScene sceneWithSize:skView.bounds.size];
        self.scene.scaleMode = SKSceneScaleModeAspectFill;
    
        // Present the scene.
        [skView presentScene:self.scene];
    }
    
    //[self.audioManager play];
}

- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
    
    
    if([hypothesis isEqualToString:@"FIRE"]){
        [self.scene fireProjectile];
    } else if ([hypothesis isEqualToString:@"UP"]) {
        [self.scene moveNinjaUp];
    } else if ([hypothesis isEqualToString:@"DOWN"]) {
        [self.scene moveNinjaDown];
    }
    
    self.volumeLabel.text = [NSString stringWithFormat:@"%@", hypothesis]; // Show it in the status box.
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
