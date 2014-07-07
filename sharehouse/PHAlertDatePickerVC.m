//
//  PHAlertDatePickerVC.m
//  MovingHouse
//
//  Created by Nick Lee on 4/2/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import "PHAlertDatePickerVC.h"

@interface PHAlertDatePickerVC ()
{
    
    __weak IBOutlet UILabel *_lbDate;
}

@end

@implementation PHAlertDatePickerVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Date and Time";
    
    // set date label

    NSDateFormatter * f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"MMMM dd, HH:mm (EEE)"];
    f.locale        = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    _lbDate.text    = [f stringFromDate:[NSDate date]];
    
    // add bar button item
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(saveTimeSelect)];
    self.navigationItem.rightBarButtonItem = save;
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(dimisVC)];
    self.navigationItem.leftBarButtonItem = cancel;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Other

- (void) saveTimeSelect
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) dimisVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
