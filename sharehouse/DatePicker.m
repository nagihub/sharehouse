//
//  DatePicker.m
//  DatePicker
//
//  Created by Martin on 2/26/13.
//  Copyright (c) 2013 Mobioneer Co., Ltd. All rights reserved.
//

#import "DatePicker.h"
#import "TextDefine.h"

const float _PICKER_HEIGHT = 216.0f;
const float _NAVI_BAR_HEIGHT = 44.0f;
const float _SHEET_HEIGHT = _PICKER_HEIGHT + _NAVI_BAR_HEIGHT;
const float _SHEET_WIDTH = 320.0f;

@implementation DatePicker

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, _SHEET_WIDTH, _SHEET_HEIGHT)];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, _SHEET_WIDTH, _NAVI_BAR_HEIGHT)];
        _navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        
        // add bar button
        
        UIButton *done =  [UIButton buttonWithType:UIButtonTypeCustom];
        //[done setImage:[UIImage imageNamed:@"12-btnFinish.png"] forState:UIControlStateNormal];
        [done setTitle:@"完了" forState:UIControlStateNormal];
        [done addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        [done setFrame:CGRectMake(0, 0, 48, 31)];
        [done setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithCustomView:done];
        
        UIButton *btReturn =  [UIButton buttonWithType:UIButtonTypeCustom];
        //[btReturn setImage:[UIImage imageNamed:@"12-btn1.png"] forState:UIControlStateNormal];
        [btReturn setTitle:@"中止" forState:UIControlStateNormal];
        [btReturn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [btReturn setFrame:CGRectMake(0, 0, 81, 31)];
        [btReturn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIBarButtonItem *cancelButtonItem= [[UIBarButtonItem alloc] initWithCustomView:btReturn];
        
        
//        UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
//        UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
        
        UINavigationItem *topItem = [[UINavigationItem alloc] initWithTitle:TEXT_TIME];
        
        topItem.leftBarButtonItem = cancelButtonItem;
        topItem.rightBarButtonItem = doneButtonItem;
        [_navigationBar pushNavigationItem:topItem animated:NO];
        [self addSubview:_navigationBar];
        
        _picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, _NAVI_BAR_HEIGHT, _SHEET_WIDTH, _PICKER_HEIGHT)];
        _picker.autoresizingMask = UIViewAutoresizingNone;
        [self addSubview:_picker];
    }
    return self;
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [self showInView:window];
    float y = window.bounds.size.height - _SHEET_HEIGHT;
    self.frame = CGRectMake(0, y, _SHEET_WIDTH, _SHEET_HEIGHT);
}


- (void)cancel
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePicker:dismissWithDone:)]) {
        [self.delegate datePicker:self dismissWithDone:NO];
    }
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)done
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePicker:dismissWithDone:)]) {
        [self.delegate datePicker:self dismissWithDone:YES];
    }
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

@end
