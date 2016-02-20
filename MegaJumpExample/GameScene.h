//
//  GameScene.h
//  MegaJumpExample
//

//  Copyright (c) 2016 Moses Lee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKMScene.h"

@interface GameScene : SKMScene<SKPhysicsContactDelegate>
@property (nonatomic) SKSpriteNode * player;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) CGPoint fireLocation;

-(void) fireProjectile;
-(void) moveNinjaUp;
-(void) moveNinjaDown;
@end
