//
//  PHTaskDetailVC.m
//  MovingHouse
//
//  Created by Nick Lee on 4/1/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import "PHTaskDetailVC.h"
#import "Common.h"
#import "Define.h"
#import "AppDelegate.h"

#import "DatePicker.h"

#import "PHAlertVC.h"

@interface PHTaskDetailVC ()<DatePickerDelegate,PHAlertVCDelegate,UIWebViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
    
    __weak IBOutlet UILabel *_lbDate;
    __weak IBOutlet UILabel *_lbAlert;
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UITextField *_tfTaskName;
    __weak IBOutlet UIButton *btOpenAleart;
    __weak IBOutlet UIButton *btOpenTime;
}

- (IBAction)changeDate:(id)sender;
- (IBAction)changeAlert:(id)sender;
- (IBAction)checkTask:(id)sender;
- (IBAction)deleteTask:(id)sender;


@end

@implementation PHTaskDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //inputSubViewを実行（背景の設定）
    [self inputSubview];

    // disable webview content
    [[_webContent scrollView] setBounces: NO];
    [[_webContent scrollView] setScrollEnabled: NO];

    _scrollView.frame = self.view.frame;
    
    if ([Common isIOS7]) {
     
        CGRect tmpRect = _scrollView.frame;
        tmpRect.origin.y += 44;
        NSLog(@"%f %f",tmpRect.origin.x, tmpRect.origin.y);
        _scrollView.frame = tmpRect;
    }
    
    // 戻るボタン
    UIButton *btReturn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btReturn setTitle:@"戻る" forState:UIControlStateNormal];
    [btReturn addTarget:self action:@selector(returnVC) forControlEvents:UIControlEventTouchUpInside];
    [btReturn setFrame:CGRectMake(10, 30, 50, 30)];
    [btReturn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btReturn];
    
    // add label task name
//    CGRect frame = CGRectMake(-530, 30, 247, 21);
//    _lbTaskName = [[StrikeThroughLabel alloc] initWithFrame:frame];
//    [self.view addSubview:_lbTaskName];
    
    // set tag
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(handleSingleTap:)];
    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    
    [_scrollView addGestureRecognizer:singleTapGestureRecognizer];
    
    //
    [self loadTaskInfoWithCdAlertItem:_cdAlert index:_indexTask];
}

//ビュー生成
- (void)inputSubview {
    UIImageView *backImage = [[UIImageView alloc] init];
    backImage.frame = CGRectMake(0, 0, 320, 60);
    backImage.image = [UIImage imageNamed:@"bg_wood.png"];
    [self.view addSubview:backImage];
}

- (void)returnVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Other

- (void)loadTaskInfoWithTaskItem:(TaskItem*)taskItem index:(long)index
{
    _taskItem                           = taskItem;
    _indexTask                          = index;
    _isCheck                            = taskItem.isCheck;
    _labelTaskName.text                 = taskItem.taskName;
    _lbTaskName.text                    = taskItem.taskName;
    _lbTaskName.strikeThroughEnabled    = taskItem.isCheck;
    _tvTaskContent.text                 = taskItem.taskContent;
    
    NSDateFormatter * f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"MMMM d日 (EEE) HH:mm"];
    f.locale        = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    _lbDate.text    = [f stringFromDate:taskItem.taskDate];
    
    if (taskItem.isCheck) {
        [_btCheckTask setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    } else {
        [_btCheckTask setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    
    if (index > 3) {
        _btDeleteTask.hidden = NO;
    } else {
        _btDeleteTask.hidden = YES;
    }
}

- (void)loadTaskInfoWithCdAlertItem:(CDAlert*)taskItem index:(long)index
{
    NSLog(@"aaaaa : %d", _cdAlert.isAlertOn);
    _cdAlert                            = taskItem;
    _indexTask                          = index;
    _isCheck                            = taskItem.isCheck;
    
    _labelTaskName.text                 = _cdAlert.name;
    _lbTaskName.text                    = _cdAlert.name;
    _lbTaskName.strikeThroughEnabled    = _cdAlert.isCheck;
    
    _tvTaskContent.text                 = _cdAlert.content;
    _tfTaskName.text                    = _cdAlert.name;
    
    //load html content task
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"arrow_task"  ofType:@"png"];
    NSString *filePath = [NSString stringWithFormat:@"file://%@",imagePath];
    NSString *strHtml = [_cdAlert.content stringByReplacingOccurrencesOfString:@"arrow_task.png" withString:filePath];
    NSString *script = @"<script>window.onload = function() {window.location.href = \"ready://\" + document.body.offsetHeight;}</script>";
    
    strHtml = [strHtml stringByAppendingString:script];

    [_webContent loadHTMLString:strHtml baseURL:nil];

    if (_cdAlert.dateTime > -1) {
        NSDateFormatter * f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"MMMM d日 (EEE) HH:mm"];
        f.locale        = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
        _lbDate.text    = [f stringFromDate:[NSDate dateWithTimeIntervalSince1970:_cdAlert.dateTime]];
    } else {
        _lbDate.text   = TEXT_DONT_SET;
    }
    
    switch (_cdAlert.typeDateAlert) {
        case AlertTypeNone:
        {
            _lbAlert.text = TEXT_DONT_SET;
            break;
        }
        case AlertType1Day:
        {
            _lbAlert.text = TEXT_ALERT_1DAY_AGO;
            break;
        }
        case AlertType3Day:
        {
            _lbAlert.text = TEXT_ALERT_3DAY_AGO;
            break;
        }
        case AlertType7Day:
        {
            _lbAlert.text = TEXT_ALERT_7DAY_AGO;
            break;
        }
        case AlertTypeOther:
        {
            NSDateFormatter * f = [[NSDateFormatter alloc] init];
            [f setDateFormat:@"MMMM d日 (EEE) HH:mm"];
            f.locale        = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
            _lbAlert.text    = [f stringFromDate:[NSDate dateWithTimeIntervalSince1970:_cdAlert.dateAlert]];
            break;
        }
        case AlertTypeOff:
        {
            _lbAlert.text = TEXT_ALERT_OFF;
            break;
        }
        case AlertTypeOn:
        {
            _lbAlert.text = TEXT_DONT_SET;
            break;
        }
        default:
            break;
    }
    
    if (taskItem.isCheck) {
        [_btCheckTask setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    } else {
        [_btCheckTask setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    
    _btDeleteTask.hidden = !_cdAlert.canDel;
    
    if (_cdAlert.canDel) {
        _lbTaskName.hidden      = YES;
        _labelTaskName.hidden   = YES;
        _webContent.hidden      = YES;
        
        _tfTaskName.hidden      = NO;
        _tvTaskContent.hidden   = NO;
        
        //add bar button item
        UIButton *done =  [UIButton buttonWithType:UIButtonTypeCustom];
        //[done setImage:[UIImage imageNamed:@"12-btnFinish.png"] forState:UIControlStateNormal];
        [done setTitle:@"完了" forState:UIControlStateNormal];
        [done addTarget:self action:@selector(doneEditTask) forControlEvents:UIControlEventTouchUpInside];
        [done setFrame:CGRectMake(0, 0, 48, 31)];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:done];
    } else {
        _lbTaskName.hidden      = NO;
        _labelTaskName.hidden   = NO;
        _webContent.hidden      = NO;
        
        _tfTaskName.hidden      = YES;
        _tvTaskContent.hidden   = YES;
    }
    
//    if (index > 29) {
//        _btDeleteTask.hidden = NO;
//    } else {
//        _btDeleteTask.hidden = YES;
//    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    if ([_btDeleteTask pointInside:[recognizer locationInView:_btDeleteTask] withEvent:nil]) {
        [_delegate didDeleteTaskWithIndex:_indexTask];
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([btOpenTime pointInside:[recognizer locationInView:btOpenTime] withEvent:nil]) {
        [self changeDate:btOpenTime];
    } else if ([btOpenAleart pointInside:[recognizer locationInView:btOpenAleart] withEvent:nil]) {
        [self changeAlert:btOpenAleart];
    }
    
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = 0;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = newFrame;
                     }];
    [_tvTaskContent resignFirstResponder];
    [_tfTaskName resignFirstResponder];
}

- (void)doneEditTask
{
    BOOL ok = YES;
    
    if ([[Common trimString:_tfTaskName.text] isEqualToString:@""]) {
        ok = NO;
        [Common showAlert:ERROR_TASKNAME_MISS];
    }
    
    if (ok) {
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
        [[AppDelegate sharedAppDelegate] saveContext];
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
    
    [[AppDelegate sharedAppDelegate] saveContext];
}

#pragma mark - Action

- (IBAction)changeDate:(id)sender {
    
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

- (IBAction)checkTask:(id)sender {
    _isCheck = !_isCheck;
    
    _taskItem.isCheck                   = _isCheck;
    _lbTaskName.strikeThroughEnabled    = _isCheck;
    
    if (_isCheck) {
        [_btCheckTask setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    } else {
        [_btCheckTask setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    
    [_delegate didChangeCheckTaskWithIndex:_indexTask isCheck:_isCheck];
}

- (IBAction)deleteTask:(id)sender {
    [_delegate didDeleteTaskWithIndex:_indexTask];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    [self setWebContent:nil];
    _tfTaskName = nil;
    btOpenAleart = nil;
    btOpenTime = nil;
    [super viewDidUnload];
}



#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        if ([[UIApplication sharedApplication] canOpenURL:request.URL]) {
            [[UIApplication sharedApplication] openURL:request.URL];
        }
        return NO;
    }
    
    // http://stackoverflow.com/questions/6440448/ios-uiwebview-inside-a-uiscrollview
    // fix webview inside scrollview
    if (![Common checkScreenIPhone5]) {
        NSURL *url = [request URL];
        
        if ([[url scheme] isEqualToString:@"ready"]) {
            float contentHeight = [[url host] floatValue] + 20;
            NSLog(@" height: %f", contentHeight);
            _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, contentHeight - _webContent.frame.origin.y + _scrollView.frame.size.height );
            CGRect fr = _webContent.frame;
            fr.size = CGSizeMake(_webContent.frame.size.width, contentHeight);
            _webContent.frame = fr;
            NSLog(@"test");
            return NO;
        }
    }
    
    return YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
   
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     
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
    newFrame.origin.y = -105.0;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = newFrame;
                     }];
    return YES;
}


@end








