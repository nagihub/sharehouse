//
//  PHAlertVC.h
//  MovingHouse
//
//  Created by Nick Lee on 4/2/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"

@protocol PHAlertVCDelegate <NSObject>



- (void)didChangeAlertWithString:(NSString*)str;
- (void)didChangeAlertWithString:(NSString*)str AlerType:(AlertType)type timeInterval:(NSTimeInterval)timeInterval alertOn:(BOOL)alertOn;

@end

@interface PHAlertVC : UIViewController

@property(nonatomic,strong) NSString *lastChangeAlertTime;
@property(nonatomic) AlertType lastAletType;
@property(nonatomic) NSTimeInterval lastTimeInterval;
@property(nonatomic) NSDate *dateTime;
@property(nonatomic) BOOL alertOn;

@property(nonatomic,weak) id<PHAlertVCDelegate> delegate;

- (void)loadAlertInfoWith:(AlertType)alertType dateTime:(NSDate*)dateTime dateAlert:(NSDate*)dateAlert alertOn:(BOOL)alertOn;

@end
