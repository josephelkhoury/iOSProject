//
//  RechercheViewController.h
//  Cuisine
//
//  Created by SEKIMIA on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecetteDataController.h"
#import "Recette.h"

@interface RechercheViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
{
    NSMutableArray *categoryArray;
    NSMutableArray *originArray;
    NSMutableArray *difficultyArray;
    bool pickingCategory;
    bool pickingOrigin;
}

@property (strong, nonatomic) RecetteDataController *dataController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblOrigin;
@property (weak, nonatomic) IBOutlet UILabel *lblDifficulty;
@property (weak, nonatomic) IBOutlet UIButton *btnCategory;
@property (weak, nonatomic) IBOutlet UIButton *btnOrigin;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)doRecherche:(id)sender;
- (IBAction)chooseCategory:(id)sender;
- (IBAction)chooseOrigin:(id)sender;
- (IBAction)valueChanged:(UISlider*)sender;

@end
