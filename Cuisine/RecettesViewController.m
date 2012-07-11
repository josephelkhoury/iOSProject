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
    
    segFilter.tintColor = UIColorFromRGB(0xCF423C);
    searchBar.tintColor = UIColorFromRGB(0xCF423C);
    /*Recette *recette;
    
    recette = (Recette *)[NSEntityDescription insertNewObjectForEntityForName:@"Recette" inManagedObjectContext:managedObjectContext];

    recette.name = @"Tourte sans pâte aux champignons";
    recette.category = @"Entrée";
    recette.ingredients = @"2 oeufs,100 g de champignons,100 g de farine,50 g de fromage râpé,sel et poivre";
    recette.preparation = @"Préchauffer le four à thermostat 6 (180°C). Casser les oeufs dans un saladier. Les mettre dans un grand plat, ajouter la farine, bien mélanger. Saler et poivrer. Ajouter les champignons, surtout ne pas mélanger. Mettre au four 1/4 d'heure. Sortir du four, ajouter le fromage râpé sur le dessus. Remettre au four encore un quart d'heure. Manger la tourte tout de suite aprés l'avoir sortie.";
    recette.difficulty = @"Cuisinier occasionnel";
    recette.time = @"75";
    recette.origin = @"France";
    recette.picture = @"quiche.jpeg";
    
    [self.dataController addRecette:recette];
    
    recette = (Recette *)[NSEntityDescription insertNewObjectForEntityForName:@"Recette" inManagedObjectContext:managedObjectContext];
    
    recette.name = @"Bananes au four, abricots secs et noisettes";
    recette.category = @"Dessert";
    recette.ingredients = @"1 banane mûre,1 petit-suisses à 40%,2 abricots secs,1 cuillère café de noisettes concassées (ou amandes) grillées,1 cuillère à café de céréales souflées (riz, mélange...),1 petite cuillère à café de miel";
    recette.preparation = @"Préchauffer votre four 5 minutes à 180°C. Placer les bananes entières sur une grille pour 25 minutes environ. Laisser tiédir pour pouvoir les peler sans vous brûler. Mélanger le petit-suisse et le miel. Disposer ce mélange dans une assiette. Placer la banane pelée dessus et rajouter sur le dessus les abricots secs coupés en petits morceaux ainsi que les cérales soufflées et les noisettes grillées. Idéal pour un dessert ou un goûter équilibré pour enfants et parents accompagnateurs !.";
    recette.difficulty = @"Étudiant";
    recette.time = @"30";
    recette.origin = @"Italie";
    recette.picture = @"bananes.jpeg";
    
    [self.dataController addRecette:recette];
    
    recette = (Recette *)[NSEntityDescription insertNewObjectForEntityForName:@"Recette" inManagedObjectContext:managedObjectContext];
    
    recette.name = @"Charlotte aux langues de chat";
    recette.category = @"Dessert";
    recette.ingredients = @"100 g de chocolat,60 langues de chat,40 g de sucre en poudre,4 œufs,Un peu de chocolat râpé,De la crème chantilly";
    recette.preparation = @"La mousse de chocolat : Faire fondre le chocolat au bain-marie. Casser le œufs en séparant les blancs des jaunes. Fouetter les jaunes avec le sucre et ajouter le chocolat fondu. Battre les blancs en neige avec un peu de sel et les incorporer à la mousse de chocolat. Mettre 1 heure au réfrigérateur. Couvrir de film le fond des parois d'un moule à charlotte. Tapisser le moule de langues, face bombée vers l'extérieur. Verser le mélange et le recouvrir de langues de chat. Réserver 3 heures au réfrigérateur. Retourner la charlotte sur un plat. Enlever le film alimentaire et décorer de crème chantilly et de chocolat râpé. Servir aussitôt assez frais.";
    recette.difficulty = @"Étudiant";
    recette.time = @"30";
    recette.origin = @"Canada";
    recette.picture = @"charlotte.jpeg";
    
    [self.dataController addRecette:recette];
    
    recette = (Recette *)[NSEntityDescription insertNewObjectForEntityForName:@"Recette" inManagedObjectContext:managedObjectContext];
    
    recette.name = @"Salade normande";
    recette.category = @"Plat";
    recette.ingredients = @"100 g de chocolat,60 langues de chat,40 g de sucre en poudre,4 œufs,Un peu de chocolat râpé,De la crème chantilly";
    recette.preparation = @"250 g d'escalopes de poulet,1 poivron vert ou jaune,1 tomate,1 pomme (type canada),1 salade,1/2 Neufchâtel,éventuellement du pain,sel et poivre,huile d'olive";
    recette.difficulty = @"Gastronome";
    recette.time = @"25";
    recette.origin = @"France";
    recette.picture = @"salade.jpeg";
    
    [self.dataController addRecette:recette];
    
    
    [[self tblRecettes] reloadData];

    if (![managedObjectContext save:&error])
    {
        // Handle the error.
    }*/
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
