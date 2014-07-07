#import <UIKit/UIKit.h>

@interface ModalViewController5: UIViewController<UIWebViewDelegate> {
    IBOutlet UIWebView *webView;
}

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)closeAction;


@end
