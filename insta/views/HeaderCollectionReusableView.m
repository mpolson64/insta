//
//  HeaderCollectionReusableView.m
//  insta
//
//  Created by Miles Olson on 7/10/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "HeaderCollectionReusableView.h"

@implementation HeaderCollectionReusableView

- (void)setUser:(PFUser *)user {
    _user = user;
    self.nameLabel.text = [NSString stringWithFormat:@"%@", user.username];
    self.bioLabel.text = user[@"bio"];
    self.profPicImageView.layer.cornerRadius = self.profPicImageView.frame.size.width / 2;
    if(PFUser.currentUser[@"profPic"]) {
        self.profPicImageView.file = PFUser.currentUser[@"profPic"];
        [self.profPicImageView loadInBackground];
    }
}

@end
