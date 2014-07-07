//
//  PickerSheet.m
//  PickerSheet
//
//  Created by Mobioneer HV 04 on 10/12/12.
//  Copyright (c) 2012 Mobioneer Co., Ltd. All rights reserved.
//

#import "PickerSheet.h"

const float PICKER_HEIGHT = 216.0f;
const float NAVI_BAR_HEIGHT = 44.0f;
const float SHEET_HEIGHT = PICKER_HEIGHT + NAVI_BAR_HEIGHT;
const float SHEET_WIDTH = 320.0f;

@implementation PickerSheet

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, SHEET_WIDTH, SHEET_HEIGHT)];
    if (self) {        
        _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SHEET_WIDTH, NAVI_BAR_HEIGHT)];
        _navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
        UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
        UINavigationItem *topItem = [[UINavigationItem alloc] initWithTitle:@"Region"];
        topItem.leftBarButtonItem = cancelButtonItem;
        topItem.rightBarButtonItem = doneButtonItem;
        [_navigationBar pushNavigationItem:topItem animated:NO];
        [self addSubview:_navigationBar];
        
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, NAVI_BAR_HEIGHT, SHEET_WIDTH, PICKER_HEIGHT)];
        _picker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _picker.showsSelectionIndicator = YES;
        [self addSubview:_picker];
    }
    return self;
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [self showInView:window];
    float y = window.bounds.size.height - SHEET_HEIGHT;
    self.frame = CGRectMake(0, y, SHEET_WIDTH, SHEET_HEIGHT);
}


- (void)cancel
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerSheet:dismissWithDone:)]) {
        [self.delegate pickerSheet:self dismissWithDone:NO];
    }
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)done
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerSheet:dismissWithDone:)]) {
        [self.delegate pickerSheet:self dismissWithDone:YES];
    }
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

@end
