
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
  self.loading = [[LoadingView alloc] initWithCircleSize:6.0f];
  [self.loading showInView:self.view withOrigin:CGPointMake(CGRectGetWidth(self.view.bounds)/2-12.0f, CGRectGetHeight(self.view.bounds)/2)];
}

- (void)addButtons
{
  UIButton *startButton = [UIButton new];
  startButton.frame = CGRectMake(CGRectGetWidth(self.view.bounds)/2-55, CGRectGetHeight(self.view.bounds)-120, 50, 40);
  [startButton setTitle:@"Start" forState:UIControlStateNormal];
  startButton.titleLabel.textColor = [UIColor whiteColor];
  startButton.backgroundColor = [UIColor lightGrayColor];
  [startButton addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:startButton];
  
  UIButton *stopButton = [UIButton new];
  stopButton.frame = CGRectMake(CGRectGetWidth(self.view.bounds)/2+5, CGRectGetHeight(self.view.bounds)-120, 50, 40);
  [stopButton setTitle:@"Stop" forState:UIControlStateNormal];
  stopButton.titleLabel.textColor = [UIColor whiteColor];
  stopButton.backgroundColor = [UIColor lightGrayColor];
  [stopButton addTarget:self action:@selector(stopAnimation) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:stopButton];
  
  UIButton *opacity = [UIButton new];
  opacity.frame = CGRectMake(CGRectGetWidth(self.view.bounds)/2-30, CGRectGetHeight(self.view.bounds)-70, 50, 40);
  [opacity setTitle:@"Opac" forState:UIControlStateNormal];
  opacity.titleLabel.textColor = [UIColor whiteColor];
  opacity.backgroundColor = [UIColor lightGrayColor];
  [opacity addTarget:self action:@selector(addOpacity) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:opacity];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAnimation
{
  [self.loading startAnimating];
}

- (void)stopAnimation
{
  [self.loading stopAnimating];
}

- (void)addOpacity
{
  [self.loading addStartingOpacity:0.5];
}

@end
