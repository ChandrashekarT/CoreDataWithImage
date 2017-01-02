//
//  NewEmployeeViewController.m
//  CoreDataWithImage
//
//  Created by ShivKumar G on 03/09/15.
//  Copyright (c) 2015 Maple. All rights reserved.
//

#import "NewEmployeeViewController.h"

@interface NewEmployeeViewController ()

@end

@implementation NewEmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate=[[UIApplication sharedApplication]delegate];
    
    //Set Image to NavigationBar and setCustomBarButton
    self.navigationController.navigationBar.hidden=NO;
    UIImage *img=[UIImage imageNamed:@"maple_logo1.png"];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:img forBarMetrics: UIBarMetricsDefault];
    self.navigationController.navigationBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    //UINavigationBar BackButton
    self.navigationItem.hidesBackButton=YES;
    UIButton *backBut=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backBut setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBut addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    backBut.layer.cornerRadius=23.0;
    backBut.clipsToBounds=YES;
    UIBarButtonItem *backBarBut=[[UIBarButtonItem alloc]initWithCustomView:backBut];
    self.navigationItem.leftBarButtonItem=backBarBut;
    
    //UINavigationBarButtons Save & Update
    UIButton *saveBut=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 27)];
    [saveBut addTarget:self action:@selector(saveData) forControlEvents:UIControlEventTouchUpInside];
    saveBut.layer.cornerRadius=18.0;
    saveBut.clipsToBounds=YES;
    
    if (appDelegate.isNewEmployee == YES) {
        [saveBut setImage:[UIImage imageNamed:@"save.jpeg"] forState:UIControlStateNormal];
        [takePhotoBut setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
        appDelegate.isNewEmployee = NO;
    }
    else
    {
        [saveBut setImage:[UIImage imageNamed:@"update2.jpeg"] forState:UIControlStateNormal];
        [takePhotoBut setImage:[UIImage imageNamed:@"edit2.jpeg"] forState:UIControlStateNormal];
        picIV.image=[UIImage imageWithData:_maple.empimage];
        idTxt.text=[NSString stringWithFormat:@"%@",_maple.empid];
        nameTxt.text=_maple.empName;
        specialityTxt.text=_maple.empspeciality;
        salaryTxt.text=[NSString stringWithFormat:@"%@",_maple.empsalary];
        addrTxt.text=_maple.empaddr;
    }
    
    UIBarButtonItem *saveBarBut=[[UIBarButtonItem alloc]initWithCustomView:saveBut];
    self.navigationItem.rightBarButtonItem=saveBarBut;
    
    picIV.layer.cornerRadius=55.0;
    picIV.clipsToBounds=YES;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveData
{
    NSString *alertBody;
    NSError *error;
    NSManagedObjectContext *context=[appDelegate managedObjectContext];
    NSFetchRequest *fetchReq=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Maple" inManagedObjectContext:context];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"empid == %@",_maple.empid];
    [fetchReq setEntity:entity];
    [fetchReq setPredicate:predicate];
    Maple *existingMaple=[[context executeFetchRequest:fetchReq error:&error] lastObject];
    if (!existingMaple) {
        Maple *maple=[NSEntityDescription insertNewObjectForEntityForName:@"Maple" inManagedObjectContext:context];
        maple.empid=[NSNumber numberWithInt:idTxt.text.intValue];
        maple.empName=nameTxt.text;
        maple.empspeciality=specialityTxt.text;
        maple.empsalary=[NSNumber numberWithDouble:salaryTxt.text.doubleValue];
        maple.empaddr=addrTxt.text;
        NSData *imgData=UIImagePNGRepresentation(picIV.image);
        maple.empimage=imgData;
        alertBody=@"Successfully Data Saved";
    }
    else
    {
        existingMaple.empid=[NSNumber numberWithInt:idTxt.text.intValue];
        existingMaple.empName=nameTxt.text;
        existingMaple.empspeciality=specialityTxt.text;
        existingMaple.empsalary=[NSNumber numberWithDouble:salaryTxt.text.doubleValue];
        existingMaple.empaddr=addrTxt.text;
        NSData *imgData=UIImagePNGRepresentation(picIV.image);
        existingMaple.empimage=imgData;
        alertBody=@"Successfully Data Updated";
    }
    [context save:&error];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:alertBody delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma mark -- UIAlertView Delegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UIImagePickerController Delegate Methods
-(IBAction)takePhoto:(id)sender
{
    imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    imagePicker.editing=NO;
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Photo",nil];
    [actionSheet showInView:self.view];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img=info[UIImagePickerControllerOriginalImage];
    picIV.image=img;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- UIActionSheet Delegate Method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:NULL];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Camera device is not found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (buttonIndex == 1)
    {
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:NULL];
    }
    else
    {
    }
}

#pragma mark -- UITextField DelegateMethods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    CGRect frame=self.view.frame;
    frame.origin.y=64;
    self.view.frame=frame;
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    CGRect frame=self.view.frame;
    frame.origin.y=-70;
    self.view.frame=frame;
    
    return YES;
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
