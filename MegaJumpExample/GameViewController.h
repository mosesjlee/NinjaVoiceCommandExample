//
//  GameViewController.h
//  MegaJumpExample
//

//  Copyright (c) 2016 Moses Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <OpenEars/OEPocketsphinxController.h>
#import <OpenEars/OEFliteController.h>
#import <OpenEars/OELanguageModelGenerator.h>
#import <OpenEars/OELogging.h>
#import <OpenEars/OEAcousticModel.h>
#import "GameScene.h"

@interface GameViewController : UIViewController <OEEventsObserverDelegate>

//OpenEars Objects
@property (nonatomic, strong) OEEventsObserver * eventsObserver;
@property (nonatomic, copy) NSString *pathToFirstDynamicallyGeneratedLanguageModel;
@property (nonatomic, copy) NSString *pathToFirstDynamicallyGeneratedDictionary;

//My objects
//@property (nonatomic, strong) Novocaine * audioManager;
//@property (nonatomic, assign) RingBuffer * ringBuffer;
@property (strong, nonatomic) IBOutlet UILabel *volumeLabel;
@property (nonatomic, weak) GameScene * scene;
@end
