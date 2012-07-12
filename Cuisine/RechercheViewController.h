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
#import "ResultViewController.h"

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
@property (strong, nonatomic) IBOutlet UIPickerView *pickerCategory;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerOrigin;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *lblCategory;
@property (strong, nonatomic) IBOutlet UILabel *lblOrigin;
@property (strong, nonatomic) IBOutlet UILabel *lblDifficulty;
@property (strong, nonatomic) IBOutlet UIButton *btnCategory;
@property (strong, nonatomic) IBOutlet UIButton *btnOrigin;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)chooseCategory:(id)sender;
- (IBAction)chooseOrigin:(id)sender;
- (IBAction)valueChanged:(UISlider*)sender;

@end
