
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LoadingView : UIImageView

@property (nonatomic, strong) UIColor *color;
@property CGPoint origin;
@property float speed;
@property BOOL isAnimating;

- (id)initWithCircleSize:(float)size;
- (void)showInView:(UIView *)view withOrigin:(CGPoint)origin;
- (void)hide;
- (void)startAnimating;
- (void)stopAnimating;
- (void)addStartingOpacity:(float)opacity;

@end



