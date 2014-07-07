//
//  PHToolCell.h
//  MovingHouse
//
//  Created by Nick Lee on 4/1/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrikeThroughLabel.h"

@interface PHToolCell : UITableViewCell

@property(nonatomic) StrikeThroughLabel *strLBTaksName;
@property(nonatomic,weak) IBOutlet UILabel  *lbTaskName;
@property(nonatomic,weak) IBOutlet UIButton *btCheck;
@property(nonatomic,weak) IBOutlet UIButton *btCheckMask;




@end
