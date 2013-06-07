//
//  TimeLineCell.h
//  TwitterCliant03
//
//  Created by PANCAKE on 13/05/14.
//  Copyright (c) 2013年 PANCAKE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TimeLineCell : UITableViewCell


@property (nonatomic, strong) UIImage *image;
@property (nonatomic) int tweetTextLabelHeight;


@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *tweetTextLabel;
@property (nonatomic, strong) UILabel *nameLabel;






@end
