//
//  PHToolCell.m
//  MovingHouse
//
//  Created by Nick Lee on 4/1/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import "PHToolCell.h"

@interface PHToolCell ()

@end

@implementation PHToolCell

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (StrikeThroughLabel*)strLBTaksName
{
    if (!_strLBTaksName) {
        CGRect frame = CGRectMake(53, 6, 227, 38);
        _strLBTaksName = [[StrikeThroughLabel alloc] initWithFrame:frame];
        
        _strLBTaksName.backgroundColor  = [UIColor clearColor];
        _strLBTaksName.font             = [UIFont systemFontOfSize:13.0];
        _strLBTaksName.numberOfLines    = 1;
        
        [self addSubview:_strLBTaksName];
    }
    
    return _strLBTaksName;
}

@end
