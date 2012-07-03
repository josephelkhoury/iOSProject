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
@synthesize recette = _recette;

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
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
