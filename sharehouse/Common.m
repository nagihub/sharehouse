//
//  Common.m
//  HeroPager
//
//  Created by Nick LEE on 2/21/12.
//  Copyright (c) 2012 HireVietnamese. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <AudioToolbox/AudioServices.h>

#import "Common.h"
#import "Define.h"

@implementation Common

static User *user = nil;
static ImagesCache *images = nil;

+ (User *)user
{
    if (user == nil)
        user = [[User alloc] init];
    return user;
}

+ (ImagesCache *)images
{
    if (images == nil)
        images = [[ImagesCache alloc] init];
    return images;
}

+ (void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[Common user].appName message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

+ (UIImage *) resizeImage:(UIImage *)orginalImage withSize:(CGSize)size
{  CGFloat actualHeight = orginalImage.size.height;
    CGFloat actualWidth = orginalImage.size.width;
    NSLog(@"Origin size %f %f",actualWidth,actualHeight);
    
    if(actualWidth <= size.width || actualHeight <= size.height)
    {
        return orginalImage;
    }
    else
    {
        if((actualWidth/actualHeight)<(size.width/size.height))
        {
            actualHeight=actualHeight*(size.width/actualWidth);
            actualWidth=size.width;
            
        }else
        {
            actualWidth=actualWidth*(size.height/actualHeight);
            actualHeight=size.height;
        }
    }
    
    NSLog(@"Upkload size %f %f",actualWidth,actualHeight);
    CGRect rect = CGRectMake(0.0,0.0,actualWidth,actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [orginalImage drawInRect:rect];
    orginalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return orginalImage;
}

+ (BOOL) checkEmailFormat:(NSString *)email
{
    NSString *emailRegEx =
    @"(?:[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[A-Za-z0-9](?:[a-"
    @"z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[A-Za-z0-9-]*[A-Za-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:email];
    NSLog(@"check email result %i",myStringMatchesRegEx);
    return myStringMatchesRegEx;
}

+ (NSString*) md5: (NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString  stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4],
            result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12],
            result[13], result[14], result[15]
            ];
}


+ (void) setDeviceToken:(NSString*) token
{        
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:token forKey:@"DEVICE_TOKEN"];
    [prefs synchronize];
}

+ (NSString*) getDeviceToken
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *deviceToken = [prefs stringForKey:@"DEVICE_TOKEN"];
    if (deviceToken == NULL) {
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        deviceToken  = [Common md5:[dateFormat stringFromDate:today]];
        deviceToken = [NSString stringWithFormat:@"%@%@",deviceToken,deviceToken];
    }else{
        NSLog(@"device token : %@",deviceToken);
    }
    return deviceToken;            
}

+ (NSString *) getXMLSpecialChars:(NSString *)str
{ 
    NSString * tempStr = [str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    return tempStr;
}

+ (NSString *) processXMLSpecialChars:(NSString *)str
{ 
    NSString * tempStr = [str stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
    return tempStr;
}

+ (NSDate *) convertDateTime:(NSString *)fromUTCDateTime serverTime:(NSString *)strServerTime{ 
    NSDateFormatter *srcDateFormatter = [[NSDateFormatter alloc] init];
    [srcDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [srcDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *serverDate = [srcDateFormatter dateFromString:strServerTime];
    
    
    NSDateFormatter *desDateFormatter = [[NSDateFormatter alloc] init];
    [desDateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [desDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *srcDate = [srcDateFormatter dateFromString:fromUTCDateTime];
    
    
    NSTimeInterval delta = [[NSDate date] timeIntervalSinceDate:serverDate];
    NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT] + delta;
    NSDate *desDate = [NSDate dateWithTimeInterval:timeZoneOffset sinceDate:srcDate];
    NSLog(@"Correct Time%@", desDate);
    
    return desDate;
}

+ (void) playPushSound
{
    SystemSoundID soundID;
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"push" ofType:@"wav"];
    CFURLRef soundUrl = (__bridge CFURLRef) [NSURL fileURLWithPath:soundPath];
    //Use audio sevices to create the sound
    AudioServicesCreateSystemSoundID((CFURLRef)soundUrl, &soundID); 
    //Use audio services to play the sound
    AudioServicesPlaySystemSound(soundID);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //CFRelease(soundUrl);
    
}

+ (BOOL) validateUrl: (NSString *) url {
    NSString *theURL =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", theURL]; 
    return [urlTest evaluateWithObject:url];
}

+ (UIColor*) getTintColor{
    return [UIColor colorWithRed:89.0/255.0 green:7.0/255.0 blue:35.0/255.0 alpha:1.0];
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)formatString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatString;
    return [dateFormatter stringFromDate:date];
}

+ (NSString*)trimString:(NSString*)string
{
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

+ (BOOL) isNumeric:(NSString *)s
{
    NSScanner *sc = [NSScanner scannerWithString: s];
    if ( [sc scanFloat:NULL] )
        {
            return [sc isAtEnd];
        }
    return NO;
}


+ (NSString*)formatJSONValue:(NSString*)str{
    
    NSString *temp = [NSString stringWithFormat:@"%@",str];
    
    if (str!=NULL) {
        if ([temp isEqualToString:@"null"] || 
            [temp isEqualToString:@"<null>"] ||
            [temp isEqualToString:@""]) {
            return @"";
        }else {
            return str;
        }
    }else {
        return @"";
    }
}

+ (int)formatJSONValueInt:(NSString*)str{
    
    NSString *temp = [NSString stringWithFormat:@"%@",str];
    
    if (str!=NULL) {
        if ([temp isEqualToString:@"null"] || 
            [temp isEqualToString:@"<null>"] ||
            [temp isEqualToString:@""]) {
            return 0 ;
        }else {
            return [str intValue];
        }
    }else {
        return 0;
    }
}

+ (float)formatJSONValueFloat:(NSString*)str{
    
    NSString *temp = [NSString stringWithFormat:@"%@",str];
    
    if (str!=NULL) {
        if ([temp isEqualToString:@"null"] || 
            [temp isEqualToString:@"<null>"] ||
            [temp isEqualToString:@""]) {
            return 0 ;
        }else {
            return [str floatValue];
        }
    }else {
        return 0;
    }
}

+(BOOL) checkScreenIPhone5{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        if([UIScreen mainScreen].bounds.size.height == 568.0){
            return YES;
        }
        else{
            return NO;
        }
    }else{
        return NO;
    }
}

+(BOOL) isIOS7{
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        return YES;
    }
    else
        return NO;
}

+ (NSString *)extractYoutubeID:(NSString *)youtubeURL
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"?.*v=(.*)" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:youtubeURL options:0 range:NSMakeRange(0, [youtubeURL length])];
    if(!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0)))
    {
        NSString *substringForFirstMatch = [youtubeURL substringWithRange:rangeOfFirstMatch];
        
        return substringForFirstMatch;
    }
    return nil;
}

+ (NSString *)timeAgoFromUnixTime:(double)seconds
{
    double difference = [[NSDate date] timeIntervalSince1970] - seconds;
    if (difference > 0) {
        NSMutableArray *periods = [NSMutableArray arrayWithObjects:@"second", @"minute", @"hour", @"day", @"week", @"month", @"year", @"decade", nil];
        NSArray *lengths = [NSArray arrayWithObjects:@60, @60, @24, @7, @4.35, @12, @10, nil];
        int j = 0;
        for(j=0; difference >= [[lengths objectAtIndex:j] doubleValue]; j++)
        {
            difference /= [[lengths objectAtIndex:j] doubleValue];
        }
        difference = roundl(difference);
        if(difference != 1)
        {
            [periods insertObject:[[periods objectAtIndex:j] stringByAppendingString:@"s"] atIndex:j];
        }
        return [NSString stringWithFormat:@"%li %@%@", (long)difference, [periods objectAtIndex:j], @" ago"];
    } else {
        return @"N/A";
    }
}

+ (BOOL)isPortrait
{
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationPortrait:
        {
            return YES;
            break;
        }
        case UIInterfaceOrientationLandscapeLeft:
        {
            return NO;
            break;
        }
        case UIInterfaceOrientationLandscapeRight:
        {
            return NO;
            break;
        }
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            return YES;
            break;
        }
        default:
            return NO;
            break;
    }
}

@end
