//
//  SKScene+SKMScene.h
//  NinjaExample
//
//  Created by Moses Lee on 2/19/16.
//  Copyright © 2016 Moses Lee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKMScene :SKScene

-(void)screenInteractionStartedAtLocation:(CGPoint)location;
-(void)screenInteractionEndedAtLocation:(CGPoint)location;

@end
