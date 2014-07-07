//
//  PickerSheet.h
//  PickerSheet
//
//  Created by Mobioneer HV 04 on 10/12/12.
//  Copyright (c) 2012 Mobioneer Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerSheet;

@protocol PickerSheetDelegate <UIActionSheetDelegate>
- (void)pickerSheet:(PickerSheet *)pickerSheet dismissWithDone:(BOOL)done;
@end

@interface PickerSheet : UIActionSheet

@property (nonatomic, weak) id <PickerSheetDelegate> delegate;
@property (nonatomic, readonly) UINavigationBar *navigationBar;
@property (nonatomic, readonly) UIPickerView *picker;

- (void)show;

@end


