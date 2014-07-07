//
//  AppItem.h
//  MovingHouse
//
//  Created by Nick Lee on 4/12/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppItem : NSObject

@property(nonatomic,strong) NSString *adId;
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *createDate;
@property(nonatomic,strong) NSString *appliName;
@property(nonatomic,strong) NSString *publisher;
@property(nonatomic,strong) NSString *scheme;
@property(nonatomic,strong) NSString *yen;
@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) NSString *iconUrl;
@property(nonatomic,strong) NSString *siteOpen;
@property(nonatomic,strong) NSString *osusume;

@property(nonatomic,strong) UIImage  *imgIcon;

@end
