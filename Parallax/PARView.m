//
//  PARView.m
//  Parallax
//
//  Created by Leonhard Lichtschlag on 15/Jul/13.
//  Copyright (c) 2013 Leonhard Lichtschlag. All rights reserved.
//

#import "PARView.h"


// =================================================================================================================
@interface PARView ()
// =================================================================================================================

@property (strong) NSMutableArray *views;

@end


// ===============================================================================================================
@implementation PARView
// ===============================================================================================================

const NSInteger viewCount = 9;
const NSInteger groundViewIndex = 5;

// ---------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Lifecycle
// ---------------------------------------------------------------------------------------------------------------

- (void) didMoveToSuperview
{
	[self buildViews];
}


// ---------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Parallax Effect
// ---------------------------------------------------------------------------------------------------------------

- (void) buildViews
{
	self.views = [NSMutableArray array];
	
	CGRect viewFrame = [self bounds];
	CGRect subViewFrame = CGRectInset(viewFrame, CGRectGetWidth(viewFrame) * 0.3, CGRectGetHeight(viewFrame) * 0.2);

	for (int i = 0; i < viewCount; i++)
	{
		UIColor *aLayerColor = [UIColor colorWithHue:(float)(i)/viewCount saturation:0.8 brightness:0.8 alpha:0.9];
		
		UIView* aView = [[UIView alloc] init];
		aView.layer.backgroundColor = aLayerColor.CGColor;
		aView.layer.cornerRadius = 2.0f;
		aView.frame = subViewFrame;
		aView.center = CGPointMake(CGRectGetMidX(viewFrame) -100+20*i, CGRectGetMidY(viewFrame) -100+20*i);
		aView.center = CGPointMake(CGRectGetMidX(viewFrame), CGRectGetMidY(viewFrame));

		[self addSubview:aView];
		[self.views addObject:aView];
		[self registerEffectForView:aView atIndex:i];
	}
}


- (void) registerEffectForView:(UIView *)aView atIndex:(NSInteger)index;
{
	UIInterpolatingMotionEffect *xEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
																						   type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
	UIInterpolatingMotionEffect *yEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
																						   type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
	
	// the ground layer should not move and rest in the superview's plane, its height is 0, negative values are behind, positive in the front
	float viewHeight = (index - (viewCount-groundViewIndex));
	float amplitude = viewHeight * 200;
	
	xEffect.maximumRelativeValue = @(amplitude);
	xEffect.minimumRelativeValue = @(-amplitude);
	yEffect.maximumRelativeValue = @(amplitude);
	yEffect.minimumRelativeValue = @(-amplitude);
	
	[aView addMotionEffect:xEffect];
	[aView addMotionEffect:yEffect];
}


@end


