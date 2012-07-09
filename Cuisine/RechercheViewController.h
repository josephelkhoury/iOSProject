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

@interface RechercheViewController : UITableViewController

@property (strong, nonatomic) RecetteDataController *dataController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)doRecherche:(id)sender;

@end
