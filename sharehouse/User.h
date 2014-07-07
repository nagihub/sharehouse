//
//  User.h
//  HeroPager
//
//  Created by Nick LEE on 3/1/12.
//  Copyright (c) 2012 HireVietnamese. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic,assign) BOOL isIPhone5Screen;
@property(nonatomic,assign) BOOL isIPhone;


//check ws

//profile
@property(nonatomic,strong) NSString *appID;
@property(nonatomic,strong) NSString *appName;
@property(nonatomic,strong) NSString *appStoreID;


//settings
@property(nonatomic,assign) BOOL isLogin;
@property(nonatomic,assign) BOOL isUpdateLocation;

//site map

@property(nonatomic,strong) NSMutableArray *links;
@property(nonatomic,strong) NSMutableArray *titles;



// method

-(void)login;
-(void)logout;
-(NSString*)getTitleForLink:(NSString*)link;

@end