//
//  Error.m
//  LNF
//
//  Created by Martin Nguyen on 2/8/12.
//  Copyright (c) 2012 Hirevietnamese Ltd. All rights reserved.
//

#import "Error.h"

@implementation Error

@synthesize error_id     = _error_id;
@synthesize error_msg    = _error_msg;

- (id)init
{
    self = [super init];
    if (self) {
        self.error_id = 0;
        self.error_msg = @"";
    }
    return self;
}


+ (Error *)error
{
    Error *error = [[Error alloc] init];
    return error;
}

@end
