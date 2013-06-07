//
//  TimeLineCell.m
//  TwitterCliant03
//
//  Created by PANCAKE on 13/05/14.
//  Copyright (c) 2013年 PANCAKE. All rights reserved.
//

#import "TimeLineCell.h"

@implementation TimeLineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
   
        
        self.tweetTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.tweetTextLabel.font = [UIFont systemFontOfSize:14.0f];
        self.tweetTextLabel.textColor = [UIColor blackColor];
        self.tweetTextLabel.numberOfLines = 0;
        [self.contentView addSubview:self.tweetTextLabel];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLabel.font = [UIFont systemFontOfSize:12.0f];
        self.nameLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.nameLabel];
        
                       
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(5, 5, 35, 35);
    self.tweetTextLabel.frame = CGRectMake(58,18, 257, self.tweetTextLabelHeight);
    self.nameLabel.frame = CGRectMake(61, 5, 257, 12);
       
    //self.tweetTextLabel.frame = CGRectMake(58, 5, 257, self.tweetTextLabelHeight);
    //self.nameLabel.frame = CGRectMake(58, self.tweetTextLabelHeight + 15, 257, 12);
    //self.idnameLabel.frame = CGRectMake(58, self.tweetTextLabelHeight + 15, 257, 12);


}



@end
