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
@synthesize all, entrees, plats, desserts;

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

- (NSMutableArray *)getRecettes:(RecetteType)type
{
    if (type == ALL)
    {
        if (!all)
        {
            all = [[NSMutableArray alloc] init];
            for (Recette *recette in self.masterRecetteList)
            {
                [all addObject:recette];
            }
        }
        return all;
    }
    else if (type == ENTREE)
    {
        if (!entrees)
        {
            entrees = [[NSMutableArray alloc] init];
            for (Recette *recette in self.masterRecetteList)
            {
                if ([recette.category isEqualToString:@"Entrée"])
                    [entrees addObject:recette];
            }
        }
        return entrees;
    }
    else if (type == PLAT)
    {
        if (!plats)
        {
            plats = [[NSMutableArray alloc] init];
            for (Recette *recette in self.masterRecetteList)
            {
                if ([recette.category isEqualToString:@"Plat"])
                    [plats addObject:recette];
            }
        }
        return plats;
    }
    else if (type == DESSERT)
    {
        if (!desserts)
        {
            desserts = [[NSMutableArray alloc] init];
            for (Recette *recette in self.masterRecetteList)
            {
                if ([recette.category isEqualToString:@"Dessert"])
                    [desserts addObject:recette];
            }
        }
        return desserts;
    }
    else if (type == FAVORI)
    {
        NSMutableArray *favoris = [[NSMutableArray alloc] init];
        for (Recette *recette in self.masterRecetteList)
        {
            if (recette.favori == [NSNumber numberWithInt:1])
                [favoris addObject:recette];
        }
        return favoris;
    }
    else if (type == TOPTEN)
    {
        NSMutableArray *topten = [[NSMutableArray alloc] init];
        topten = self.masterRecetteList;
        
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"rating"
                                                      ascending:NO];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray = [topten sortedArrayUsingDescriptors:sortDescriptors];
        int count = 0;
        [topten removeAllObjects];
        for (Recette *rec in sortedArray)
        {
            if (count < 10)
            {
                [topten addObject:rec];
                count++;
            }
        }
        return topten;
    }
    return nil;
}

@end
