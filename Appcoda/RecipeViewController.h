//
//  RecipeViewController.h
//  Appcoda
//
//  Created by ihub on 10/01/19.
//  Copyright © 2019 ecoihub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) NSString *recipeImageName;

- (IBAction)close:(id)sender;
@end
