//
//  ViewController.h
//  facebookProject
//
//  Created by amir sankar on 8/4/16.
//  Copyright © 2016 amir sankar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,FBSDKSharingDelegate>

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
- (IBAction)logEmailButton:(id)sender;
- (IBAction)sharePhoto:(id)sender;

@end

