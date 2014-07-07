//
//  ImagesCache.m
//  Vixlet
//
//  Created by Nick LE on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImagesCache.h"

#define MAX_IMAGE_CACHE 100

@implementation ImagesCache

@synthesize keyImage = _keyImage;
@synthesize dataImage = _dataImage;

- (id)init
{
    self = [super init];
    if (self) {
        _keyImage = [[NSMutableArray alloc] init];
        _dataImage = [[NSMutableArray alloc] init];
    }
    return self;
}


- (int) indexImageCache:(NSString*) keyImage{
    int temp = -1;
    for (int i = 0; i < [_keyImage count]; i++) {
        if ([keyImage isEqualToString:[_keyImage objectAtIndex:i]]) {
            temp = i;
            break;
        }
    }
    return temp;
}

- (void) addImageDataWithKey:(NSString*)keyImage image:(NSMutableData*)data{
//    int indexTemp = [self indexImageCache:keyImage];
//    if (indexTemp != -1) {
//        [self.keyImage removeObjectAtIndex:indexTemp];
//        [self.dataImage removeObjectAtIndex:indexTemp];
//    }
    
    if ([_keyImage count] >= MAX_IMAGE_CACHE) {
        [self.keyImage removeAllObjects];
        [self.dataImage removeAllObjects];
        
//        self.keyImage = nil;
//        self.dataImage= nil;
//        
//        _keyImage = [[NSMutableArray alloc] init];
//        _dataImage = [[NSMutableArray alloc] init];
    }
    
    [self.keyImage addObject:keyImage];
    [self.dataImage addObject:data];
}

- (NSMutableData*) getImageDataForKey:(NSString*)keyImage{
    int tempIndex = [self indexImageCache:keyImage];
    return [_dataImage objectAtIndex:tempIndex];
}

- (BOOL) isExitsKeyImageData:(NSString*)keyImage{
    if ([self indexImageCache:keyImage] != -1) {
        return YES;
    }else {
        return NO;
    }
}

- (void) removeImageDataForKey:(NSString*)keyImage{
    int tempIndex = [self indexImageCache:keyImage];
    if (tempIndex != -1) {
        [self.keyImage removeObjectAtIndex:tempIndex];
        [self.dataImage removeObjectAtIndex:tempIndex];
//        
//        self.keyImage = nil;
//        self.dataImage= nil;
//        
//        _keyImage = [[NSMutableArray alloc] init];
//        _dataImage = [[NSMutableArray alloc] init];
    }
}

- (void) resetCache{
    [self.keyImage removeAllObjects];
    [self.dataImage removeAllObjects];
}

@end
