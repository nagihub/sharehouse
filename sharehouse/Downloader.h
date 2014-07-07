//
//  Downloader.h
//  AsyncTable
//
//  Created by kenji kinukawa on 11/03/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloaderDelegate;

@interface Downloader : NSObject {
    NSMutableData * buffer;
	id <DownloaderDelegate> __weak delegate;
	id identifier;
    id parent;
}

-(bool)get:(NSURL*)url;

@property (nonatomic,weak) id delegate;
@property (nonatomic,strong) NSMutableData * buffer;
@property (nonatomic,strong) id identifier;

@end

@protocol DownloaderDelegate<NSObject>
-(void)downloader:(NSURLConnection *)conn didLoad:(NSMutableData *)data identifier:(id)identifier;
-(void)downloaderFailedIndentifier:(id)indentifier;
@end

