//
//  AppDelegate.h
//  NinjaExampleMacOS
//

//  Copyright (c) 2016 Moses Lee. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SpriteKit/SpriteKit.h>

//Novocaine Libraries
#import "Novocaine.h"
#import "RingBuffer.h"
#include "PocketSphinxWrapper.hpp"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet SKView *skView;
@property (weak) IBOutlet NSTextField *wordLabel;

@property (nonatomic, strong) Novocaine * audioManager;
@property (nonatomic, assign) RingBuffer * ringBuffer;

@property (nonatomic, assign) PocketSphinxWrapper * pSphinx;

@end
