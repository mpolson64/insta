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
@property (weak, nonatomic) IBOutlet UIButton *heartButton;

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postImageView.file = self.post.image;
    [self.postImageView loadInBackground];
    
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", self.post.author.username];
    self.captionLabel.text = self.post.caption;
    self.likeLabel.text = [NSString stringWithFormat:@"%lu likes", self.post.likedBy.count];
    if([self.post.likedBy containsObject:PFUser.currentUser.objectId]) {
        [self.heartButton setImage:[UIImage imageNamed:@"iconmonstr-favorite-1-240"] forState:UIControlStateNormal];
    } else {
        [self.heartButton setImage:[UIImage imageNamed:@"iconmonstr-favorite-2-240"] forState:UIControlStateNormal];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    self.timestampLabel.text = [dateFormatter stringFromDate:self.post.createdAt];
    
    UITapGestureRecognizer *imageTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didDoubleTapImage:)];
    imageTapGestureRecognizer.numberOfTapsRequired = 2;
    [self.postImageView addGestureRecognizer:imageTapGestureRecognizer];
    [self.postImageView setUserInteractionEnabled:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPost:(Post *)post {
    _post = post;
}

- (IBAction)onLike:(id)sender {
    [self toggleLike];
}

- (void) didDoubleTapImage:(UITapGestureRecognizer *)sender{
    [self toggleLike];
}

- (void) toggleLike {
    if([self.post.likedBy containsObject:PFUser.currentUser.objectId]) {
        self.likeLabel.text = [NSString stringWithFormat:@"%lu likes", self.post.likedBy.count - 1];
        [self.heartButton setImage:[UIImage imageNamed:@"iconmonstr-favorite-2-240"] forState:UIControlStateNormal];
        [self.post unlike:PFUser.currentUser.objectId];
    } else {
        self.likeLabel.text = [NSString stringWithFormat:@"%lu likes", self.post.likedBy.count + 1];
        [self.heartButton setImage:[UIImage imageNamed:@"iconmonstr-favorite-1-240"] forState:UIControlStateNormal];
        [self.post like:PFUser.currentUser.objectId];
    }
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
