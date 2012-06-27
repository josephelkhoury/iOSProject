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

@property (nonatomic, copy) NSMutableArray *masterRecetteList;

- (NSUInteger)countOfList;
- (Recette *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addRecette:(Recette *)recette;

@end
