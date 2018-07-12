//
//  CommentTableViewCell.h
//  insta
//
//  Created by Miles Olson on 7/11/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (strong, nonatomic) NSString *comment;

@end
