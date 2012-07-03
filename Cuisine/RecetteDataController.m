//
//  RecetteDataController.m
//  Cuisine
//
//  Created by SEKIMIA on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecetteDataController.h"
#import "Recette.h"

@interface RecetteDataController ()
- (void)initializeDefaultDataList;
@end

@implementation RecetteDataController
@synthesize masterRecetteList = _masterRecetteList;

- (void)initializeDefaultDataList 
{
    NSMutableArray *recetteList = [[NSMutableArray alloc] init];
    self.masterRecetteList = recetteList;
}

- (id)init 
{
    if (self = [super init]) 
    {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

- (void)setMasterRecetteList:(NSMutableArray *)newList 
{
    if (_masterRecetteList != newList) 
    {
        _masterRecetteList = [newList mutableCopy];
    }
}

- (NSUInteger)countOfList 
{
    return [self.masterRecetteList count];
}

- (Recette *)objectInListAtIndex:(NSUInteger)theIndex 
{
    return [self.masterRecetteList objectAtIndex:theIndex];
}

- (void)addRecette:(Recette *)recette
{
    //[self.masterBirdSightingList addObject:sighting];
    [self.masterRecetteList insertObject:recette atIndex:0];
}

@end
