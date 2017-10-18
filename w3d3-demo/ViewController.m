//
//  ViewController.m
//  Temp
//
//  Created by Roland Tecson on 2017-10-18.
//  Copyright © 2017 Roland Tecson. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "MyHeaderView.h"
#import "MyFooterView.h"

@interface ViewController () <UICollectionViewDataSource>

// IBOutlets
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

// Properties
@property (strong, nonatomic) UICollectionViewFlowLayout *simpleLayout;
@property (strong, nonatomic) UICollectionViewFlowLayout *smallLayout;

@end

@implementation ViewController

// MARK: - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // We are the datasource for the collectionview
    self.collectionView.dataSource = self;
    
    [self setupSimpleLayout];
    [self setupSmallLayout];
    
    self.collectionView.collectionViewLayout = self.simpleLayout;
}


// MARK: - Internal methods

- (void)setupSimpleLayout
{
    self.simpleLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.simpleLayout.itemSize = CGSizeMake(100, 100); // Set size of cell
    self.simpleLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);  // "Border around each section"
    self.simpleLayout.minimumInteritemSpacing = 15;  // Minimum horizontal spacing between cells
    self.simpleLayout.minimumLineSpacing = 10;  // Minimum vertical spacing
    
//    // Add this line so headers will appear. If this line is not present, headers will not appear
//    self.simpleLayout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 50);
    
    // By default, direction is vertical
    self.simpleLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    // Add this line so headers will appear. If this line is not present, headers will not appear
    self.simpleLayout.headerReferenceSize = CGSizeMake(50, self.collectionView.frame.size.height);

    // Add this line so footers will appear. If this line is not present, footers will not appear
    self.simpleLayout.footerReferenceSize = CGSizeMake(30, self.collectionView.frame.size.height);
}

- (void)setupSmallLayout
{
    self.smallLayout = [[UICollectionViewFlowLayout alloc] init];
    self.smallLayout.itemSize = CGSizeMake(50, 50);
    self.smallLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.smallLayout.minimumLineSpacing = 5;
    self.smallLayout.minimumInteritemSpacing = 5;
    self.smallLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 25);
    self.smallLayout.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 15);
}


// MARK: - IBActions

- (IBAction)playTapped:(id)sender
{
    UICollectionViewLayout *nextLayout;
    if (self.collectionView.collectionViewLayout == self.simpleLayout) {
        nextLayout = self.smallLayout;
    }
    else {
        nextLayout = self.simpleLayout;
    }
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView setCollectionViewLayout:nextLayout
                                        animated:YES];
}


// MARK: - UICollectionViewDataSource protocol methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 5;
        case 1:
            return 3;
        case 2:
            return 8;
        default:
            return 7;
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"myCell"
                                                   forIndexPath:indexPath];
    NSString *labelText = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    cell.label.text = labelText;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MyHeaderView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                withReuseIdentifier:@"MyHeaderView"
                                                       forIndexPath:indexPath];
        headerView.label.text = [NSString stringWithFormat:@"%ld", (long)indexPath.section];
        return headerView;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        MyFooterView *footerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                           withReuseIdentifier:@"MyFooterView"
                                                                                  forIndexPath:indexPath];
        footerView.label.text = [NSString stringWithFormat:@"%ld", (long)indexPath.section];
        return footerView;
    }
    else {
        return nil;
    }
}

@end
