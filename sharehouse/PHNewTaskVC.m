//
//  PHNewTaskVC.m
//  MovingHouse
//
//  Created by Nick Lee on 4/2/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import "PHNewTaskVC.h"
#import "Common.h"
#import "Define.h"
#import "AppDelegate.h"

#import "DatePicker.h"

#import "PHAlertVC.h"

@interface PHNewTaskVC ()<UITextFieldDelegate,UITextViewDelegate,PHAlertVCDelegate,DatePickerDelegate>
{
    
    __weak IBOutlet UIView *viewContainer;
    __weak IBOutlet UITextField *_tfTaskName;
    __weak IBOutlet UITextView *_tvTaskContent;
    __weak IBOutlet UILabel *_lbTaskDate;
    __weak IBOutlet UILabel *_lbTaskAlert;
    __weak IBOutlet UILabel *_lbAlert;
    __weak IBOutlet UILabel *_lbDate;
}
- (IBAction)changeTaskDate:(id)sender;
- (IBAction)changeAlert:(id)sender;
@property (strong, nonatomic) IBOutlet UIView* subView;

@end

@implementation PHNewTaskVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//ビュー生成
- (void)inputSubview {
    
    UIImageView *backImage = [[UIImageView alloc] init];
    backImage.frame = CGRectMake(0, 0, 320, 60);
    backImage.image = [UIImage imageNamed:@"bg_wood.png"];
    [self.view addSubview:backImage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //inputSubViewを実行（背景の設定）
    [self inputSubview];

    // fix hidden first row for iOS 7
    if ([Common isIOS7]) {
        CGRect tmpRect = viewContainer.frame;
        tmpRect.origin.y += 64;
        NSLog(@"%f %f",tmpRect.origin.x, tmpRect.origin.y);
        viewContainer.frame = tmpRect;
    }
    
    //キャンセルボタン
    UIButton *btReturn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btReturn setTitle:@"キャンセル" forState:UIControlStateNormal];
    [btReturn addTarget:self action:@selector(returnVC) forControlEvents:UIControlEventTouchUpInside];
    [btReturn setFrame:CGRectMake(10, 30, 100, 30)];
    [btReturn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btReturn];

    //完了ボタン
    UIButton *done =  [UIButton buttonWithType:UIButtonTypeCustom];
    [done setTitle:@"完了" forState:UIControlStateNormal];
    [done addTarget:self action:@selector(addTaskFinish) forControlEvents:UIControlEventTouchUpInside];
    [done setFrame:CGRectMake(250, 30, 51, 30)];
    [done setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:done];

    // init item
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    _cdAlert = (CDAlert *)[NSEntityDescription insertNewObjectForEntityForName:@"CDAlert" inManagedObjectContext:appDelegate.managedObjectContext];
    
    _cdAlert.canDel = YES;
    _cdAlert.isCheck = NO;
    _cdAlert.name = @"";
    _cdAlert.content = @"";
    _cdAlert.created = [[NSDate date] timeIntervalSince1970];
    _cdAlert.dateTime = -1.0;
    _cdAlert.dateAlert = -1.0;
    _cdAlert.typeDateAlert = AlertTypeOff;
    _cdAlert.isAlertOn = NO;
    
    // FIX NULL FOR IOS6
    _tfTaskName.text = @"";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

#pragma mark - Other

- (void)returnVC
{
//    CGRect newFrame = self.view.frame;
//    newFrame.origin.y = 0;
//    
//    [UIView animateWithDuration:0.3
//                     animations:^{
//                         self.view.frame = newFrame;
//                     }];
    [_tvTaskContent resignFirstResponder];
    [_tfTaskName resignFirstResponder];
    
    [[AppDelegate sharedAppDelegate].managedObjectContext deleteObject:_cdAlert];
    [[AppDelegate sharedAppDelegate] saveContext];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addTaskFinish
{
    BOOL ok = YES;
    
    if ([[Common trimString:_tfTaskName.text] isEqualToString:@""]) {
        ok = NO;
        [Common showAlert:ERROR_TASKNAME_MISS];
    } 
    
    if (ok) {
//        TaskItem *item = [[TaskItem alloc] init];
//        item.taskName = [Common trimString:_tfTaskName.text];
//        item.taskContent = [Common trimString:_tvTaskContent.text];
//        item.taskDate = [NSDate date];
//        
//        [_delegate didFinishAddTast:item];
        // save coredata
        _cdAlert.name = [Common trimString:_tfTaskName.text];
        _cdAlert.content = [Common trimString:_tvTaskContent.text];
        
        [[AppDelegate sharedAppDelegate] saveContext];
        
        CGRect newFrame = self.view.frame;
        newFrame.origin.y = 0;
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.view.frame = newFrame;
                         }];
        [_tvTaskContent resignFirstResponder];
        [_tfTaskName resignFirstResponder];

        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITextViewDelegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = 0;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = newFrame;
                     }];
    [_tvTaskContent resignFirstResponder];
    [_tfTaskName resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    CGRect newFrame = self.view.frame;
//    newFrame.origin.y = -10.0;
//    
//    [UIView animateWithDuration:0.3
//                     animations:^{
//                         self.view.frame = newFrame;
//                     }];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = -100.0;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = newFrame;
                     }];
    return YES;
}

#pragma mark - DatePicker

- (void)datePicker:(DatePicker *)datePicker dismissWithDone:(BOOL)done
{
    if (done) {
        NSDate *date = datePicker.picker.date;
        
        NSDateFormatter * f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"MMMM d日 (EEE) HH:mm"];
        f.locale        = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
        _lbDate.text    = [f stringFromDate:date];
        _cdAlert.dateTime = [date timeIntervalSince1970];
    }
}

#pragma mark - PHAlertVCDelegate

- (void)didChangeAlertWithString:(NSString*)str
{
    _lbAlert.text = str;
}

- (void)didChangeAlertWithString:(NSString*)str AlerType:(AlertType)type timeInterval:(NSTimeInterval)timeInterval alertOn:(BOOL)alertOn
{
    _lbAlert.text = str;
    _cdAlert.typeDateAlert = type;
    _cdAlert.dateAlert = timeInterval;
    _cdAlert.isAlertOn = alertOn;
    
}

#pragma mark - Action

- (IBAction)changeTaskDate:(id)sender {
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = 0;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = newFrame;
                     }];
    [_tvTaskContent resignFirstResponder];
    [_tfTaskName resignFirstResponder];
    
    DatePicker *datePicker = [[DatePicker alloc] init];
    datePicker.delegate = self;
    datePicker.picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    datePicker.picker.minuteInterval = 5;
    datePicker.picker.minimumDate = [NSDate date];
    if (_cdAlert.dateTime > -1) {
        datePicker.picker.date = [NSDate dateWithTimeIntervalSince1970:_cdAlert.dateTime];
    } else {
        datePicker.picker.date = [NSDate date];
    }
    [datePicker show];
}

- (IBAction)changeAlert:(id)sender {
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = 0;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = newFrame;
                     }];
    [_tvTaskContent resignFirstResponder];
    [_tfTaskName resignFirstResponder];
    
    PHAlertVC *alertVC = [[PHAlertVC alloc] initWithNibName:@"PHAlertVC" bundle:nil];
    alertVC.delegate = self;
    [self.navigationController pushViewController:alertVC animated:YES];
    [alertVC loadAlertInfoWith:_cdAlert.typeDateAlert
                      dateTime:[NSDate dateWithTimeIntervalSince1970:_cdAlert.dateTime]
                     dateAlert:[NSDate dateWithTimeIntervalSince1970:_cdAlert.dateAlert]
                       alertOn:_cdAlert.isAlertOn];
}
@end
