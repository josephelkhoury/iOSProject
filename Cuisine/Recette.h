//
//  Recette.h
//  Cuisine
//
//  Created by SEKIMIA on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface Recette : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * difficulty;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * ingredients;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * origin;
@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) NSString * preparation;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSNumber * favori;

@end
