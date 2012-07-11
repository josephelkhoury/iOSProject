//
//  Recette.h
//  Cuisine
//
//  Created by Joseph El Khoury on 7/11/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface Recette : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * difficulty;
@property (nonatomic, retain) NSNumber * favori;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * ingredients;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * origin;
@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) NSString * preparation;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSNumber * rating;

@end
