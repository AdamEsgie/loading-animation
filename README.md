loading-animation
=================

Cocoa Library that allows one to easily add a loading animation to a project.

The animation consists of three circles growing and shrinking in succession.

The library allows for customization of the size, color, speed of the animation/circles.

For use:

1) Download or clone the repo
2) Add the LoadAnimationLibrary folder to your project
3) Initialize the object and set the circle size
    Example: LoadingView *loading = [[LoadingView alloc] initWithCircleSize:6.0f];
4) Add the object to a view in the desired position
    Example: [loading showInView:self.view withOrigin:CGPointZero];
5) When ready, begin animation
    Example: [loading startAnimating];
    
