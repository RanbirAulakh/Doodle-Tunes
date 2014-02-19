//
//  Home.m
//  Doodle Tunes
//
//  Created by Ranbir Singh on 12/20/12.
//
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

#import "Home.h"
#import "HelloWorldLayer.h"
#import "CreditScene.h"
#import "ScoresScene.h"
#import "HTP.h"

@implementation Home
+(id) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Home *layer = [Home node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(id) init
{
	
	if( (self=[super init] )) {
        
        CCSprite * bgcredit = [CCSprite spriteWithFile:@"homeTom.png"]; //Background for Main
        bgcredit.position = ccp(240, 160); //Position of the Background
        [self addChild:bgcredit z:0]; //Add the Background
        
		[CCMenuItemFont setFontSize:32];
		[CCMenuItemFont setFontName:@"Trebuchet MS"];
		
		CCMenuItem * item1 = [CCMenuItemFont itemWithString:@"START!" target:self selector:@selector(Gameplay:)]; //Text on Screen
		item1.position = ccp(5,38);
        [(CCMenuItemFont *)item1 setColor:ccBLACK];
		CCMenu * menu = [CCMenu menuWithItems:item1, nil]; //Created new Menu
		[self addChild:menu z:1]; // Created new Menu
		
		CCMenuItem * item2 = [CCMenuItemFont itemWithString:@"HOW TO PLAY" target:self selector:@selector(HTPS:)]; //Text on Screen
		item2.position = ccp(5,-13);
		CCMenu * menu1 = [CCMenu menuWithItems:item2, nil]; //Created new Menu
        [(CCMenuItemFont *)item2 setColor:ccBLACK];
		[self addChild:menu1 z:2]; // Created new Menu
        
		CCMenuItem * item3 = [CCMenuItemFont itemWithString:@"CREDITS" target:self selector:@selector(creditS:)]; //Text on Screen
		item3.position = ccp(5,-65);
		CCMenu * menu2 = [CCMenu menuWithItems:item3, nil]; //Created new Menu
        [(CCMenuItemFont *)item3 setColor:ccBLACK];
		[self addChild:menu2 z:3]; // Created new Menu
        
        CCMenuItem * item4 = [CCMenuItemFont itemWithString:@"HIGHSCORE" target:self selector:@selector(ScoreS:)]; //Text on Screen
		item4.position = ccp(5,-118);
        [(CCMenuItemFont *)item4 setColor:ccBLACK];
		CCMenu * menu3 = [CCMenu menuWithItems:item4, nil]; //Created new Menu
		[self addChild:menu3 z:4]; // Created new Menu
        
	}
	return self;
}
//
-(void) Gameplay: (id) sender {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:0.0 scene:[HelloWorldLayer node]]]; //Goes back to Gameplay
}
//
-(void) creditS: (id) sender {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:1.0 scene:[CreditScene node]]]; //Goes back to Credt
}
//
-(void) ScoreS: (id) sender {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:1.0 scene:[ScoresScene node]]]; //Goes back to Score
}
-(void) HTPS: (id) sender {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:1.0 scene:[HTP node]]]; //Goes back to How To Play
}
@end
