//
//  DetailViewController.m
//  CoreDataWithImage
//
//  Created by ShivKumar G on 04/09/15.
//  Copyright (c) 2015 Maple. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    picIV.image=[UIImage imageWithData:_maple.empimage];
    idTxt.text=[NSString stringWithFormat:@"%@",_maple.empid];
    nameTxt.text=_maple.empName;
    specialityTxt.text=_maple.empspeciality;
    salaryTxt.text=[NSString stringWithFormat:@"%@",_maple.empsalary];
    addrTxt.text=_maple.empaddr;
    
    idTxt.userInteractionEnabled=NO;
    nameTxt.userInteractionEnabled=NO;
    specialityTxt.userInteractionEnabled=NO;
    salaryTxt.userInteractionEnabled=NO;
    addrTxt.userInteractionEnabled=NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
