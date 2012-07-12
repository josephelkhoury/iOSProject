//
//  RecetteViewController.m
//  Cuisine
//
//  Created by SEKIMIA on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecetteViewController.h"

@interface RecetteViewController ()

@end

@implementation RecetteViewController
@synthesize lblName;
@synthesize lblCategory;
@synthesize lblDifficulty;
@synthesize photo;
@synthesize btnFavoris;
@synthesize recette = _recette;
@synthesize managedObjectContext;

#pragma mark - Managing the detail item

- (void)setRecette:(Recette *) newRecette
{
    if (_recette != newRecette) 
    {
        _recette = newRecette;
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    Recette *theRecette = self.recette;
    if (theRecette) 
    {
        self.lblName.text = theRecette.name;
        self.lblCategory.text = theRecette.category;
        self.lblDifficulty.text = theRecette.difficulty;
        self.photo.image = [UIImage imageNamed:theRecette.picture];
        if (theRecette.favori == [NSNumber numberWithInt:1])
            self.btnFavoris.title = @"Supprimer des favoris";
        else
            self.btnFavoris.title = @"Ajouter aux favoris";
        
        // LISTE DES INGREDIENTS
        NSArray *ingredients = [theRecette.ingredients componentsSeparatedByString: @","];
        //
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0xCF423C);
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)share:(id)sender
{
    // Create the item to share (in this example, a url)
    
	UIImage *image = self.photo.image;
    SHKItem *item = [SHKItem image:image title:self.lblName.text];
    
	// Get the ShareKit action sheet
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];

    // Display the action sheet
	[actionSheet showFromToolbar:self.navigationController.toolbar];
}

- (void)viewDidUnload
{
    self.recette = nil;
    [self setLblName:nil];
    [self setLblCategory:nil];
    [self setBtnFavoris:nil];
    [self setLblDifficulty:nil];
    [self setPhoto:nil];
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)editFavori:(id)sender
{
    if (self.recette.favori == [NSNumber numberWithInt:1])
    {
        self.recette.favori = [NSNumber numberWithInt:0];
        self.btnFavoris.title = @"Ajouter aux favoris";
    }
    else
    {
        self.recette.favori = [NSNumber numberWithInt:1];
        self.btnFavoris.title = @"Supprimer des favoris";
    }
    NSError *error;
    [self.managedObjectContext save:&error];
}


- (void)viewWillAppear:(BOOL)animated
{
    [self configureView];
    [super viewWillAppear:animated];
}

@end
