//
//  PauseScene.m
//  1
//
//  Created by Ranbir Aulakh on 9/23/12.
//  Copyright (c) 2012 Ranbir Aulakh. All rights reserved.
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

#import "PauseScene.h"
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
#import "CreditScene.h"
#import "GameOverScene.h"
#import "ScoresScene.h"
#import "Home.h"

@implementation PauseScene

+(id) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PauseScene *layer = [PauseScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	
	if( (self=[super init] )) {
		[[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
		
		CCSprite * bg1 = [CCSprite spriteWithFile:@"pauseTom1.png"]; //Background of the Game
		bg1.position = ccp(240, 160); //Position
		[self addChild:bg1]; //Add BG
		
		[CCMenuItemFont setFontSize:30];
		[CCMenuItemFont setFontName:@"Trebuchet MS"];
		
		CCMenuItemFont *resumebutton = [CCMenuItemFont itemWithString:@"RESUME" target:self selector:@selector(resume:)]; //Resume the game
        resumebutton.position = ccp(8, 63); // Set Position
        [resumebutton setColor:ccBLACK]; // Set Color
		CCMenu *menu = [CCMenu menuWithItems:resumebutton, nil];
		[self addChild:menu z:2];
		
		CCMenuItemFont *exitbutton = [CCMenuItemFont itemWithString:@"QUIT" target:self selector:@selector(GoToMainMenu:)]; //Exit the game
        exitbutton.position = ccp(8, -105); // Set Position
        [exitbutton setColor:ccBLACK]; // Set Color
		CCMenu *menu1 = [CCMenu menuWithItems:exitbutton, nil];
		[self addChild:menu1 z:2];
        
        CCMenuItemFont *restartbutton = [CCMenuItemFont itemWithString:@"RESTART" target:self selector:@selector(restart:)]; //Restart the Game
        restartbutton.position = ccp(8, 10); // Set Position
        [restartbutton setColor:ccBLACK]; // Set Color
		CCMenu *menu2 = [CCMenu menuWithItems:restartbutton, nil];
		[self addChild:menu2 z:2];
	}
	return self;
}

//resume
-(void) resume: (id) sender {
	
	[[CCDirector sharedDirector] popScene]; //Resume the Game
	[[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
}

//GoToMainMenu
-(void) GoToMainMenu: (id) sender {
	
	[[CCDirector sharedDirector] sendCleanupToScene]; //If Exit, clean up the Game
	[[CCDirector sharedDirector] popScene]; //Stop the Game
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:1.0 scene:[Home node]]]; //Goes back to MainMenu
}

//restart Game
-(void) restart: (id) sender {
	
    [[CCDirector sharedDirector] sendCleanupToScene]; //If Exit, clean up the Game
	[[CCDirector sharedDirector] popScene]; //Stop the Game
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:1.0 scene:[HelloWorldLayer node]]]; //Restart the Game
}

@end
