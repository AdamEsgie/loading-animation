
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LoadingView : UIImageView

@property (nonatomic, strong) UIColor *color;
@property CGFloat speed;
@property BOOL isAnimating;

- (id)initWithCircleSize:(float)size;
- (void)showInView:(UIView *)view withCenterPoint:(CGPoint)center;
- (void)hide;
- (void)startLoading;
- (void)stopLoading;
- (void)addStartingOpacity:(float)opacity;

@end



