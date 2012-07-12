//
//  RechercheViewController.m
//  Cuisine
//
//  Created by SEKIMIA on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RechercheViewController.h"

@interface RechercheViewController ()

@end

@implementation RechercheViewController
@synthesize dataController = _dataController;
@synthesize managedObjectContext;
@synthesize pickerCategory;
@synthesize pickerOrigin;
@synthesize slider;
@synthesize lblCategory;
@synthesize lblOrigin;
@synthesize lblDifficulty;
@synthesize btnCategory;
@synthesize btnOrigin;
@synthesize searchBar;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Background
    UIImage *patternImage = [UIImage imageNamed:@"vichy.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];

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
    
    self.searchBar.tintColor = UIColorFromRGB(0xCF423C);
    
    categoryArray = [[NSMutableArray alloc] init];
    [categoryArray addObject:@"Toutes"];
    [categoryArray addObject:@"Entrée"];
    [categoryArray addObject:@"Plat"];
    [categoryArray addObject:@"Dessert"];
    
    originArray = [[NSMutableArray alloc] init];
    [originArray addObject:@"Toutes"];
    for (Recette *rec in [self.dataController getRecettes:ALL])
    {
        if(![originArray containsObject:rec.origin])
            [originArray addObject:rec.origin];
    }
    
    difficultyArray = [[NSMutableArray alloc] init];
    [difficultyArray addObject:@"Indifférent"];
    [difficultyArray addObject:@"Étudiant"];
    [difficultyArray addObject:@"Cuisinier occasionnel"];
    [difficultyArray addObject:@"Gastronome"];
    [difficultyArray addObject:@"Grand chef"];
    
    for (UIView *searchBarSubview in [self.searchBar subviews])
    {
        if ([searchBarSubview conformsToProtocol:@protocol(UITextInputTraits)]) 
        {
            [(UITextField *)searchBarSubview setDelegate:self];
            [(UITextField *)searchBarSubview setReturnKeyType:UIReturnKeyDone];
            [(UITextField *)searchBarSubview setKeyboardAppearance:UIKeyboardAppearanceDefault];
        }  
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.searchBar resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{    
    [textField resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSMutableArray *res = [self rechercher];
    if ([[segue identifier] isEqualToString:@"showResult"]) 
    {
        ResultViewController *resultViewController = [segue destinationViewController];
        resultViewController.dataController = self.dataController;
        resultViewController.managedObjectContext = self.managedObjectContext;
        resultViewController.results = res;
        if ([res count] == 0)
        {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Résultat"
                                                                message:@"Aucune recette trouvée" delegate:self 
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (IBAction)chooseCategory:(id)sender
{
    self.pickerCategory.hidden = NO;
    self.pickerOrigin.hidden = YES;
    pickingCategory = YES;
    pickingOrigin = NO;
    [self.pickerCategory reloadAllComponents];
}

- (IBAction)chooseOrigin:(id)sender
{
    self.pickerOrigin.hidden = NO;
    self.pickerCategory.hidden = YES;
    pickingCategory = NO;
    pickingOrigin = YES;
    [self.pickerOrigin reloadAllComponents];
}

- (NSMutableArray *)rechercher
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSString *searchText = self.searchBar.text;
    RecetteType type;
    
    if ([self.lblCategory.text isEqualToString:@"Toutes"])
        type = ALL;
    else if ([self.lblCategory.text isEqualToString:@"Entrée"])
        type = ENTREE;
    else if ([self.lblCategory.text isEqualToString:@"Plat"])
        type = PLAT;
    else if ([self.lblCategory.text isEqualToString:@"Dessert"])
        type = DESSERT;
    
    for (Recette *recette in [self.dataController getRecettes:type])
    {
        if (searchText == nil || [searchText isEqualToString:@""] || [recette.name rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)].location != NSNotFound || [recette.ingredients rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)].location != NSNotFound)
        {
            if ([self.lblDifficulty.text isEqualToString:@"Indifférent"] || [self.lblDifficulty.text isEqualToString:recette.difficulty])
            {
                if ([self.lblOrigin.text isEqualToString:@"Toutes"])
                    [results addObject:recette];
                else if ([recette.origin isEqualToString:self.lblOrigin.text])
                    [results addObject:recette];
            }
        }
    }
    return results;
}

- (IBAction)valueChanged:(UISlider*)sender
{
    NSUInteger index = (NSUInteger)(self.slider.value + 0.5);
    [self.slider setValue:index animated:NO];
    self.lblDifficulty.text = [difficultyArray objectAtIndex:index]; 
}
                

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickingCategory)
    {
        self.lblCategory.text = [categoryArray objectAtIndex:row];
        self.pickerCategory.hidden = YES;
    }
    if (pickingOrigin)
    {
        self.lblOrigin.text = [originArray objectAtIndex:row];
        self.pickerOrigin.hidden = YES;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if (pickingCategory)
        return [categoryArray count];
    if (pickingOrigin)
        return [originArray count];
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if (pickingCategory)
        return [categoryArray objectAtIndex:row];
    if (pickingOrigin)
        return [originArray objectAtIndex:row];
    return @"";
}

- (void)viewDidUnload
{
    [self setPickerCategory:nil];
    [self setPickerOrigin:nil];
    [self setLblCategory:nil];
    [self setLblOrigin:nil];
    [self setBtnCategory:nil];
    [self setBtnOrigin:nil];
    [self setSlider:nil];
    [self setLblDifficulty:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


@end
