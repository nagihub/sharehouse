//
//  Error.h
//  LNF
//
//  Created by Martin Nguyen on 2/8/12.
//  Copyright (c) 2012 Hirevietnamese Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Error : NSObject

@property (nonatomic, assign) int error_id;
@property (nonatomic, copy) NSString *error_msg;

+ (Error *)error;

@end
