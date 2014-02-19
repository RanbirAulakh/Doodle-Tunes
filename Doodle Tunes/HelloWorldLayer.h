//
//  HelloWorldLayer.h
//  
//
//  Created by Ranbir Singh on 10/25/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
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


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCParticleExplosion *starsExplosion;
    
    int x, y;
	NSMutableArray *_targets;
	NSMutableArray *_stars;
    
    //Parallax-Scrolling Jana
    CCParallaxNode *_backgroundNode;
    CCSprite *_starsbg1;
    CCSprite *_starsbg2;
    CCSprite *_planet1;
    CCSprite *_planet2;
    CCSprite *_mars;
    
    //Score
	CCLabelTTF * label;
	int starsCollected;
    
    //Distance
	CCLabelTTF * labelDistance;
	int distanceRan;
    
    ccTime starTiming;
    ccTime DistanceTiming;
}
@property (nonatomic, retain) HelloWorldLayer *layer;
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
