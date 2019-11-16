//
//  RecipeViewController.m
//  Appcoda
//
//  Created by ihub on 10/01/19.
//  Copyright © 2019 ecoihub. All rights reserved.
//

#import "RecipeViewController.h"

@interface RecipeViewController ()

@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.recipeImageView.image = [UIImage imageNamed:self.recipeImageName];
}



- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
