//
//  CommentTableViewCell.m
//  insta
//
//  Created by Miles Olson on 7/11/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComment:(NSString *)comment {
    _comment = comment;
    
    self.commentLabel.text = comment;
}

@end
