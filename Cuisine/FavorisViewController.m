//
//  FavorisViewController.m
//  Cuisine
//
//  Created by SEKIMIA on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavorisViewController.h"

@interface FavorisViewController ()

@end

@implementation FavorisViewController
@synthesize dataController = _dataController;
@synthesize managedObjectContext;
@synthesize tblRecettes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0xCF423C); 
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTblRecettes:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [[self.dataController getRecettes:FAVORI] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"RecetteCell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Recette *recette = [[self.dataController getRecettes:FAVORI] objectAtIndex:indexPath.row];
    cell.lblTitle.text = recette.name;
    cell.lblCategory.text = recette.category;
    cell.imgPicture.image = [UIImage imageNamed:recette.picture];
    
    cell.lblTitle.textColor = UIColorFromRGB(0xCF423C);
    cell.lblCategory.textColor = UIColorFromRGB(0xCF423C);
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        Recette *recette = [[self.dataController getRecettes:FAVORI] objectAtIndex:indexPath.row];
        recette.favori = [NSNumber numberWithInt:0];
        NSError *error;
        [self.managedObjectContext save:&error];
        [self.tblRecettes deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tblRecettes reloadData];
    } 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowRecetteDetails"]) 
    {
        RecetteViewController *detailViewController = [segue destinationViewController];
        detailViewController.recette = [[self.dataController getRecettes:FAVORI] objectAtIndex:[self.tblRecettes indexPathForSelectedRow].row];
        detailViewController.managedObjectContext = self.managedObjectContext;
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSIndexPath *tableSelection = [self.tblRecettes indexPathForSelectedRow];
	[self.tblRecettes deselectRowAtIndexPath:tableSelection animated:NO];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recette" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) 
    {
        // Handle the error.
    }
    [self.dataController setMasterRecetteList:mutableFetchResults];
    [self.tblRecettes reloadData];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


@end
