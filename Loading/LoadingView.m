
#import "LoadingView.h"

@interface LoadingView()

@property (nonatomic, strong) CABasicAnimation *opacityAnimation;
@property (nonatomic, strong) CABasicAnimation *scaleAnimation;
@property (nonatomic, strong) CAShapeLayer *one;
@property (nonatomic, strong) CAShapeLayer *two;
@property (nonatomic, strong) CAShapeLayer *three;
@property CGSize circleSize;
@property CGFloat spacing;
@property BOOL opacityWasSet;
@property float opacity;

@end

@implementation LoadingView

- (id)initWithCircleSize:(float)size
{
  self = [super init];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.circleSize = CGSizeMake(size, size);
    self.spacing = (self.circleSize.width * 1.25 - self.circleSize.width) + 2.0f;
    self.color = [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:204.0f/255.0f alpha:1];
    self.speed = 0.6;
    self.clipsToBounds = NO;
    self.isAnimating = NO;
    self.opacity = 1.0f;
    self.opacityWasSet = NO;
  }
  return self;
}

- (void)layoutSubviews
{
  self.frame = CGRectMake(self.center.x - (self.circleSize.width * 1.5) - self.spacing, self.center.y - (self.circleSize.height / 2), (self.circleSize.width * 3) + (self.spacing * 2), self.circleSize.height);
}

- (void)showInView:(UIView *)view withCenterPoint:(CGPoint)center;
{
  [self removeFromSuperview];
  [self.one removeFromSuperlayer];
  [self.two removeFromSuperlayer];
  [self.three removeFromSuperlayer];
  
  self.hidden = NO;
  self.center = center;
  
  [view addSubview:self];
  
  self.one = [CAShapeLayer layer];
  [self.one setFrame:CGRectMake(0, 0, self.circleSize.width, self.circleSize.height)];
  [self.one setPath:[[UIBezierPath bezierPathWithOvalInRect:self.one.bounds] CGPath]];
  self.one.fillColor = self.color.CGColor;
  self.one.opacity = self.opacity;
  [[self layer] addSublayer:self.one];
  
  self.two = [CAShapeLayer layer];
  [self.two setFrame:CGRectMake((self.circleSize.width + self.spacing), 0, self.circleSize.width, self.circleSize.height)];
  [self.two setPath:[[UIBezierPath bezierPathWithOvalInRect:self.two.bounds] CGPath]];
  self.two.fillColor = self.color.CGColor;
  self.two.opacity = self.opacity;
  [[self layer] addSublayer:self.two];
  
  self.three = [CAShapeLayer layer];
  [self.three setFrame:CGRectMake((self.circleSize.width + self.spacing) * 2, 0, self.circleSize.width, self.circleSize.height)];
  [self.three setPath:[[UIBezierPath bezierPathWithOvalInRect:self.three.bounds] CGPath]];
  self.three.fillColor = self.color.CGColor;
  self.three.opacity = self.opacity;
  [[self layer] addSublayer:self.three];
  
}

- (void)hide
{
  self.hidden = YES;
  [self stopAnimating];
}

- (void)startAnimating
{
  self.isAnimating = YES;
  self.hidden = NO;
  
  self.scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  [self.scaleAnimation setFromValue:[NSNumber numberWithFloat:1.00f]];
  [self.scaleAnimation setToValue:[NSNumber numberWithFloat:1.22f]];
  [self.scaleAnimation setDuration:self.speed];
  [self.scaleAnimation setRemovedOnCompletion:NO];
  [self.scaleAnimation setFillMode:kCAFillModeForwards];
  [self.scaleAnimation setRepeatCount:HUGE_VALF];
  [self.scaleAnimation setAutoreverses:YES];
  [self.scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.5 :0 :.5 :1]];
  
  if (self.opacityWasSet == YES) {
    self.opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [self.opacityAnimation setFromValue:[NSNumber numberWithFloat:self.opacity]];
    [self.opacityAnimation setToValue:[NSNumber numberWithFloat:1.00f]];
    [self.opacityAnimation setDuration:self.speed];
    [self.opacityAnimation setRemovedOnCompletion:NO];
    [self.opacityAnimation setFillMode:kCAFillModeForwards];
    [self.opacityAnimation setRepeatCount:HUGE_VALF];
    [self.opacityAnimation setAutoreverses:YES];
    [self.opacityAnimation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.5 :0 :.5 :1]];
  }
  
  CFTimeInterval dotOneBeginTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
  
  self.scaleAnimation.beginTime = dotOneBeginTime;
  self.opacityAnimation.beginTime = dotOneBeginTime;
  
  [self.one addAnimation:self.scaleAnimation forKey:@"scale"];
  if (self.opacityWasSet == YES) {
    [self.one addAnimation:self.opacityAnimation forKey:@"opacity"];
  }
  
  self.scaleAnimation.beginTime = dotOneBeginTime + (self.speed / 3);
  self.opacityAnimation.beginTime = dotOneBeginTime + (self.speed / 3);
  
  [self.two addAnimation:self.scaleAnimation forKey:@"scale"];
  if (self.opacityWasSet == YES) {
    [self.two addAnimation:self.opacityAnimation forKey:@"opacity"];
  }
  
  self.scaleAnimation.beginTime = dotOneBeginTime + ((self.speed / 3) * 2);
  self.opacityAnimation.beginTime = dotOneBeginTime + ((self.speed / 3) * 2);
  
  [self.three addAnimation:self.scaleAnimation forKey:@"scale"];
  if (self.opacityWasSet == YES) {
    [self.three addAnimation:self.opacityAnimation forKey:@"opacity"];
  }
  
}

- (void)stopAnimating
{
  self.isAnimating = NO;
  [self.one removeAllAnimations];
  [self.two removeAllAnimations];
  [self.three removeAllAnimations];
}

- (void)addStartingOpacity:(float)opacity
{
  self.opacity = opacity;
  self.opacityWasSet = YES;
  
  self.one.opacity = self.opacity;
  self.two.opacity = self.opacity;
  self.three.opacity = self.opacity;
}

@end

