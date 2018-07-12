//
//  Post.m
//  insta
//
//  Created by Miles Olson on 7/9/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "Post.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic comments;
@dynamic likedBy;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.comments = [NSMutableArray new];
    newPost.likedBy = [NSMutableArray new];

    [newPost saveInBackgroundWithBlock: completion];
}

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}

- (void)makeComment:(NSString *)comment withUsername:(NSString *)username {
    [self addObject:[NSString stringWithFormat:@"%@: %@", username, comment] forKey:@"comments"];
    [self saveInBackground];
}

- (void)like:(NSString *)objectId {
    [self addObject:objectId forKey:@"likedBy"];
    [self saveInBackground];
}

- (void)unlike:(NSString *)objectId {
    [self removeObject:objectId forKey:@"likedBy"];
    [self saveInBackground];
}

@end
