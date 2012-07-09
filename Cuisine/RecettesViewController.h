//
//  SecondViewController.h
//  Cuisine
//
//  Created by SEKIMIA on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecetteDataController.h"
#import "Recette.h"
#import "RecettesViewController.h"
#import "RecetteViewController.h"

@interface RecettesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
{
    NSMutableArray *listContent;
    NSMutableArray *filteredListContent;
}

@property (strong, nonatomic) RecetteDataController *dataController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITableView *tblRecettes;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segFilter;
@property (strong, nonatomic) NSMutableArray *listContent;
@property (strong, nonatomic) NSMutableArray *filteredListContent;

- (IBAction)didFilter:(id)sender;

@end
