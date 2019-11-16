//
//  ViewController.m
//  Appcoda
//
//  Created by ihub on 10/01/19.
//  Copyright © 2019 ecoihub. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    BOOL shareEnabled;
    NSMutableArray *selectedRecipes;
}

@end

@implementation ViewController
@synthesize imagesList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    selectedRecipes = [NSMutableArray array];
    
    NSArray *namesList = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    NSArray *ageArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    
    imagesList = [NSArray arrayWithObjects:namesList,ageArray, nil];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [imagesList count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[imagesList objectAtIndex:section]count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollCell *cell = (CustomCollCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollCell" forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"download"]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected"]];
    cell.patientImage.image = [UIImage imageNamed:[imagesList[indexPath.section] objectAtIndex:indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        RecipeCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        NSString *title = [[NSString alloc]initWithFormat:@"Recipe Group #%li", indexPath.section + 1];
        headerView.titleLabel.text = title;
        UIImage *headerImage = [UIImage imageNamed:@"6"];
        headerView.backgroundHeaderImg.image = headerImage;
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRecipePhoto"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        RecipeViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        destViewController.recipeImageName = [imagesList[indexPath.section] objectAtIndex:indexPath.row];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

- (IBAction)shareButtonTouched:(id)sender{
    if (shareEnabled) {
        
        // Post selected photos to Facebook
        if ([selectedRecipes count] > 0) {
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                [controller setInitialText:@"Check out my recipes!"];
                for (NSString *recipePhoto in selectedRecipes) {
                    [controller addImage:[UIImage imageNamed:recipePhoto]];
                }
                
                [self presentViewController:controller animated:YES completion:Nil];
            }
        }
        
        // Deselect all selected items
        for(NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
        
        // Remove all items from selectedRecipes array
        [selectedRecipes removeAllObjects];
        
        // Change the sharing mode to NO
        shareEnabled = NO;
        self.collectionView.allowsMultipleSelection = NO;
        self.shareButton.title = @"Share";
        [self.shareButton setStyle:UIBarButtonItemStylePlain];
        
    } else {
        
        // Change shareEnabled to YES and change the button text to DONE
        shareEnabled = YES;
        self.collectionView.allowsMultipleSelection = YES;
        self.shareButton.title = @"Upload";
        [self.shareButton setStyle:UIBarButtonItemStyleDone];
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (shareEnabled) {
        // Determine the selected items by using the indexPath
        NSString *selectedRecipe = [imagesList[indexPath.section] objectAtIndex:indexPath.row];
        // Add the selected item into the array
        [selectedRecipes addObject:selectedRecipe];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (shareEnabled) {
        NSString *deSelectedRecipe = [imagesList[indexPath.section] objectAtIndex:indexPath.row];
        [selectedRecipes removeObject:deSelectedRecipe];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (shareEnabled) {
        return NO;
    } else {
        return YES;
    }
}

@end
