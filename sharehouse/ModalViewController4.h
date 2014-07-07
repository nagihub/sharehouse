#import <UIKit/UIKit.h>

@interface ModalViewController4: UIViewController<UIWebViewDelegate> {
    IBOutlet UIWebView *webView;
}

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)closeAction;


@end
