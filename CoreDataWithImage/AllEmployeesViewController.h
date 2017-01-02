//
//  AllEmployeesViewController.h
//  CoreDataWithImage
//
//  Created by ShivKumar G on 03/09/15.
//  Copyright (c) 2015 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Maple.h"
#import "CustomCell.h"
#import "NewEmployeeViewController.h"
#import "DetailViewController.h"

@interface AllEmployeesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UISearchBar *mySearchBar;
    IBOutlet UITableView *myTableView;
    
    BOOL isTableSearch;
    NSMutableArray *searchDataArr;
    
    NSArray *fetchedObjArr;
    AppDelegate *appDelegate;
    NSFetchRequest *fetchReq;
    NSEntityDescription *entity;
    NSManagedObjectContext *context;
    
    BOOL isTableEdit;
    UIButton *editBut;
}

@end
