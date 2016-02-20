//
//  SKScene+SKMScene.m
//  NinjaExample
//
//  Created by Moses Lee on 2/19/16.
//  Copyright © 2016 Moses Lee. All rights reserved.
//

#import "SKMScene.h"

@implementation SKMScene
#if TARGET_OS_IPHONE
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    [self screenInteractionStartedAtLocation:positionInScene];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    [self screenInteractionEndedAtLocation:positionInScene];
}

- (void)touchesCancelled:(NSSet *)touches
withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    [self screenInteractionEndedAtLocation:positionInScene];
}
#else
-(void)mouseDown:(NSEvent *)theEvent {
    CGPoint positionInScene = [theEvent locationInNode:self];
    [self screenInteractionStartedAtLocation:positionInScene];
}

- (void)mouseUp:(NSEvent *)theEvent
{
    CGPoint positionInScene = [theEvent locationInNode:self];
    [self screenInteractionEndedAtLocation:positionInScene];
}

- (void)mouseExited:(NSEvent *)theEvent
{
    CGPoint positionInScene = [theEvent locationInNode:self];
    [self screenInteractionEndedAtLocation:positionInScene];
}
#endif

-(void)screenInteractionStartedAtLocation:(CGPoint)location {
    /* Overridden by Subclass */
}

-(void)screenInteractionEndedAtLocation:(CGPoint)location {
    /* Overridden by Subclass */
}
@end
