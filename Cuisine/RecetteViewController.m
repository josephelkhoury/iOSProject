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
@synthesize lblName = _lblName;
@synthesize lblCategory = _lblCategory;
@synthesize btnFavoris = _btnFavoris;
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
        if (theRecette.favori == [NSNumber numberWithInt:1])
            self.btnFavoris.title = @"Supprimer des favoris";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    self.recette = nil;
    [self setLblName:nil];
    [self setLblCategory:nil];
    [self setBtnFavoris:nil];
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
@end
