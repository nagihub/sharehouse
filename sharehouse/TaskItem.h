//
//  TaskItem.h
//  MovingHouse
//
//  Created by Nick Lee on 4/2/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskItem : NSObject

@property(nonatomic)        BOOL        isCheck;

@property(nonatomic,strong) NSString    *taskName;
@property(nonatomic,strong) NSString    *taskContent;

@property(nonatomic,strong) NSDate      *taskDate;
@property(nonatomic,strong) NSDate      *taskAlert;

@end
