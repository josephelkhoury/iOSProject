//
//  Recette.h
//  Cuisine
//
//  Created by SEKIMIA on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Recette : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * difficulty;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * ingredients;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * origin;
@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) NSString * preparation;
@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) NSString * time;

@end
