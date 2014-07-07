#import <UIKit/UIKit.h>

@interface FaqViewController: UIViewController<UIWebViewDelegate> {
    IBOutlet UIWebView *webView;
}

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)closeAction;


@end
