#import "ModalViewController1.h"

@interface ModalViewController1 ()

@end

@implementation ModalViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
