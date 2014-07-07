
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
@property (nonatomic, strong) NSArray *dots;

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
  self.center = center;
  
  [view addSubview:self];
  
  self.one = [CAShapeLayer layer];
  self.two = [CAShapeLayer layer];
  self.three = [CAShapeLayer layer];
  
  self.dots = @[self.one, self.two, self.three];
  
  [self setupDotsFromArray:self.dots];
}

- (void)hide
{
  self.hidden = YES;
  [self stopAnimating];
}

- (void)startLoading
{
  self.isAnimating = YES;
  self.hidden = NO;
  
  [self createScaleAnimation];
  
  if (self.opacityWasSet == YES) {
    [self createOpacityAnimation];
  }
  
  CFTimeInterval dotOneBeginTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
  CFTimeInterval dotTwoBeginTime = dotOneBeginTime + (self.speed / 3);
  CFTimeInterval dotThreeBeginTime = dotOneBeginTime + ((self.speed / 3) * 2);

  NSArray *times = @[@(dotOneBeginTime), @(dotTwoBeginTime), @(dotThreeBeginTime)];
  
  for (int i = 0; i < times.count; i++)
  {
    self.scaleAnimation.beginTime = [times[i] doubleValue];
    self.opacityAnimation.beginTime = [times[i] doubleValue];
    
    [self.dots[i] addAnimation:self.scaleAnimation forKey:@"scale"];
    if (self.opacityWasSet == YES) {
      [self.dots[i] addAnimation:self.opacityAnimation forKey:@"opacity"];
    }
  };
}

- (void)stopLoading
{
  self.isAnimating = NO;
  [self.one removeAllAnimations];
  [self.two removeAllAnimations];
  [self.three removeAllAnimations];
}

- (void)addStartingOpacity:(float)opacity
{
  self.opacity = opacity;
  
  self.one.opacity = self.opacity;
  self.two.opacity = self.opacity;
  self.three.opacity = self.opacity;
  
  self.opacityWasSet = YES;
}

- (void)createScaleAnimation
{
  self.scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  [self.scaleAnimation setFromValue:[NSNumber numberWithFloat:1.00f]];
  [self.scaleAnimation setToValue:[NSNumber numberWithFloat:1.22f]];
  [self.scaleAnimation setDuration:self.speed];
  [self.scaleAnimation setRemovedOnCompletion:NO];
  [self.scaleAnimation setFillMode:kCAFillModeForwards];
  [self.scaleAnimation setRepeatCount:HUGE_VALF];
  [self.scaleAnimation setAutoreverses:YES];
  [self.scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.5 :0 :.5 :1]];
}

-(void)createOpacityAnimation
{
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

- (void)setupDotsFromArray:(NSArray*)array
{
  [array enumerateObjectsUsingBlock:^(CAShapeLayer *dot, NSUInteger idx, BOOL *stop) {
    
    switch (idx) {
      case 0:
        [dot setFrame:CGRectMake(0, 0, self.circleSize.width, self.circleSize.height)];
        break;
        
      case 1:
        [dot setFrame:CGRectMake((self.circleSize.width + self.spacing), 0, self.circleSize.width, self.circleSize.height)];
        break;
        
      case 2:
        [dot setFrame:CGRectMake((self.circleSize.width + self.spacing) * 2, 0, self.circleSize.width, self.circleSize.height)];
        break;
        
      default:
        break;
    }
    
    [dot setPath:[[UIBezierPath bezierPathWithOvalInRect:dot.bounds] CGPath]];
    dot.fillColor = self.color.CGColor;
    dot.opacity = self.opacity;
    [[self layer] addSublayer:dot];
    
  }];
  
}

@end

