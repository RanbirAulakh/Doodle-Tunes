//
//  GameOverScene.m
//  1
//
//  Created by BTLC on 9/23/12.
//  Copyright (c) 2012 BTLC. All rights reserved.
//
/*  Copyright (C) 2012 - 2013 Ranbir Aulakh
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 Credit to Jana Jennings for Music, Peter Flans/Tom Wright for
 Graphics, Joe Bartlemo/Kyle Fishler for certain Programming.
 */
#import "GameOverScene.h"
#import "SimpleAudioEngine.h"
#import "HelloWorldLayer.h"
#import "Home.h"

@implementation GameOverScene
+(id) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOverScene *layer = [GameOverScene node];
    //layer.score = score;
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(id) init
{
	if( (self=[super init] )) {
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"gameoverfx.caf"]; //Gameover Music
		CCSprite * bg1 = [CCSprite spriteWithFile:@"gameover.png"]; //Background of the Game
		bg1.position = ccp(240, 160); //Position
		[self addChild:bg1]; //Add BG
		
        
		[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:5],[CCCallFunc actionWithTarget:self selector:@selector(gameOverDone)],nil]];
		
	}
	return self;
}


//What to do after 5 seconds
- (void)gameOverDone {    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:1.0 scene:[Home node]]];
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];	//Stop the GameOver Music
}

- (void)dealloc {
    [super dealloc];
    
}

@end
