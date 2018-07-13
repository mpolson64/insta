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
    
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", post.author.username];
    self.captionLabel.text = post.caption;
    self.likesLabel.text = [NSString stringWithFormat:@"%lu likes", post.likedBy.count];
    self.commentsLabel.text = [NSString stringWithFormat:@"%lu comments", post.comments.count];
    
    if([self.post.likedBy containsObject:PFUser.currentUser.username]) {
        [self.likeButton setImage:[UIImage imageNamed:@"iconmonstr-favorite-1-240"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"iconmonstr-favorite-2-240"] forState:UIControlStateNormal];
    }
    
    if(post.author[@"profPic"]) {
        self.profPicImage.file = post.author[@"profPic"];
        [self.profPicImage loadInBackground];
    }
    
}

- (IBAction)onLike:(id)sender {
    [self toggleLike];
}

- (void) toggleLike {
    if([self.post.likedBy containsObject:PFUser.currentUser.username]) {
        self.likesLabel.text = [NSString stringWithFormat:@"%lu likes", self.post.likedBy.count - 1];
        [self.likeButton setImage:[UIImage imageNamed:@"iconmonstr-favorite-2-240"] forState:UIControlStateNormal];
        [self.post unlike:PFUser.currentUser.username];
    } else {
        self.likesLabel.text = [NSString stringWithFormat:@"%lu likes", self.post.likedBy.count + 1];
        [self.likeButton setImage:[UIImage imageNamed:@"iconmonstr-favorite-1-240"] forState:UIControlStateNormal];
        [self.post like:PFUser.currentUser.username];
    }
}

@end
