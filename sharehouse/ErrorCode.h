//
//  ErrorCode.h
//  Mopique
//
//  Created by Linh NGUYEN on 7/22/11.
//  Copyright 2011 Hirevietnamese Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorCode : NSObject {
}

@property (nonatomic, assign)   NSInteger    errorID;
@property (nonatomic, copy)     NSString    *errorMsg;

@end

