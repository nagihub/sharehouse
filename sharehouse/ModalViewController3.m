#import "ModalViewController3.h"

@interface ModalViewController3 ()

@end

@implementation ModalViewController3
@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    webView.delegate = self;
    NSString* urlString = @"http://nagitter.com/sharehouse/c2.html";
    NSURL* c1URL = [NSURL URLWithString: urlString];
    NSURLRequest* myRequest = [NSURLRequest requestWithURL: c1URL];
    [self.webView loadRequest:myRequest];
}

// リンクをクリック時、Safariを起動する為の処理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        NSString* scheme = [[request URL] scheme];
        if([scheme compare:@"about"] == NSOrderedSame) {
            return YES;
        }
        if([scheme compare:@"http"] == NSOrderedSame) {
            [[UIApplication sharedApplication] openURL: [request URL]];
            return NO;
        }
    }
    return YES;
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
