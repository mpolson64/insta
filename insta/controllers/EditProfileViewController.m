//
//  EditProfileViewController.m
//  insta
//
//  Created by Miles Olson on 7/12/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "EditProfileViewController.h"
#import "Parse.h"

@interface EditProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *previewImage;
@property (strong, nonatomic) UIImage *selectedImage;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;
@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    
    [self.previewImage setImage:editedImage];
    self.selectedImage = editedImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSave:(id)sender {
    PFUser.currentUser[@"bio"] = self.bioTextView.text;
    PFUser.currentUser[@"profPic"] = [PFFile fileWithData: UIImageJPEGRepresentation(self.selectedImage, 1.0)];
    [PFUser.currentUser saveInBackground];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
