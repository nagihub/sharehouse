//
//  PHTaskDetailVC.h
//  MovingHouse
//
//  Created by Nick Lee on 4/1/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"
#import "TaskItem.h"
#import "CDAlert.h"

@protocol PHTaskDetailVCDelegate <NSObject>

- (void)didChangeCheckTaskWithIndex:(long)index isCheck:(BOOL)isCheck;
- (void)didDeleteTaskWithIndex:(long)index;

@end

@interface PHTaskDetailVC : UIViewController

@property(nonatomic) long indexTask;
@property(nonatomic) BOOL isCheck;

@property(nonatomic,weak) id<PHTaskDetailVCDelegate> delegate;
@property(nonatomic) TaskItem *taskItem;
@property(nonatomic) CDAlert *cdAlert;

@property (weak, nonatomic) IBOutlet UIButton *btDeleteTask;
@property (weak, nonatomic) IBOutlet UIButton *btCheckTask;
@property (weak, nonatomic) IBOutlet UITextView *tvTaskContent;
@property (weak, nonatomic) IBOutlet UIWebView *webContent;
@property (weak, nonatomic) IBOutlet UILabel    *labelTaskName;
@property (nonatomic,strong) StrikeThroughLabel *lbTaskName;

- (void)loadTaskInfoWithTaskItem:(TaskItem*)taskItem index:(long)index;
- (void)loadTaskInfoWithCdAlertItem:(CDAlert*)taskItem index:(long)index;

@end
