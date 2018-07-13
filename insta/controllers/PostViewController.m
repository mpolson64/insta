//
//  PostViewController.m
//  insta
//
//  Created by Miles Olson on 7/11/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "PostViewController.h"
#import "CommentsViewController.h"
#import "ProfileViewController.h"

@interface PostViewController ()
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@property (weak, nonatomic) IBOutlet PFImageView *profPicImageView;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;
@property (weak, nonatomic) IBOutlet UILabel *likedByLabel;

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
    if([self.post.likedBy containsObject:PFUser.currentUser.username]) {
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
    
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapName:)];
    [self.nameLabel addGestureRecognizer:profileTapGestureRecognizer];
    [self.nameLabel setUserInteractionEnabled:YES];
    
    if(self.post.author[@"profPic"]) {
        self.profPicImageView.file = self.post.author[@"profPic"];
        [self.profPicImageView loadInBackground];
    }
    
    NSString *buttonText = @"";
    if(self.post.comments.count == 0) {
        buttonText = @"Comment";
    } else {
        buttonText = [NSString stringWithFormat:@"See %lu comments", self.post.comments.count];
    }
    [self.commentsButton setTitle:buttonText forState:UIControlStateNormal];
    
    if(self.post.likedBy.count == 0) {
        self.likedByLabel.text = @"Be the first to like this!";
    } else {
        self.likedByLabel.text = [NSString stringWithFormat:@"Last liked by @%@", self.post.likedBy[self.post.likedBy.count - 1]];
    }
    
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

- (void)didTapName:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"toProfile" sender:sender];
}

- (void) toggleLike {
    if([self.post.likedBy containsObject:PFUser.currentUser.username]) {
        self.likeLabel.text = [NSString stringWithFormat:@"%lu likes", self.post.likedBy.count - 1];
        [self.heartButton setImage:[UIImage imageNamed:@"iconmonstr-favorite-2-240"] forState:UIControlStateNormal];
        [self.post unlike:PFUser.currentUser.username];
    } else {
        self.likeLabel.text = [NSString stringWithFormat:@"%lu likes", self.post.likedBy.count + 1];
        [self.heartButton setImage:[UIImage imageNamed:@"iconmonstr-favorite-1-240"] forState:UIControlStateNormal];
        [self.post like:PFUser.currentUser.username];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([sender isKindOfClass:[UIButton class]]) {
        CommentsViewController *commentsViewController = [segue destinationViewController];
        commentsViewController.post = self.post;
    } else if([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        NSLog(@"yes");
        ProfileViewController *profileViewController = [segue destinationViewController];
        profileViewController.user = self.post.author;
    }
}


@end
