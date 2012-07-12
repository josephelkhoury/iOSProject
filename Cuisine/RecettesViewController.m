//
//  SecondViewController.m
//  Cuisine
//
//  Created by SEKIMIA on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecettesViewController.h"

@interface RecettesViewController ()

@end

@implementation RecettesViewController 
@synthesize searchBar;
@synthesize dataController = _dataController;
@synthesize managedObjectContext;
@synthesize tblRecettes;
@synthesize segFilter;
@synthesize listContent;
@synthesize filteredListContent;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recette" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) 
    {
        // Handle the error.
    }
    [self.dataController setMasterRecetteList:mutableFetchResults];*/

    listContent = [self.dataController getRecettes:ALL];
    [self.tblRecettes reloadData];
    filteredListContent = [[NSMutableArray alloc] init];
    
    self.segFilter.tintColor = UIColorFromRGB(0xCF423C);
    self.searchBar.tintColor = UIColorFromRGB(0xCF423C);    
}

- (void)viewDidUnload
{
    [self setTblRecettes:nil];
    [self setSegFilter:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
    
    NSInteger rows = 0;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        rows = [self.filteredListContent count];
    }
    else
    {
        rows = [self.listContent count];
    }
    
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"RecetteCell";

    CustomCell *cell = [self.tblRecettes dequeueReusableCellWithIdentifier:CellIdentifier];
    Recette *recette;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        recette = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    else
    {
        recette = [self.listContent objectAtIndex:indexPath.row];
    }
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowRecetteDetails"]) 
    {
        RecetteViewController *detailViewController = [segue destinationViewController];
        
        detailViewController.recette = [self.listContent objectAtIndex:[self.tblRecettes indexPathForSelectedRow].row];
        
        detailViewController.managedObjectContext = self.managedObjectContext;
    }
}

- (void)filterContentForSearchText:(NSString *)searchText 
                             scope:(NSString *)scope
{
    [self.filteredListContent removeAllObjects];	

	for (Recette *recette in listContent)
	{
		//if ([scope isEqualToString:@"Toutes"] || [recette.category isEqualToString:scope])
		//{
			NSComparisonResult nameResult = [recette.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];

            if (nameResult == NSOrderedSame)
			{
				[self.filteredListContent addObject:recette];
            }
		//}
	}
}

#pragma mark - UISearchDisplayController delegate methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller 
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller 
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:searchOption]];
    
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)didFilter:(id)sender
{
    if(self.segFilter.selectedSegmentIndex == 0)
        listContent = [self.dataController getRecettes:ALL];
    else if(self.segFilter.selectedSegmentIndex == 1)
        listContent = [self.dataController getRecettes:ENTREE];
    else if(self.segFilter.selectedSegmentIndex == 2)
        listContent = [self.dataController getRecettes:PLAT];
    else if(self.segFilter.selectedSegmentIndex == 3)
        listContent = [self.dataController getRecettes:DESSERT];
    [self.tblRecettes reloadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    NSIndexPath *tableSelection = [self.tblRecettes indexPathForSelectedRow];
	[self.tblRecettes deselectRowAtIndexPath:tableSelection animated:NO];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

@end
