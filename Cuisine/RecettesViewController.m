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
    
    listContent = [self.dataController getRecettes:ALL];
    filteredListContent = [[NSMutableArray alloc] init];
    /*Recette *recette = (Recette *)[NSEntityDescription insertNewObjectForEntityForName:@"Recette" inManagedObjectContext:managedObjectContext];

    recette.name = @"Titre de la recette";
    recette.category = @"Entrée";

    [self.dataController addRecette:recette];
    [[self tblRecettes] reloadData];

    if (![managedObjectContext save:&error])
    {
        // Handle the error.
    }*/
}

- (void)viewWillAppear:(BOOL)animated 
{		
	NSIndexPath *tableSelection = [self.tblRecettes indexPathForSelectedRow];
	[self.tblRecettes deselectRowAtIndexPath:tableSelection animated:NO];
}

- (void)viewDidUnload
{
    [self setTblRecettes:nil];
    [self setSegFilter:nil];
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

    UITableViewCell *cell = [self.tblRecettes dequeueReusableCellWithIdentifier:CellIdentifier];
    Recette *recette;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        recette = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    else
    {
        recette = [self.listContent objectAtIndex:indexPath.row];
    }
    
    [[cell textLabel] setText:recette.name];
    [[cell detailTextLabel] setText:recette.category];
    
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
    if(segFilter.selectedSegmentIndex == 0)
        listContent = [self.dataController getRecettes:ALL];
    else if(segFilter.selectedSegmentIndex == 1)
        listContent = [self.dataController getRecettes:ENTREE];
    else if(segFilter.selectedSegmentIndex == 2)
        listContent = [self.dataController getRecettes:PLAT];
    else if(segFilter.selectedSegmentIndex == 3)
        listContent = [self.dataController getRecettes:DESSERT];
    [tblRecettes reloadData];
}
@end
