
#import "LoadingView.h"

@interface LoadingView()

@property (nonatomic, strong) CAShapeLayer *one;
@property (nonatomic, strong) CAShapeLayer *two;
@property (nonatomic, strong) CAShapeLayer *three;
@property CGSize circleSize;
@property CGFloat spacing;

@end

@implementation LoadingView

- (id)initWithCircleSize:(float)size
{
    self = [super init];
    if (self) {
      self.backgroundColor = [UIColor clearColor];
      self.origin = CGPointZero;
      self.circleSize = CGSizeMake(size, size);
      self.spacing = (self.circleSize.width*1.25 - self.circleSize.width)+1.5f;
      self.speed = 0.6;
      self.color = [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:204.0f/255.0f alpha:1];
      self.clipsToBounds = NO;
    }
    return self;
}

- (void)showInView:(UIView *)view withOrigin:(CGPoint)origin;
{
  self.hidden = NO;
  self.origin = origin;
  self.frame = CGRectMake(self.origin.x, self.origin.y, (self.circleSize.width * 3) + (self.spacing * 2), self.circleSize.height);
  [view addSubview:self];
  
  self.one = [CAShapeLayer layer];
  [self.one setFrame:CGRectMake(0, 0, self.circleSize.width, self.circleSize.height)];
  [self.one setPath:[[UIBezierPath bezierPathWithOvalInRect:self.one.bounds] CGPath]];
  self.one.fillColor = self.color.CGColor;
  [[self layer] addSublayer:self.one];
  
  self.two = [CAShapeLayer layer];
  [self.two setFrame:CGRectMake((self.circleSize.width + self.spacing), 0, self.circleSize.width, self.circleSize.height)];
  [self.two setPath:[[UIBezierPath bezierPathWithOvalInRect:self.two.bounds] CGPath]];
  self.two.fillColor = self.color.CGColor;
  [[self layer] addSublayer:self.two];
  
  self.three = [CAShapeLayer layer];
  [self.three setFrame:CGRectMake((self.circleSize.width + self.spacing)*2, 0, self.circleSize.width, self.circleSize.height)];
  [self.three setPath:[[UIBezierPath bezierPathWithOvalInRect:self.three.bounds] CGPath]];
  self.three.fillColor = self.color.CGColor;
  [[self layer] addSublayer:self.three];
  
}

- (void)hide
{
  self.hidden = YES;
}

- (void)startAnimating
{
  self.hidden = NO;
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  [animation setFromValue:[NSNumber numberWithFloat:1.0f]];
  [animation setToValue:[NSNumber numberWithFloat:1.25f]];
  [animation setDuration:self.speed];
  [animation setRemovedOnCompletion:NO];
  [animation setFillMode:kCAFillModeForwards];
  [animation setRepeatCount:HUGE_VALF];
  [animation setAutoreverses:YES];
  [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
  [self.one addAnimation:animation forKey:@"scale"];
  
  double delayOne = self.speed/3;
  dispatch_time_t popTimeOne = dispatch_time(DISPATCH_TIME_NOW, delayOne * NSEC_PER_SEC);
  dispatch_after(popTimeOne, dispatch_get_main_queue(), ^(void){
    [self.two addAnimation:animation forKey:@"scale"];
  });
  
  double delayTwo = (self.speed/3)*2.0;
  dispatch_time_t popTimeTwo = dispatch_time(DISPATCH_TIME_NOW, delayTwo * NSEC_PER_SEC);
  dispatch_after(popTimeTwo, dispatch_get_main_queue(), ^(void){
    [self.three addAnimation:animation forKey:@"scale"];
  });
  
}

- (void)stopAnimating
{
  [self.one removeAllAnimations];
  [self.two removeAllAnimations];
  [self.three removeAllAnimations];
}


@end
