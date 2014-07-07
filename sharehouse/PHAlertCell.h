//
//  PHAlertCell.h
//  MovingHouse
//
//  Created by Nick Lee on 4/3/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHAlertCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UILabel *alertText;
@property(nonatomic,weak) IBOutlet UILabel *alertlbTime;
@property(nonatomic,weak) IBOutlet UIImageView *alertImgCheck;

@end
