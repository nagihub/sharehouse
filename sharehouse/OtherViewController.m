#import "OtherViewController.h"

@interface OtherViewController () {
}
@end

@implementation OtherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.navigationItem.title = @"Other";

    self.varsion_label.text = [NSString stringWithFormat:@"ver. %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];




}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// review
- (IBAction)clickReview{
    // レビュー画面の URL
    NSString *reviewUrl;
    
    // iOSのバージョンを判別
    NSString *osversion = [UIDevice currentDevice].systemVersion;
    NSArray *a = [osversion componentsSeparatedByString:@"."];
    BOOL isIOS7 = [(NSString *)[a objectAtIndex:0] intValue] >= 7;
    if (isIOS7) {
        // iOS 7以降
        reviewUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%d", 896300884];
    } else {
        // iOS 7未満
        reviewUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%d&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software", 896300884];
    }
    
    // レビュー画面へ遷移
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewUrl]];
}

@end
