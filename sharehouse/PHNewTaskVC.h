//
//  PHNewTaskVC.h
//  MovingHouse
//
//  Created by Nick Lee on 4/2/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskItem.h"
#import "CDAlert.h"

@protocol PHNewTaskVCDelegate <NSObject>
- (void)didFinishAddTast:(TaskItem*)taskItem;

@end

@interface PHNewTaskVC : UIViewController

@property(nonatomic,weak) id<PHNewTaskVCDelegate> delegate;
@property(nonatomic,strong) CDAlert *cdAlert;

@end
