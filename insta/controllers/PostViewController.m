//
//  PostViewController.m
//  insta
//
//  Created by Miles Olson on 7/11/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "PostViewController.h"
#import "CommentsViewController.h"

@interface PostViewController ()

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postImageView.file = self.post.image;
    [self.postImageView loadInBackground];
    
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", self.post.author.username];
    self.captionLabel.text = self.post.caption;
    self.likeLabel.text = [NSString stringWithFormat:@"%@ likes", self.post.likeCount];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    self.timestampLabel.text = [dateFormatter stringFromDate:self.post.createdAt];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPost:(Post *)post {
    _post = post;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([sender isKindOfClass:[UIButton class]]) {
        CommentsViewController *commentsViewController = [segue destinationViewController];
        commentsViewController.post = self.post;
    }
}


@end
