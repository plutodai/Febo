//
//  HomeTableViewCell.h
//  Febo
//
//  Created by YY on 14-10-22.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end
