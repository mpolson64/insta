//
//  PostCollectionViewCell.h
//  insta
//
//  Created by Miles Olson on 7/10/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI.h"
#import "Post.h"

@interface PostCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;

@property (strong, nonatomic) Post *post;

@end
