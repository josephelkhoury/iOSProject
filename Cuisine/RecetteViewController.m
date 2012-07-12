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
@synthesize lblRating;
@synthesize lblIng;
@synthesize lblOrigin;
@synthesize scrollView;
@synthesize imgStar1;
@synthesize imgStar2;
@synthesize imgStar3;
@synthesize imgStar4;
@synthesize imgStar5;
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
        lblName.textColor = UIColorFromRGB(0xCF423C);
        self.lblCategory.text = theRecette.category;
        self.lblDifficulty.text = theRecette.difficulty;
        self.photo.image = [UIImage imageNamed:theRecette.picture];
        self.lblRating.text = [NSString stringWithFormat:@"%f/5", theRecette.rating];
        self.lblOrigin.text = theRecette.origin;
        
        lblIng.textColor = UIColorFromRGB(0xCF423C);
        if (theRecette.favori == [NSNumber numberWithInt:1])
            [self.btnFavoris setImage:[UIImage imageNamed:@"star.png"]];
        else
            [self.btnFavoris setImage:[UIImage imageNamed:@"star_add.png"]];
        
        NSArray *ingredients = [theRecette.ingredients componentsSeparatedByString: @","];
        int y = 295;
        for (NSString *ingredient in ingredients)
        {
            UILabel *lblIngredient = [[UILabel alloc] initWithFrame:CGRectMake(29, y, 271, 20)];
            lblIngredient.text = ingredient;
            lblIngredient.font = [UIFont fontWithName:@"TrebuchetMS" size:12];
            lblIngredient.backgroundColor = [UIColor clearColor];
            [scrollView addSubview:lblIngredient];
            y += 20;
        }
        
        y += 10;
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(29, y, 271, 20)];
        lbl.text = @"Préparation";
        lbl.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:13];
        lbl.textColor = UIColorFromRGB(0xCF423C);
        lbl.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:lbl];
        
        y += 20;
        
        CGSize size = [theRecette.preparation sizeWithFont:[UIFont fontWithName:@"TrebuchetMS" size:12]
                      constrainedToSize:CGSizeMake(271.0, 500.0)
                          lineBreakMode:UILineBreakModeWordWrap];
        UITextView *txtPreparation = [[UITextView alloc] initWithFrame:CGRectMake(29, y, 271, size.height + 10)];
        txtPreparation.editable = NO;
        txtPreparation.scrollEnabled = NO;
        txtPreparation.text = theRecette.preparation;
        txtPreparation.font = [UIFont fontWithName:@"TrebuchetMS" size:12];
        txtPreparation.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:txtPreparation];
        y += size.height + 10;
        if (y > 367)
            y -= 367;
        else
            y = 367;
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + y);
        
        NSMutableArray *ratingImages = [[NSMutableArray alloc] init];
        [ratingImages addObject:self.imgStar1];
        [ratingImages addObject:self.imgStar2];
        [ratingImages addObject:self.imgStar3];
        [ratingImages addObject:self.imgStar4];
        [ratingImages addObject:self.imgStar5];
        
        double rating = [theRecette.rating doubleValue];
        double r = floor(rating);
        double s = rating - r;
        for(int i=0;i<r;i++)
        {
            [[ratingImages objectAtIndex:i] setImage:[UIImage imageNamed:@"star.png"]];
        }
        if(s == 0)
        {
            if(r != [ratingImages count])
                [[ratingImages objectAtIndex:r] setImage:[UIImage imageNamed:@"empty_star.png"]];
        }
        else if(s > 0 && s <= 0.5)
        {
            [[ratingImages objectAtIndex:r] setImage:[UIImage imageNamed:@"half_star.png"]];
        }
        else if(s > 0.5 && s <= 1.0)
        {
            [[ratingImages objectAtIndex:r] setImage:[UIImage imageNamed:@"star.png"]];
        }
        for(int i=r+1;i<[ratingImages count];i++)
        {
            [[ratingImages objectAtIndex:i] setImage:[UIImage imageNamed:@"empty_star.png"]];
        }		
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0xCF423C);
    UIImage *patternImage = [UIImage imageNamed:@"vichy.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)share:(id)sender
{
    // Create the item to share (in this example, a url)
    
	/*UIImage *image = self.photo.image;
    SHKItem *item = [SHKItem image:image title:self.lblName.text];
    
	// Get the ShareKit action sheet
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];

    // Display the action sheet
	[actionSheet showFromToolbar:self.navigationController.toolbar];*/
}

- (void)viewDidUnload
{
    self.recette = nil;
    [self setLblName:nil];
    [self setLblCategory:nil];
    [self setBtnFavoris:nil];
    [self setLblDifficulty:nil];
    [self setPhoto:nil];
    [self setLblRating:nil];
    [self setScrollView:nil];
    [self setLblIng:nil];
    [self setLblOrigin:nil];
    [self setImgStar1:nil];
    [self setImgStar2:nil];
    [self setImgStar3:nil];
    [self setImgStar4:nil];
    [self setImgStar5:nil];
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
        [self.btnFavoris setImage:[UIImage imageNamed:@"star_add.png"]];
    }
    else
    {
        self.recette.favori = [NSNumber numberWithInt:1];
        [self.btnFavoris setImage:[UIImage imageNamed:@"star.png"]];
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
