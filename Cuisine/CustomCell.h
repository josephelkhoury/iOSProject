//
//  GrammarCell.h
//  ApplicationLibanais
//
//  Created by SEKIMIA on 11/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CustomCell : UITableViewCell 
{
	IBOutlet UILabel *lblTitle;
	IBOutlet UILabel *lblCategory;
    IBOutlet UIImageView *imgPicture;
}

@property(nonatomic,strong) IBOutlet UILabel *lblTitle;
@property(nonatomic,strong) IBOutlet UILabel *lblCategory;
@property(nonatomic,strong) IBOutlet UIImageView *imgPicture;

@end
