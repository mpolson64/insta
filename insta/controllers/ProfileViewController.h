//
//  ProfileViewController.h
//  insta
//
//  Created by Miles Olson on 7/10/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse.h"

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) PFUser *user;

@end
