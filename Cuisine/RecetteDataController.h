//
//  RecetteDataController.h
//  Cuisine
//
//  Created by SEKIMIA on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Recette;

@interface RecetteDataController : NSObject
{
    NSMutableArray *entrees;
    NSMutableArray *plats;
    NSMutableArray *desserts;
}

@property (nonatomic, copy) NSMutableArray *masterRecetteList;
@property (strong, nonatomic) NSMutableArray *entrees;
@property (strong, nonatomic) NSMutableArray *plats;
@property (strong, nonatomic) NSMutableArray *desserts;

- (NSUInteger)countOfList;
- (Recette *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addRecette:(Recette *)recette;
- (NSMutableArray *)getRecettesFavoris;
- (NSMutableArray *)getEntrees;
- (NSMutableArray *)getPlats;
- (NSMutableArray *)getDesserts;

@end
