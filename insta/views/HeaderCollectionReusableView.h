//
//  HeaderCollectionReusableView.h
//  insta
//
//  Created by Miles Olson on 7/10/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse.h"

@interface HeaderCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *profPicImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;

@property (strong, nonatomic) PFUser *user;
@end
