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
@synthesize picker;
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
    
    categoryArray = [[NSMutableArray alloc] init];
    [categoryArray addObject:@"Toutes"];
    [categoryArray addObject:@"Entrée"];
    [categoryArray addObject:@"Plat"];
    [categoryArray addObject:@"Dessert"];
    
    originArray = [[NSMutableArray alloc] init];
    [originArray addObject:@"Toutes"];
    [originArray addObject:@"France"];
    [originArray addObject:@"Autre"];
    
    difficultyArray = [[NSMutableArray alloc] init];
    [difficultyArray addObject:@"Indifférent"];
    [difficultyArray addObject:@"Etudiant"];
    [difficultyArray addObject:@"Cuisinier occasionnel"];
    [difficultyArray addObject:@"Gastronome"];
    [difficultyArray addObject:@"Grand chef"];
    
    for (UIView *searchBarSubview in [searchBar subviews])
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{    
    [textField resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showResult"]) 
    {
        ResultViewController *resultViewController = [segue destinationViewController];
        resultViewController.dataController = self.dataController;
        resultViewController.managedObjectContext = self.managedObjectContext;
        resultViewController.results = [self rechercher];
    }
}

- (IBAction)chooseCategory:(id)sender
{
    picker.hidden = NO;
    pickingCategory = YES;
    pickingOrigin = NO;
    [picker reloadAllComponents];
}

- (IBAction)chooseOrigin:(id)sender
{
    picker.hidden = NO;
    pickingCategory = NO;
    pickingOrigin = YES;
    [picker reloadAllComponents];
}

- (NSMutableArray *)rechercher
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSString *searchText = searchBar.text;
    RecetteType type;
    
    if ([lblCategory.text isEqualToString:@"Toutes"])
        type = ALL;
    else if ([lblCategory.text isEqualToString:@"Entrée"])
        type = ENTREE;
    else if ([lblCategory.text isEqualToString:@"Plat"])
        type = PLAT;
    else if ([lblCategory.text isEqualToString:@"Dessert"])
        type = DESSERT;
    
    if (searchText != nil)
    {
        for (Recette *recette in [self.dataController getRecettes:type])
        {
            recette.ingredients = @"Salade, Tomate, Onion";
            if (([recette.name rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)].location != NSNotFound || [recette.ingredients rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)].location != NSNotFound))
            {
                if ([lblDifficulty.text isEqualToString:@"Indifférent"] || [lblDifficulty.text isEqualToString:recette.difficulty])
                {
                    if ([lblOrigin.text isEqualToString:@"Toutes"])
                        [results addObject:recette];
                    else if ([recette.origin isEqualToString:lblOrigin.text])
                        [results addObject:recette];
                }
            }
        }
    }
    return results;
}

- (IBAction)valueChanged:(UISlider*)sender
{
    NSUInteger index = (NSUInteger)(slider.value + 0.5);
    [slider setValue:index animated:NO];
    lblDifficulty.text = [difficultyArray objectAtIndex:index]; 
}
                

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickingCategory)
        lblCategory.text = [categoryArray objectAtIndex:row];
    if (pickingOrigin)
        lblOrigin.text = [originArray objectAtIndex:row];
    picker.hidden = YES;
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
    [self setPicker:nil];
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
