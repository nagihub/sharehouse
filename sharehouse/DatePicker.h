//
//  DatePicker.h
//  DatePicker
//
//  Created by Martin on 2/26/13.
//  Copyright (c) 2013 Mobioneer Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatePicker;

@protocol DatePickerDelegate <UIActionSheetDelegate>
@required
- (void)datePicker:(DatePicker *)datePicker dismissWithDone:(BOOL)done;
@end

@interface DatePicker : UIActionSheet

@property (nonatomic, weak) id <DatePickerDelegate> delegate;
@property (nonatomic, readonly) UINavigationBar *navigationBar;
@property (nonatomic, readonly) UIDatePicker *picker;

- (void)show;

@end


