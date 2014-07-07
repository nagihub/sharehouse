//
//  LoadingView.m
//  LNF
//
//  Created by Martin Nguyen on 2/9/12.
//  Copyright (c) 2012 Hirevietnamese Ltd. All rights reserved.
//

#import "LoadingView.h"
#import "Common.h"
#import "Define.h"

@interface LoadingView()
-(void)hideTimeout;
@end

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.0f;
        
        UIView *mark = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
        mark.backgroundColor = [UIColor blackColor];
        mark.alpha = 0.5f;
        [self addSubview:mark];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(frame.size.width/2.0f-10.0f, frame.size.height/2.0f-10.0f, 20.0f, 20.0f)];
        _indicatorView.backgroundColor = [UIColor clearColor];
        _indicatorView.hidesWhenStopped = YES;
        [self addSubview:_indicatorView];
        
        
    }
    return self;
}

- (id)initSendingWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.0f;
        
        UIView *mark = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
        mark.backgroundColor = [UIColor blackColor];
        mark.alpha = 0.7f;
        [self addSubview:mark];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(117.0f, frame.size.height/2.0f-10.0f, 20.0f, 20.0f)];
        _indicatorView.backgroundColor = [UIColor clearColor];
        //_indicatorView.color = [UIColor colorWithWhite:0.15f alpha:1.0f];
        _indicatorView.hidesWhenStopped = YES;
        [self addSubview:_indicatorView];
        
        
        
        UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(145.0f, frame.size.height/2.0f-10.0f, 70.0f, 20.0f)];
        loadingLabel.backgroundColor = [UIColor clearColor];
        loadingLabel.textColor = [UIColor whiteColor];
        loadingLabel.shadowColor = [UIColor blackColor];
        loadingLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        loadingLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        loadingLabel.text = @"Sending...";
        [self addSubview:loadingLabel];
    }
    return self;
}


#pragma mark - Other

- (void)show
{
    
    [_indicatorView startAnimating];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0f;
    }];
}

- (void)hide
{
    [_indicatorView stopAnimating];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0f;
    }];
}

-(void)hideTimeout{
    NSLog(@"Auto hide loading view");
    if (_indicatorView.isAnimating) {
        [self hide];
    }
}

/*
 How to use
 
 _loadingView = [[LoadingView alloc] initWithFrame:self.view.bounds];
 [self.view addSubview:_loadingView];
 
 */

@end
