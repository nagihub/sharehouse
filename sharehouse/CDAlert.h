//
//  CDAlert.h
//  MovingHouse
//
//  Created by Nick Lee on 4/9/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDAlert : NSManagedObject

@property (nonatomic) BOOL canDel;
@property (nonatomic, retain) NSString * content;
@property (nonatomic) NSTimeInterval created;
@property (nonatomic) NSTimeInterval dateAlert;
@property (nonatomic) NSTimeInterval dateTime;
@property (nonatomic) BOOL isAlertOn;
@property (nonatomic) BOOL isCheck;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int16_t typeDateAlert;

@end
