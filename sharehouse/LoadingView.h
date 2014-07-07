//
//  LoadingView.h
//  LNF
//
//  Created by Martin Nguyen on 2/9/12.
//  Copyright (c) 2012 Hirevietnamese Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
{
    UIActivityIndicatorView *_indicatorView;
}

- (id)initSendingWithFrame:(CGRect)frame;
- (void)show;
- (void)hide;

@end
