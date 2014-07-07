
#import "MainViewController.h"
#import "LoadingView.h"

@interface MainViewController ()

@property (nonatomic, strong) LoadingView *loading;

@end

@implementation MainViewController

- (id)init
{
  self = [super init];
  if (self) {
    self.view.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self addButtons];
  self.loading = [[LoadingView alloc] initWithCircleSize:8.0f];
  [self.loading showInView:self.view withCenterPoint:CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/2)];
}

- (void)addButtons
{
  NSArray *buttonNames = @[@"Start", @"Stop", @"Opacity", @"Reset"];
  for (int i = 0; i < buttonNames.count; i++)
  {
    [self setupButtonWithTitle:buttonNames[i] atIndex:i];
  }
  
}

-(void)setupButtonWithTitle:(NSString *)title atIndex:(NSInteger)index
{
  UIButton *button = [UIButton new];
  [button setTitle:title forState:UIControlStateNormal];
  button.titleLabel.textColor = [UIColor whiteColor];
  button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f];
  button.backgroundColor = [UIColor lightGrayColor];
  
  switch (index) {
    case 0:
      button.frame = CGRectMake(CGRectGetWidth(self.view.bounds)/2-55, CGRectGetHeight(self.view.bounds)-120, 50, 40);
      [button addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
      break;
      
    case 1:
       button.frame = CGRectMake(CGRectGetWidth(self.view.bounds)/2+5, CGRectGetHeight(self.view.bounds)-120, 50, 40);
      [button addTarget:self action:@selector(stopAnimation) forControlEvents:UIControlEventTouchUpInside];
      break;
      
    case 2:
      button.frame = CGRectMake(CGRectGetWidth(self.view.bounds)/2-55, CGRectGetHeight(self.view.bounds)-70, 50, 40);
      [button addTarget:self action:@selector(addOpacity) forControlEvents:UIControlEventTouchUpInside];
      break;
    
    case 3:
      button.frame = CGRectMake(CGRectGetWidth(self.view.bounds)/2+5, CGRectGetHeight(self.view.bounds)-70, 50, 40);
      [button addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
      break;

      
    default:
      break;
  }
  
  [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction Selectors

- (void)startAnimation
{
  [self.loading startLoading];
}

- (void)stopAnimation
{
  [self.loading stopLoading];
}

- (void)addOpacity
{
  [self.loading addStartingOpacity:0.5];
}

- (void)reset
{
  [self.loading stopLoading];
  [self.loading addStartingOpacity:1.0];
}

@end
