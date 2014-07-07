//
//  PHAlertVC.m
//  MovingHouse
//
//  Created by Nick Lee on 4/2/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import "PHAlertVC.h"
#import "Common.h"
#import "Define.h"
#import "DatePicker.h"

#import "FxNavi.h"
#import "PHAlertDatePickerVC.h"

#import "PHAlertCell.h"

@interface PHAlertVC ()<DatePickerDelegate>
{
    __weak IBOutlet UISwitch *_switchAlert;
    __weak IBOutlet PHAlertCell *_alertCell;
    
    __weak IBOutlet UITableView *_table;
    
    long _indexSelect;
    BOOL _isDisableTable;
    BOOL _isOnWithDonSet;
    
    NSString *_strOtherTime;
}

- (IBAction)changeSwitchAlert:(id)sender;

@end

@implementation PHAlertVC

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
    
    //inputSubViewを実行（背景の設定）
    [self inputSubview];
    
    self.title = TEXT_ALERT_NAVI_TITLE;
    _indexSelect = -1;
    _strOtherTime = TEXT_DONT_SET;
    
    // fix hidden first row for iOS 7
    if ([Common isIOS7]) {
        //CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
        //CGFloat h=MIN(statusBarSize.width, statusBarSize.height);
        //UIEdgeInsets e = UIEdgeInsetsMake(self.navigationController.navigationBar.bounds.size.height + h,
        UIEdgeInsets e = UIEdgeInsetsMake(self.navigationController.navigationBar.bounds.size.height,
                                          0.0f,
                                          0.0f,
                                          0.0f);
        _table.contentInset = e;
    }
    
    // 戻るボタン
    UIButton *btReturn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btReturn setTitle:@"戻る" forState:UIControlStateNormal];
    [btReturn addTarget:self action:@selector(returnVC) forControlEvents:UIControlEventTouchUpInside];
    [btReturn setFrame:CGRectMake(10, 30, 50, 30)];
    [btReturn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btReturn];
    
    // アラートスイッチの設定
    if(_alertOn){
        _switchAlert.on = YES;
    } else {
        _switchAlert.on = NO;
    }
    
    // アラート指定日の設定
    switch (_lastAletType) {
        case 1:
            _indexSelect = 0;
            break;
        case 2:
            _indexSelect = 1;
            break;
        case 3:
            _indexSelect = 2;
            break;
        default:
            break;
    }
    
    //NSLog(@"_isDisableTable : %d", _isDisableTable);
}

//ビュー生成
- (void)inputSubview {
    UIImageView *backImage = [[UIImageView alloc] init];
    backImage.frame = CGRectMake(0, 0, 320, 60);
    backImage.image = [UIImage imageNamed:@"bg_wood.png"];
    [self.view addSubview:backImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)returnVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    _switchAlert = nil;
    [super viewDidUnload];
}

- (void)loadAlertInfoWith:(AlertType)alertType dateTime:(NSDate*)dateTime dateAlert:(NSDate*)dateAlert alertOn:(BOOL)alertOn
{
    _alertOn = alertOn;
    _lastAletType = alertType;
    _dateTime = dateTime;
    _lastTimeInterval = [dateAlert timeIntervalSince1970];
    
    /*
    NSLog(@"_switchAlert : %u", _alertOn);
    NSLog(@"_lastAletType : %u", _lastAletType);
    NSLog(@"_dateTime : %@", _dateTime);
    NSLog(@"_lastTimeInterval : %f", _lastTimeInterval);
     */
    
    switch (alertType) {
        case AlertType1Day:
        {
            _indexSelect = 0;
            _isOnWithDonSet = NO;
            _lastChangeAlertTime = TEXT_ALERT_1DAY_AGO;
            break;
        }
        case AlertType3Day:
        {
            _indexSelect = 1;
            _isOnWithDonSet = NO;
            _lastChangeAlertTime = TEXT_ALERT_3DAY_AGO;
            break;
        }
        case AlertType7Day:
        {
            _indexSelect = 2;
            _isOnWithDonSet = NO;
            _lastChangeAlertTime = TEXT_ALERT_7DAY_AGO;
            break;
        }
        case AlertTypeOther:
        {
            _indexSelect = 3;
            _isOnWithDonSet = NO;
            
            NSDateFormatter * f = [[NSDateFormatter alloc] init];
            [f setDateFormat:@"MMMM d日 (EEE) HH:mm"];
            f.locale        = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
            _strOtherTime    = [f stringFromDate:dateAlert];
            _lastChangeAlertTime = [f stringFromDate:dateAlert];
            
            break;
        }
        case AlertTypeNone:
        {
            
            break;
        }
        case AlertTypeOn:
        {
            _strOtherTime = TEXT_DONT_SET;
            _isOnWithDonSet = YES;
            break;
        }
        case AlertTypeOff:
        {
            _indexSelect = -1;
            _switchAlert.on = NO;
            _isDisableTable = YES;
            _isOnWithDonSet = YES;
            [_table setAllowsSelection:NO];
            _strOtherTime = TEXT_DONT_SET;
            
            break;
        }
        default:
            break;
    }
    
    [_table reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PHAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PHAlertCell"];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"PHAlertCell" owner:self options:nil];
        cell = _alertCell;
        _alertCell = nil;
        
    }
    
    switch (indexPath.row) {
        case 0:
        {
            cell.alertText.text = TEXT_ALERT_1DAY_AGO;
            break;
        }
        case 1:
        {
            cell.alertText.text = TEXT_ALERT_3DAY_AGO;
            break;
        }
        case 2:
        {
            cell.alertText.text = TEXT_ALERT_7DAY_AGO;
            break;
        }
        case 3:
        {
            cell.alertText.text = TEXT_ALERT_OTHER;
            break;
        }
        default:
            break;
    }
    
    if (indexPath.row == _indexSelect && indexPath.row != 3) {
        cell.alertImgCheck.hidden = NO;
    } else {
        cell.alertImgCheck.hidden = YES;
    }
    
    if (indexPath.row == 3) {
        cell.alertlbTime.hidden = NO;
        cell.alertlbTime.text = _strOtherTime;
    } else {
        cell.alertlbTime.hidden = YES;
        cell.alertlbTime.text = TEXT_DONT_SET;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    long oldIndexSelect = -1;

    if (!_isDisableTable) {

        if (_indexSelect != -1) {
            NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:_indexSelect inSection:0];
            PHAlertCell *cellOld = (PHAlertCell*)[tableView cellForRowAtIndexPath:oldIndexPath];
            cellOld.alertImgCheck.hidden = YES;
            oldIndexSelect = _indexSelect;
        }
        
        _indexSelect = indexPath.row;
        PHAlertCell *cell = (PHAlertCell*) [tableView cellForRowAtIndexPath:indexPath];
        
        if (_indexSelect != 3) {
            cell.alertImgCheck.hidden = NO;
        }

        if (_delegate && [_delegate respondsToSelector:@selector(didChangeAlertWithString:)]) {
            switch (indexPath.row) {
                    
                case 0:
                {
                    NSDate *dateAlert = [_dateTime dateByAddingTimeInterval:-(24*60*60)];
                    
                    //NSLog(@"1: time: %f --- alert: %f",_dateTime.timeIntervalSince1970,dateAlert.timeIntervalSince1970);
                    
                    if ([dateAlert timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970]) {
                        [Common showAlert:ERROR_CANNOT_SET_TIME];
                        _indexSelect = oldIndexSelect;
                        cell.alertImgCheck.hidden = YES;
                        if (oldIndexSelect != -1  && oldIndexSelect != 3) {
                            NSIndexPath *oldIndexPath = [NSIndexPath indexPathForItem:oldIndexSelect inSection:0];
                            PHAlertCell *cellOld = (PHAlertCell*)[tableView cellForRowAtIndexPath:oldIndexPath];
                            cellOld.alertImgCheck.hidden = NO;
                        }
                        
                    } else {
                        _lastAletType = AlertType1Day;
                        _lastChangeAlertTime = TEXT_ALERT_1DAY_AGO;
                        _lastTimeInterval = [dateAlert timeIntervalSince1970];
                        [_delegate didChangeAlertWithString:TEXT_ALERT_1DAY_AGO];
                        [_delegate didChangeAlertWithString:TEXT_ALERT_1DAY_AGO AlerType:AlertType1Day timeInterval:_lastTimeInterval alertOn:_switchAlert.on];
                    }
                    
                    break;
                }
                case 1:
                {
                    NSDate *dateAlert = [_dateTime dateByAddingTimeInterval:-(3*24*60*60)];
                    
                    //NSLog(@"3: time: %f --- alert: %f",_dateTime.timeIntervalSince1970,dateAlert.timeIntervalSince1970);
                    
                    if ([dateAlert timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970]) {
                        [Common showAlert:ERROR_CANNOT_SET_TIME];
                        _indexSelect = oldIndexSelect;
                        cell.alertImgCheck.hidden = YES;
                        if (oldIndexSelect != -1  && oldIndexSelect != 3) {
                            NSIndexPath *oldIndexPath = [NSIndexPath indexPathForItem:oldIndexSelect inSection:0];
                            PHAlertCell *cellOld = (PHAlertCell*)[tableView cellForRowAtIndexPath:oldIndexPath];
                            cellOld.alertImgCheck.hidden = NO;
                        }
                    } else {
                        _lastAletType = AlertType3Day;
                        _lastChangeAlertTime = TEXT_ALERT_3DAY_AGO;
                        _lastTimeInterval = [dateAlert timeIntervalSince1970];
                        [_delegate didChangeAlertWithString:TEXT_ALERT_3DAY_AGO];
                        [_delegate didChangeAlertWithString:TEXT_ALERT_3DAY_AGO AlerType:AlertType3Day timeInterval:_lastTimeInterval alertOn:_switchAlert.on];
                    }
                    
                    break;
                }
                case 2:
                {
                    NSDate *dateAlert = [_dateTime dateByAddingTimeInterval:-(7*24*60*60)];
                    
                    //NSLog(@"7: time: %f --- alert: %f",_dateTime.timeIntervalSince1970,dateAlert.timeIntervalSince1970);
                    
                    if ([dateAlert timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970]) {
                        [Common showAlert:ERROR_CANNOT_SET_TIME];
                        _indexSelect = oldIndexSelect;
                        cell.alertImgCheck.hidden = YES;
                        if (oldIndexSelect != -1 && oldIndexSelect != 3) {
                            NSIndexPath *oldIndexPath = [NSIndexPath indexPathForItem:oldIndexSelect inSection:0];
                            PHAlertCell *cellOld = (PHAlertCell*)[tableView cellForRowAtIndexPath:oldIndexPath];
                            cellOld.alertImgCheck.hidden = NO;
                        }
                    } else {
                        _lastAletType = AlertType7Day;
                        _lastChangeAlertTime = TEXT_ALERT_7DAY_AGO;
                        _lastTimeInterval = [dateAlert timeIntervalSince1970];
                        [_delegate didChangeAlertWithString:TEXT_ALERT_7DAY_AGO];
                        [_delegate didChangeAlertWithString:TEXT_ALERT_7DAY_AGO AlerType:AlertType7Day timeInterval:_lastTimeInterval alertOn:_switchAlert.on];
                    }
                    
                    break;
                }
                case 3:
                {
                   

                    if ([_dateTime timeIntervalSince1970] < 0) {
                        [Common showAlert:ERROR_CANNOT_SET_TIME];
                    } else {
                        
                        
                        
                        DatePicker *datePicker = [[DatePicker alloc] init];
                        datePicker.delegate = self;
                        datePicker.picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
                        datePicker.picker.minuteInterval = 1;
                        datePicker.picker.minimumDate = [NSDate date];
                        datePicker.picker.maximumDate = _dateTime;
                        datePicker.picker.date = [NSDate date];
                        [datePicker show];

                    }
                    
                    break;
                }
                default:
                    break;
            }
        }
    } else {
        [Common showAlert:@"アラート設定情報が足りません。期日・アラートの指定状態を確認して下さい。"];
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
        _strOtherTime    = [f stringFromDate:date];
        _lastChangeAlertTime = [f stringFromDate:date];
        
        _lastAletType = AlertTypeOther;
        _lastTimeInterval = [date timeIntervalSince1970];
        
        
        [_delegate didChangeAlertWithString:_strOtherTime];
        [_delegate didChangeAlertWithString:_strOtherTime AlerType:AlertTypeOther timeInterval:_lastTimeInterval alertOn:_switchAlert.on];
        
        
    } else {
        switch (_lastAletType) {
            case AlertType1Day:
            {
                _indexSelect = 0;
                break;
            }
            case AlertType3Day:
            {
                _indexSelect = 1;
                break;
            }
            case AlertType7Day:
            {
                _indexSelect = 2;
                break;
            }
            case AlertTypeOther:
            {
                _indexSelect = 3;
                break;
            }
            default:
            {
                _indexSelect = -1;
                break;
            }
        }
    }
    
    [_table reloadData];
}


#pragma mark - Action

- (IBAction)changeSwitchAlert:(id)sender
{
    if (_switchAlert.on) {
        if (_isOnWithDonSet) {
            [_delegate didChangeAlertWithString:TEXT_DONT_SET];
            [_delegate didChangeAlertWithString:TEXT_DONT_SET AlerType:AlertTypeOn timeInterval:-1 alertOn:_switchAlert.on];
        } else {
            [_delegate didChangeAlertWithString:_lastChangeAlertTime];
            [_delegate didChangeAlertWithString:_lastChangeAlertTime AlerType:_lastAletType timeInterval:_lastTimeInterval alertOn:_switchAlert.on];
        }
        
        _isDisableTable = NO;
        [_table setAllowsSelection:YES];
    } else {
        [_delegate didChangeAlertWithString:TEXT_ALERT_OFF];
        [_delegate didChangeAlertWithString:TEXT_ALERT_OFF AlerType:AlertTypeOff timeInterval:-1 alertOn:_switchAlert.on];
        _isDisableTable = YES;
        [_table setAllowsSelection:NO];
    }
    
    [_table reloadData];
}

@end
