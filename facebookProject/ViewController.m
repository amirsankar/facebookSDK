//
//  ViewController.m
//  facebookProject
//
//  Created by amir sankar on 8/4/16.
//  Copyright © 2016 amir sankar. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc]init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    loginButton.publishPermissions = @[@"publish_actions"];
}

-(void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    
}

-(void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    
}


-(void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (IBAction)logEmailButton:(id)sender {
    if ([FBSDKAccessToken currentAccessToken]) {
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"id,name,email" forKey:@"fields"];
    
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                      id result, NSError *error) {
             if (error) {
                 NSLog(@"%@", error.localizedDescription);

                 
             } else {
                 NSLog(@"%@", result);
                 self.emailLabel.text = [NSString stringWithFormat: @"%@", result[@"name"]];
             }
         }];
    }
}

- (IBAction)sharePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc]init];
    content.photos = @[[FBSDKSharePhoto photoWithImage:chosenImage userGenerated:YES]];
    [FBSDKShareAPI shareWithContent:content delegate:self];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];

}
@end
