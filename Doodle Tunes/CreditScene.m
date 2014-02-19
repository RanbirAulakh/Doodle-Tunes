//
//  CreditScene.m
//  Doodle Tunes
//
//  Created by Ranbir Singh on 10/27/12.
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

#import "CreditScene.h"
#import "Home.h"

@implementation CreditScene
+ (id)scene
{
	CCScene *scene = [CCScene node];
	
	CreditScene *layer = [CreditScene node];
	
	[scene addChild:layer];
	
	return scene;
}
- (id)init
{
	if ((self = [super init]))
	{
        CCSprite * bgcredit = [CCSprite spriteWithFile:@"creditTom.png"]; //Background for Main
		bgcredit.position = ccp(240, 160); //Position of the Background
		[self addChild:bgcredit]; //Add the Background
        
        [CCMenuItemFont setFontSize:20];
		[CCMenuItemFont setFontName:@"Trebuchet MS"];
        
		// Create button that will take us back to the title screen
		CCMenuItemFont *backButton = [CCMenuItemFont itemWithString:@"GO BACK" target:self selector:@selector(backButtonAction)]; //Create Button
        backButton.position = ccp(-165.6, 121); // Set Position
        [backButton setColor:ccBLACK]; // Set Color
		
		// Create menu that contains our buttons
		CCMenu *menu = [CCMenu menuWithItems:backButton, nil];
		
		// Add menu to layer
		[self addChild:menu z:2];
	}
	
	return self;
}

- (void)backButtonAction
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:1.0 scene:[Home node]]]; //Take back to mainmenu
}
@end
