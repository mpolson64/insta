//
//  PostCell.m
//  insta
//
//  Created by Miles Olson on 7/9/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    
    self.postImageView.file = post.image;
    [self.postImageView loadInBackground];
    
//    self.nameLabel.text = post.author.username;
    self.captionLabel.text = post.caption;
}

@end
