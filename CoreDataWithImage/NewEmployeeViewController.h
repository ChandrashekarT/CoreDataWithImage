//
//  NewEmployeeViewController.h
//  CoreDataWithImage
//
//  Created by ShivKumar G on 03/09/15.
//  Copyright (c) 2015 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Maple.h"

@interface NewEmployeeViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    IBOutlet UITextField *idTxt;
    IBOutlet UITextField *nameTxt;
    IBOutlet UITextField *specialityTxt;
    IBOutlet UITextField *salaryTxt;
    IBOutlet UITextField *addrTxt;
    
    IBOutlet UIImageView *picIV;
    IBOutlet UIButton *takePhotoBut;
    
    UIImagePickerController *imagePicker;
    AppDelegate *appDelegate;
}

@property (strong ,nonatomic) Maple *maple;

-(IBAction)takePhoto:(id)sender;

@end
