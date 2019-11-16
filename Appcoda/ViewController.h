//
//  ViewController.h
//  Appcoda
//
//  Created by ihub on 10/01/19.
//  Copyright © 2019 ecoihub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCollCell.h"
#import "RecipeCollectionHeaderView.h"
#import "RecipeViewController.h"
#import <Social/Social.h>

@interface ViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *imagesList;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
- (IBAction)shareButtonTouched:(id)sender;

@end
