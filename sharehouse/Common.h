//
//  Common.h
//  HeroPager
//
//  Created by Nick LEE on 2/21/12.
//  Copyright (c) 2012 HireVietnamese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "ImagesCache.h"

@interface Common : NSObject

+ (User *)user;
+ (ImagesCache *)images;

+ (void)showAlert:(NSString *)message;
+ (UIImage *) resizeImage:(UIImage *)orginalImage withSize:(CGSize)size;
+ (BOOL) checkEmailFormat:(NSString *)email;
+ (NSString*) md5: (NSString *)str;
+ (void) setDeviceToken:(NSString*) token;
+ (NSString*) getDeviceToken;
+ (NSString *) getXMLSpecialChars:(NSString *)str;
+ (NSString *) processXMLSpecialChars:(NSString *)str;
+ (NSDate *) convertDateTime:(NSString *)fromUTCDateTime serverTime:(NSString *)strServerTime;
+ (void) playPushSound;
+ (BOOL) validateUrl: (NSString *) url;
+ (UIColor*) getTintColor;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)formatString;
+ (NSString*)trimString:(NSString*)string;
+ (BOOL) isNumeric:(NSString *)s;

+ (NSString*)formatJSONValue:(NSString*)str;
+ (float)formatJSONValueFloat:(NSString*)str;
+ (int)formatJSONValueInt:(NSString*)str;

+(BOOL) checkScreenIPhone5;
+(BOOL) isIOS7;
+(NSString *)extractYoutubeID:(NSString *)youtubeURL;

+ (NSString *)timeAgoFromUnixTime:(double)seconds;

+ (BOOL)isPortrait;

@end
