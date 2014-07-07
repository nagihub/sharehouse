//
//  ImagesCache.h
//  Vixlet
//
//  Created by Nick LE on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagesCache : NSObject

@property(nonatomic,copy) NSMutableArray      *keyImage;
@property(nonatomic,copy) NSMutableArray      *dataImage;

- (void) addImageDataWithKey:(NSString*)keyImage image:(NSMutableData*)img;
- (NSMutableData*) getImageDataForKey:(NSString*)keyImage;
- (BOOL) isExitsKeyImageData:(NSString*)keyImage;

- (void) removeImageDataForKey:(NSString*)keyImage;

- (void) resetCache;

@end
