//
//  ScoresScene.m
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


#import "ScoresScene.h"
#import "HelloWorldLayer.h"
#import "Home.h"

@implementation ScoresScene
+ (id)scene
{
	CCScene *scene = [CCScene node];
	
	ScoresScene *layer = [ScoresScene node];
	
	[scene addChild:layer];
	
	return scene;
}

- (id)init
{
	if ((self = [super init]))
	{
		CGSize windowSize = [CCDirector sharedDirector].winSize;
		
		CCSprite * bg = [CCSprite spriteWithFile:@"hgTom.png"]; //Background for Main
		bg.position = ccp(240, 160); //Position of the Background
		[self addChild:bg]; //Add the Background
		
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		
		NSArray *highScores = [defaults arrayForKey:@"scores"];
		
		// Create title label
		CCLabelTTF *title = [CCLabelTTF labelWithString:@" " fontName:@"Trebuchet MS" fontSize:32.0];
		[title setPosition:ccp(windowSize.width / 2, windowSize.height - title.contentSize.height)];
		[self addChild:title];
		
		// Create a mutable string which will be used to store the score list
		NSMutableString *scoresString = [NSMutableString stringWithString:@""];
		
		// Iterate through array and print out high scores
		for (int i = 0; i < [highScores count]; i++)
		{
            [defaults synchronize];
			[scoresString appendFormat:@"%i. %i\n", i + 1, [[highScores objectAtIndex:i] intValue]];
		}
		
        
        CCLabelTTF *scoresLabel = [CCLabelTTF labelWithString:scoresString dimensions:CGSizeMake(windowSize.width, windowSize.height / 3) hAlignment:kCCTextAlignmentCenter fontName:@"Trebuchet MS" fontSize:18.0];
		[scoresLabel setPosition:ccp(windowSize.width / 2, windowSize.height / 2)];
        [scoresLabel setColor:ccBLACK];
		[self addChild:scoresLabel];
		
		// Create button that will take us back to the title screen
		CCMenuItemFont *backButton = [CCMenuItemFont itemWithString:@"GO BACK" target:self selector:@selector(backButtonAction)];
		
		// Create menu that contains our buttons
		CCMenu *menu = [CCMenu menuWithItems:backButton, nil];
		
		// Set position of menu to be top of the Screen
		[menu setPosition:ccp(74.7,281.5)];
        [menu setColor:ccBLACK];
        [backButton setFontName:@"Trebuchet MS"];
        [backButton setFontSize:20.0];
        [backButton setColor:ccBLACK];
		
		// Add menu to layer
		[self addChild:menu z:2];
	}
	
	return self;
}

- (void)backButtonAction
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:1.0 scene:[Home node]]];
}

@end

