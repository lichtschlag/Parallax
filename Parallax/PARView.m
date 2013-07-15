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
@property (strong) UIView *topView;

@end


// ===============================================================================================================
@implementation PARView
// ===============================================================================================================

const NSInteger layerCount = 10;


// ---------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Lifecycle
// ---------------------------------------------------------------------------------------------------------------

- (void) didMoveToSuperview
{
	[self buildViews];
	[self registerEffect];
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

	for (int i = 0; i < layerCount; i++)
	{
		UIColor *aLayerColor = [UIColor colorWithHue:(float)(i)/layerCount saturation:0.8 brightness:0.8 alpha:0.9];
		
		UIView* aView = [[UIView alloc] init];
		aView.layer.backgroundColor = aLayerColor.CGColor;
		aView.layer.cornerRadius = 2.0f;
//		aView.frame = CGRectMake(CGRectGetMinX(subViewFrame) -100+20*i, CGRectGetMinY(subViewFrame)-100+20*i, CGRectGetWidth(subViewFrame), CGRectGetHeight(subViewFrame));
		aView.frame = subViewFrame;
		aView.center = CGPointMake(CGRectGetMidX(viewFrame) -100+20*i, CGRectGetMidY(viewFrame) -100+20*i);
		
		[self addSubview:aView];
		[self.views addObject:aView];
	}
	
	self.topView = [self.views lastObject];
}

//- (void) registerEffectForView:(UIView *)aView atIndex:(NSInteger)index;
- (void) registerEffect;
{
	UIInterpolatingMotionEffect *xEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
	UIInterpolatingMotionEffect *yEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
	xEffect.maximumRelativeValue = @(100);
	xEffect.minimumRelativeValue = @(-100);
	yEffect.maximumRelativeValue = @(100);
	yEffect.minimumRelativeValue = @(-100);
	
	[self.topView addMotionEffect:xEffect];
	[self.topView addMotionEffect:yEffect];
}





//- (void) buildLayers
//{
//	self.layers = [NSMutableArray array];
//	
//	for (int i = 0; i < layerCount; i++)
//	{
//		UIColor *aLayerColor = [UIColor colorWithHue:(float)(i)/layerCount saturation:0.8 brightness:0.8 alpha:0.9];
//		CATextLayer* aLayer = [CATextLayer layer];
//		aLayer.backgroundColor = aLayerColor.CGColor;
//		aLayer.cornerRadius = 2.0f;
//		CGRect viewBounds = [self bounds];
//		aLayer.bounds = CGRectInset(viewBounds, CGRectGetWidth(viewBounds) * 0.3, CGRectGetHeight(viewBounds) * 0.2);
//		aLayer.position = CGPointMake(CGRectGetMidX(viewBounds) -10 +20*i, CGRectGetMidY(viewBounds)-10 +20*i);
//		//		aLayer.string = @"WEIRD !";//[@(i) stringValue];
//		//		aLayer.foregroundColor = [UIColor blackColor].CGColor;
//		
//		[self.layer addSublayer:aLayer];
//		[self.layers addObject:aLayer];
//	}
//	
//	self.topLayer = [self.layers lastObject];
//}
//
//
//- (void) registerEffect
//{
//	UIInterpolatingMotionEffect *xEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"topLayer.position.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
//	UIInterpolatingMotionEffect *yEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"topLayer.position.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
//	xEffect.maximumRelativeValue = @(100);
//	xEffect.minimumRelativeValue = @(-100);
//	yEffect.maximumRelativeValue = @(100);
//	yEffect.minimumRelativeValue = @(-100);
//
//	[self addMotionEffect:xEffect];
//	[self addMotionEffect:yEffect];
//}
//
//
//- (void) observeValueForKeyPath:(NSString *)keyPath
//					   ofObject:(id)object
//						 change:(NSDictionary *)change
//						context:(void *)context
//{
//	NSLog(@"%s, path=%@", __PRETTY_FUNCTION__,keyPath);
//
//}



@end
