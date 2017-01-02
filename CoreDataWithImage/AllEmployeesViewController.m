//
//  AllEmployeesViewController.m
//  CoreDataWithImage
//
//  Created by ShivKumar G on 03/09/15.
//  Copyright (c) 2015 Maple. All rights reserved.
//

#import "AllEmployeesViewController.h"

@interface AllEmployeesViewController ()

@end

@implementation AllEmployeesViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    isTableSearch=NO;
    //mySearchBar.showsCancelButton=YES;
    searchDataArr=[NSMutableArray array];
    
    //UINavigationBar EditButton
    isTableEdit=NO;
    editBut=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [editBut setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
    [editBut addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    editBut.layer.cornerRadius=13.0;
    editBut.clipsToBounds=YES;
    UIBarButtonItem *editBarBut=[[UIBarButtonItem alloc]initWithCustomView:editBut];
    self.navigationItem.rightBarButtonItem=editBarBut;
    
    [self createTable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //Set Image to NavigationBar
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)editAction
{
    UIButton *doneBut=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [doneBut setImage:[UIImage imageNamed:@"done.jpeg"] forState:UIControlStateNormal];
    [doneBut addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editBarBut=[[UIBarButtonItem alloc]initWithCustomView:doneBut];
    self.navigationItem.rightBarButtonItem=editBarBut;
    
    isTableEdit=YES;
    [myTableView reloadData];
}
-(void)doneAction
{
    [editBut setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
    [editBut addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editBarBut=[[UIBarButtonItem alloc]initWithCustomView:editBut];
    self.navigationItem.rightBarButtonItem=editBarBut;
    
    isTableEdit=NO;
    [myTableView reloadData];

}

#pragma mark --UITableView Methods

-(void)createTable
{
    appDelegate=[[UIApplication sharedApplication]delegate];
    context=[appDelegate managedObjectContext];
    
    fetchReq=[[NSFetchRequest alloc]init];
    entity=[NSEntityDescription entityForName:@"Maple" inManagedObjectContext:context];
    [fetchReq setEntity:entity];
    
    NSError *error;
    fetchedObjArr=[context executeFetchRequest:fetchReq error:&error];
    [myTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isTableSearch == YES) {
        return searchDataArr.count;
    }
    else
    return fetchedObjArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Cell";
    CustomCell *cell=(CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (isTableEdit==YES) {
        cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    }
    else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    
    if (isTableSearch == YES) {
        Maple *maple=[searchDataArr objectAtIndex:indexPath.row];
        cell.picImgView.image=[UIImage imageWithData:maple.empimage];
        cell.nameLbl.text=maple.empName;
    }
    else
    {
        Maple *maple=[fetchedObjArr objectAtIndex:indexPath.row];
        cell.picImgView.image=[UIImage imageWithData:maple.empimage];
        cell.nameLbl.text=maple.empName;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Maple *maple;
    if (isTableSearch == YES) {
        maple = [searchDataArr objectAtIndex:indexPath.row];
    }
    else
    {
        maple = [fetchedObjArr objectAtIndex:indexPath.row];
    }
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"empid == %@",maple.empid];
    [fetchReq setPredicate:predicate];
    
    NSError *fetchError;
    NSArray *fetchedProducts=[context executeFetchRequest:fetchReq error:&fetchError];
    maple=[fetchedProducts objectAtIndex:0];
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewEmployeeViewController *nvc=[storyboard instantiateViewControllerWithIdentifier:@"NewEmployeeViewController"];
    nvc.maple=maple;
    
    appDelegate.isNewEmployee=NO;
    
    [self.navigationController pushViewController:nvc animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Maple *maple;
    if (isTableSearch == YES) {
        maple = [searchDataArr objectAtIndex:indexPath.row];
    }
    else
    {
        maple = [fetchedObjArr objectAtIndex:indexPath.row];
    }
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"empid == %@",maple.empid];
//    [fetchReq setPredicate:predicate];
//    
//    NSError *fetchError;
//    NSArray *fetchedProducts=[context executeFetchRequest:fetchReq error:&fetchError];
//    maple=[fetchedProducts objectAtIndex:0];
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *dvc=[storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    dvc.maple=maple;
    
    [self.navigationController pushViewController:dvc animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isTableEdit == YES) {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Maple *maple;
        if (isTableSearch == YES) {
            maple = [searchDataArr objectAtIndex:indexPath.row];
        }
        else
        {
            maple = [fetchedObjArr objectAtIndex:indexPath.row];
        }
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"empid == %@",maple.empid];
        [fetchReq setPredicate:predicate];
        
        NSError *error;
        NSArray *fetchArr=[context executeFetchRequest:fetchReq error:&error];
        
        for (NSManagedObject *object in fetchArr) {
            [context deleteObject:object];
        }
        
        [context save:&error];
        
        [self createTable];
    }
}

#pragma mark -- SearchBar Methods

//Search
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    mySearchBar.showsCancelButton=YES;
    isTableSearch=YES;
    [searchDataArr removeAllObjects];
    if ([searchText length]>0) {
        [self searchTextData];
    }
    if ([searchText length]==0) {
        isTableSearch=NO;
        [myTableView reloadData];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [mySearchBar resignFirstResponder];
}
-(void)searchTextData
{
    for (Maple *maple in fetchedObjArr) {
        NSString *name=maple.empName;
        NSRange range=[name rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
        if (range.length>0) {
            [searchDataArr addObject:maple];
        }
    }
    [myTableView reloadData];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    mySearchBar.showsCancelButton=NO;
    mySearchBar.text=nil;
    isTableSearch=NO;
    [myTableView reloadData];
    [mySearchBar resignFirstResponder];
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
