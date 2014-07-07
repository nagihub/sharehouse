#import <UIKit/UIKit.h>

@interface OtherViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *varsion_label;
@property (weak, nonatomic) IBOutlet UIButton *review_button;
- (IBAction)clickReview;

@end
