//
//  Top10ViewController.h
//  Cuisine
//
//  Created by SEKIMIA on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recette.h"
#import "CustomCell.h"
#import "RecetteDataController.h"
#import "RecettesViewController.h"

@interface Top10ViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *top10;
}

@property (strong, nonatomic) RecetteDataController *dataController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(strong, nonatomic) NSMutableArray *top10;

@end
