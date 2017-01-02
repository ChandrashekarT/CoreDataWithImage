//
//  ViewController.m
//  CoreDataWithImage
//
//  Created by ShivKumar G on 03/09/15.
//  Copyright (c) 2015 Maple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Hide The Navigation Bar
    self.navigationController.navigationBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    newEmpBut.layer.cornerRadius=8.0;
    newEmpBut.clipsToBounds=YES;
    
    allEmpBut.layer.cornerRadius=8.0;
    allEmpBut.clipsToBounds=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)employeeDetails:(id)sender
{
    if ([sender tag] == 1) //NewEmployee
    {
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        appDelegate.isNewEmployee = YES;
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        [self.navigationController pushViewController:[storyboard instantiateViewControllerWithIdentifier:@"NewEmployeeViewController"] animated:YES];
    }
    else if ([sender tag] == 2)//AllEmployees
    {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        [self.navigationController pushViewController:[storyboard instantiateViewControllerWithIdentifier:@"AllEmployeesViewController"] animated:YES];
    }
}

@end
