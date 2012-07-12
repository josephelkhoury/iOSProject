//
//  FirstViewController.m
//  Cuisine
//
//  Created by SEKIMIA on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AccueilViewController.h"

@interface AccueilViewController ()

@end

@implementation AccueilViewController
@synthesize dataController = _dataController;
@synthesize managedObjectContext;
@synthesize lblTitle;
@synthesize btnImage;
@synthesize recette;

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *patternImage = [UIImage imageNamed:@"vichy.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0xCF423C); 
    NSMutableArray *recettes = [self.dataController getRecettes:ALL];
    
    if ([recettes count] > 0)
    {
        int lowerBound = 0;
        int upperBound = [recettes count];
        int rand = lowerBound + arc4random() % (upperBound - lowerBound);
        recette = [recettes objectAtIndex:rand];
        [btnImage setImage:[UIImage imageNamed:recette.picture] forState:UIControlStateNormal];
        lblTitle.text = recette.name;
    }
}

- (void)viewDidUnload
{
    [self setRecette:nil];
    [self setLblTitle:nil];
    [self setBtnImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowRecetteDetails"]) 
    {
        RecetteViewController *detailViewController = [segue destinationViewController];
        detailViewController.recette = recette;
        detailViewController.managedObjectContext = self.managedObjectContext;
    }
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
