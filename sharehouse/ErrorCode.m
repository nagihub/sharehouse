//
//  ErrorCode.m
//  Mopique
//
//  Created by Linh NGUYEN on 7/22/11.
//  Copyright 2011 Hirevietnamese Ltd. All rights reserved.
//

#import "ErrorCode.h"

@implementation ErrorCode

@synthesize errorID = _errorID;
@synthesize errorMsg = _errorMsg;

- (id)init
{
    self = [super init];
    if (self) {
        _errorID = 0;
        _errorMsg = nil;
    }
    return self;
}


@end
