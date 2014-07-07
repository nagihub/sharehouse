#import "FirstViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.scrollView.contentSize = CGSizeMake(320, 1000);
    
}


/*
- (IBAction)naverbutton:(UIButton *)sender {
    self.tabBarController.selectedIndex = 1;
}

- (IBAction)togetterbutton:(UIButton *)sender {
    self.tabBarController.selectedIndex = 2;
}

- (IBAction)itaibutton:(UIButton *)sender {
    self.tabBarController.selectedIndex = 3;
}
 */



@end
