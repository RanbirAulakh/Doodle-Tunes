//
//  HelloWorldLayer.m
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

#import "HelloWorldLayer.h"
#import "AppDelegate.h"
#import "CCParallaxNode-Extras.h"
#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "PauseScene.h"
#import "SimpleAudioEngine.h"
#import "ScoresScene.h"
#import "GameOverScene.h"
#import "CCParticleExamples.h"

#pragma mark - HelloWorldLayer

@implementation HelloWorldLayer


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//Sprite Finished.
-(void)spriteMoveFinished:(id)sender {
	CCSprite *sprite = (CCSprite *)sender;
	[self removeChild:sprite cleanup:YES];
}

//TagObjects
enum  {
	kTagPlayer, //Player
	kTagEnemy, //Asteroids
	kTagStars, //Stars
};

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init]) ) {
        CGSize winSize = [CCDirector sharedDirector].winSize; // 5
        isTouchEnabled_ = YES; //Touching is ENABLED!
        
        // Initialize arrays
		_stars = [[NSMutableArray alloc] init];
		_targets = [[NSMutableArray alloc] init];
        
        //Main Player
		CCSprite *player = [CCSprite spriteWithFile:@"Player.png" rect:CGRectMake(0, 0, 100, 65)];
		player.position = ccp(player.contentSize.width/2, winSize.height/2);
		[self addChild:player z:1 tag:kTagPlayer];
        
        //Score
		starsCollected = 0; //Set Score to ZERO
		label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"SCORE: %d", starsCollected] fontName:@"Trebuchet MS" fontSize:24];
		starsCollected+= 0; //Zero at Beginning. ++ = 1
		label.color = ccc3(225, 215, 0); //Gold/Yellow
		label.position = ccp(410,305); // Position of the Label
		[self addChild:label z:10];
        
        //Distance Ran
        distanceRan = 0;
        labelDistance = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d M", distanceRan] fontName:@"Trebuchet MS" fontSize:24];
        distanceRan += 0;
        labelDistance.color = ccc3(225, 215, 0); //Gold/Yellow
		labelDistance.position = ccp(45,305); // Position of the Label
		[self addChild:labelDistance z:12];
        
        
        //Pause
        CCMenuItem *Pause = [CCMenuItemImage itemWithNormalImage:@"pausebutton.png" selectedImage:nil target:self selector:@selector(pause:)]; //Pause Button
		CCMenu *PauseButton = [CCMenu menuWithItems: Pause, nil]; // Go to Pause
		PauseButton.position = ccp(25,25); //Position
		[self addChild:PauseButton z:11];
        
        // Create the Group of Parallax scrolling
        _backgroundNode = [CCParallaxNode node];
        [self addChild:_backgroundNode z:-1];
        
        // Parallax Scrolling
        _starsbg1 = [CCSprite spriteWithFile:@"_starsbg1.png"];
        _starsbg2 = [CCSprite spriteWithFile:@"_starsbg1.png"];
        _mars = [CCSprite spriteWithFile:@"bg_planetsunrise.png"];
        _planet1 = [CCSprite spriteWithFile:@"planet11.png"];
        _planet2 = [CCSprite spriteWithFile:@"planet12.png"];
        
        // Determine the Speed
        CGPoint dustSpeed = ccp(0.1, 0.1);
        CGPoint bgSpeed = ccp(0.05, 0.05);
        
        //Position of the image and start it!
        [_backgroundNode addChild:_starsbg1 z:0 parallaxRatio:dustSpeed positionOffset:ccp(0,winSize.height/2)];
        [_backgroundNode addChild:_starsbg2 z:0 parallaxRatio:dustSpeed positionOffset:ccp(_starsbg1.contentSize.width,winSize.height/2)];
        [_backgroundNode addChild:_mars z:-1 parallaxRatio:bgSpeed positionOffset:ccp(600,winSize.height * 0)];
        [_backgroundNode addChild:_planet1 z:-1 parallaxRatio:bgSpeed positionOffset:ccp(900,winSize.height * 0.3)];
        [_backgroundNode addChild:_planet2 z:-1 parallaxRatio:bgSpeed positionOffset:ccp(1500,winSize.height * 0.9)];
        
        //Start the Specific
		[self schedule:@selector(move) interval:.01];
		[self schedule:@selector(move1) interval:.02];
        [self schedule:@selector(gameLogic:)interval:1.0];
        [self schedule:@selector(gameLogic1:) interval:4.0];
        [self scheduleUpdate];
        
        //Audio
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"DoodleTunesFullMix.caf"];
        
        x = 5;
		y = 5;

	}
	return self;
}

//Began to Touch
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	return;
}

//Move the Player
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *) event{
	UITouch * myTouch = [touches anyObject]; //Able to Touch the Object
	CGPoint point = [myTouch locationInView :[myTouch view]];
	point = [[CCDirector sharedDirector] convertToGL:point];
    
	CCNode * sprite = [self getChildByTag:kTagPlayer]; //Move
	[sprite setPosition:point]; //Position Set after Moved.
	return;
}

// Parallax Scrolling Update Method
- (void)update:(ccTime)dt {
    
    //Increase the meter
    DistanceTiming += dt;
    if ( DistanceTiming >= 0.25f ) {
        distanceRan += 1;
        DistanceTiming -= 0.25f;
   }
    
    //Increase the score
    starTiming += dt;
    if ( starTiming >= 0.50f ) {
        starsCollected += 6;
        starTiming -= 0.50f;
    }
        
    CGPoint backgroundScrollVel = ccp(-1000, 0);
    _backgroundNode.position = ccpAdd(_backgroundNode.position, ccpMult(backgroundScrollVel, dt));
    
    NSArray *spaceDusts = [[NSArray alloc] initWithObjects:_starsbg1, _starsbg2, nil];
    for (CCSprite *spaceDust in spaceDusts) {
        if ([_backgroundNode convertToWorldSpace:spaceDust.position].x < -spaceDust.contentSize.width) {
            [_backgroundNode incrementOffset:ccp(2*spaceDust.contentSize.width,0) forChild:spaceDust];
        }
    }
    
    NSArray *backgrounds = [[NSArray alloc] initWithObjects:_mars, _planet1, _planet2, nil];
    for (CCSprite *background in backgrounds) {
        if ([_backgroundNode convertToWorldSpace:background.position].x < -background.contentSize.width) {
            [_backgroundNode incrementOffset:ccp(2000,0) forChild:background];
        }
    }
    
    
}

//SPAWN STARS
-(void)gameLogic1:(ccTime)dt {
	
	[self addStars];
	
}

//SPAWN ASTEROIDS
-(void)gameLogic:(ccTime)dt {
	
	[self addTarget];
	
}

//ADDING ASTEROIDS
-(void)addTarget {
	CCSprite *target = [CCSprite spriteWithFile:@"Enemy.png" rect:CGRectMake(0, 0, 60, 60)];
	
	// Determine where to spawn the target along the Y axis
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	int minY = target.contentSize.height/2;
	int maxY = winSize.height - target.contentSize.height/2;
	int rangeY = maxY - minY;
	int actualY = (arc4random() % rangeY) + minY;
	
	// Create the target slightly off-screen along the right edge,
	// and along a random position along the Y axis as calculated above
	target.position = ccp(winSize.width + (target.contentSize.width/2), actualY);
	[self addChild:target];
	
	// Speed of an Asteroid
	int minDuration = 1.0;
	int maxDuration = 2.0;
	int rangeDuration = maxDuration - minDuration;
	int actualDuration = (arc4random() % rangeDuration) + minDuration;
	
	// Create the actions
	id actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp(-target.contentSize.width/2, actualY)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
	[target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	
	target.tag = 1;
	[_targets addObject:target];
	
}

//ADDING STARS
-(void)addStars {
	
	CCSprite *stars = [CCSprite spriteWithFile:@"star.png" rect:CGRectMake(0, 0, 40, 40)]; //Get Stars and Size of the Stars
	stars.tag = kTagStars;
	
	// Determine where to spawn the target along the Y axis
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	int minY = stars.contentSize.height/2;
	int maxY = winSize.height - stars.contentSize.height/2;
	int rangeY = maxY - minY;
	int actualY = (arc4random() % rangeY) + minY;
	
	// Create the target slightly off-screen along the right edge,
	// and along a random position along the Y axis as calculated above
	stars.position = ccp(winSize.width + (stars.contentSize.width/2), actualY);
	[self addChild:stars];
	
	// Speed of the Stars
	int minDuration = 1.0;
	int maxDuration = 2.0;
	int rangeDuration = maxDuration - minDuration;
	int actualDuration = (arc4random() % rangeDuration) + minDuration;
	
	// Create the actions
	id actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp(-stars.contentSize.width/2, actualY)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
	[stars runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	
	// Add to Stars array
	[_stars addObject:stars];
	
}

//Pause
-(void) pause: (id) sender {
	[[CCDirector sharedDirector] pushScene:[PauseScene node]];
}

//Collect Stars!
-(void)move1{
	[label setString:[NSString stringWithFormat:@"Score: %d", starsCollected]];
    [labelDistance setString:[NSString stringWithFormat:@"%d M", distanceRan]];
	
	CCNode * stars = [self getChildByTag:kTagStars]; //Get Stars
	if(stars)
	{
		CCNode * player = [self getChildByTag:kTagPlayer]; //Get Main Player
		
		
        if (stars.position.x > 480 || stars.position.x < 0) {
			x =-x;
		}
		if (stars.position.y > 320 || stars.position.y < 0) {
			y =-y;
		}
        
        //this part here, what is this doing? detects the collison, this says, if the stars'x coordinate is greater than 480 or less than
        //0 then x = the opposite of itself, this would put it in the lower cornder, run this program for me i want to see the collision
		
        
		//Collision Detection
		float xDif = stars.position.x - player.position.x;
		float yDif = stars.position.y - player.position.y;
		float distance = sqrtf(xDif * xDif + yDif * yDif);        
        
		if(distance < 30) {
			starsCollected += 100;
           //starsCollected = starsCollected + 10;
			[_stars removeObject:stars];
            
            
            //Stars Explosion
            //starsExplosion.position = ccp(stars.contentSize.width, stars.contentSize.height);
            starsExplosion = [[CCParticleExplosion alloc] init];
            starsExplosion.position = ccp(stars.position.x + 20, stars.position.y);
            //what is the var type for positiontype? same thing
            starsExplosion.texture = [[CCTextureCache sharedTextureCache] addImage:@"star-icon.png"];
            
           [self addChild:starsExplosion];
            
			[self removeChild:stars cleanup:YES];
			[[SimpleAudioEngine sharedEngine] playEffect:@"starpickup.caf"];
		}
	}
}

-(void) move{
	CCNode * target = [self getChildByTag:kTagEnemy]; //Get Asteroids
	CCNode * player = [self getChildByTag:kTagPlayer]; //Get Main Player
	
	if (target.position.x < 480 || target.position.x < 0) {
		x =-x;
	}
	if (target.position.y < 320 || target.position.y < 0) {
		y =-y;
	}
	
	//Collision Detection
	float xDif = target.position.x - player.position.x;
	float yDif = target.position.y - player.position.y;
	float distance = sqrtf(xDif * xDif + yDif * yDif); //when it touch smoke, it take smoke away!
	
	//Radius of the Player and Asteroids. PlayerRadius + AsteroidsRadius = TotalRadius
	if(distance < 45) {
		//Once Hit, Stop Spawning Asteroids and Stars.
		[[SimpleAudioEngine sharedEngine] playEffect:@"HitAsteroids.caf"];
		[self unschedule:@selector(move)];
		//[self unschedule:@selector(move1)];
		[self unschedule:@selector(gameLogic:)];
		[self unschedule:@selector(gameLogic1:)];
		
        
        NSMutableArray *highScores = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"scores"]];
        if (highScores==nil) {
            highScores = [NSMutableArray array];
        }
        [highScores addObject:[NSNumber numberWithInt:starsCollected]];
        [highScores sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            //*-1 since you really want it descending order, not ascending.
            return -1*[obj1 compare:obj2];
        }];
        if ([highScores count]>5) {
            [highScores removeLastObject];
        }
        [[NSUserDefaults standardUserDefaults] setObject:highScores forKey:@"scores"];
        [[NSUserDefaults standardUserDefaults] synchronize];
		
		
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic]; //Stops the MUSIC!
		[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameOverScene node]]]; //Go to GameOver Scene
	}
}

//Once gameover, send to GameOverScene
-(void) alertView:(UIAlertView *) alert clickButtonAtIndex:(NSUInteger) buttonIndex{
    if(buttonIndex == 0){
        [[CCDirector sharedDirector] replaceScene:[CCTransitionZoomFlipY transitionWithDuration:1 scene:[GameOverScene node]]];
        //Alert Button
        //Tranitions = CCTransitionZoomFlipAngular
    }
}

-(void) dealloc
{
    //to release it.
	[_targets release];
	_targets = nil;
	[_stars release];
	_stars = nil;
    
    [super dealloc];
}
@end
