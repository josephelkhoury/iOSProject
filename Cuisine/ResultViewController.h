//
//  ResultViewController.h
//  Cuisine
//
//  Created by SEKIMIA on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recette.h"
#import "RecetteViewController.h"
#import "RecetteDataController.h"
#import "CustomCell.h"

@interface ResultViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *results;
}

@property (strong, nonatomic) RecetteDataController *dataController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSMutableArray *results;

@end
