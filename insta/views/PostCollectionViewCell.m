//
//  PostCollectionViewCell.m
//  insta
//
//  Created by Miles Olson on 7/10/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "PostCollectionViewCell.h"

@implementation PostCollectionViewCell

- (void)setPost:(Post *)post {
    _post = post;
    
    self.postImageView.file = post.image;
    [self.postImageView loadInBackground];
}

@end
