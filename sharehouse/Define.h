//
//  Define.h
//  Saverpassport
//
//  Created by Nick LE on 10/9/12.
//  Copyright (c) 2012 Nick LE. All rights reserved.
//

#import "TextDefine.h"

#ifndef Saverpassport_Define_h
#define Saverpassport_Define_h

#define APP_NAME                @"SHARE HOUSE Navi"
#define WEBSERVICE_URL          @""
#define IMAGE_URL               @"http://"

typedef enum{
    AlertTypeNone  = 0,
    AlertType1Day  = 1,
    AlertType3Day  = 2,
    AlertType7Day  = 3,
    AlertTypeOther = 4,
    AlertTypeOn    = 5,
    AlertTypeOff   = 6
} AlertType ;

//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


 //URL japan
#define BASE_URL            @"http://nagitter.com/hikkoshi/iphone/"
#define BASE_IPAD_URL       @"http://nagitter.com/hikkoshi/ipad/"

//ERROR
#define ERROR_LOGIN             @"Wrong Heroname or Password!"
#define EROOR_MISS_USERNAME     @"User name is empty."
#define ERROR_EMAIL_FORMAT      @"Your email is invalid."
#define ERROR_NAME_FORMAT       @"User name is from 3 to 12 characters."
#define ERROR_MISS_PASSWORD     @"Password is empty."
#define ERROR_MISS_NEW_PASSWORD     @"New password is empty."
#define ERROR_MISS_CURRRENT_PASSWORD     @"Current password is empty."
#define ERROR_CONFIRM           @"Confirm password does not match."
#define NO_SETUP_EMAIL          @"Please set up a Mail account in order to send email."

#define ERROR_TASKNAME_MISS     @"タスク名を入力してください。"
#define ERROR_CANNOT_SET_TIME   @"期日が設定されていないか、期日を超える指定です。アラートの設定ができません。"
#define ERROR_TASKCONTENT_MISS  @"Task content is empty"

#define OPEN_LOCATION_SETTING   @"This feature requires location authorization. Please go to Settings>General>Location Services and enable access for Geofense."

#endif
