//
//  DetailViewController.h
//  CoreDataWithImage
//
//  Created by ShivKumar G on 04/09/15.
//  Copyright (c) 2015 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Maple.h"

@interface DetailViewController : UIViewController
{
    IBOutlet UITextField *idTxt;
    IBOutlet UITextField *nameTxt;
    IBOutlet UITextField *specialityTxt;
    IBOutlet UITextField *salaryTxt;
    IBOutlet UITextField *addrTxt;
    
    IBOutlet UIImageView *picIV;
}

@property (strong ,nonatomic) Maple *maple;

@end
