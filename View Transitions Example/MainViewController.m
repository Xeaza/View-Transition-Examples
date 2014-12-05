//
//  ViewController.m
//  View Transitions Example
//
//  Created by Taylor Wright-Sanson on 12/4/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "MainViewController.h"
#import "TransitionOneViewController.h"
#import "TransitionTwoViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSIndexPath *selectedIndexPath;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];

    if ([segue.identifier isEqualToString:@"TransitionOneSegue"])
    {
        TransitionOneViewController *transitionOneViewController = segue.destinationViewController;
        transitionOneViewController.modalPresentationStyle = UIModalPresentationCustom;
        transitionOneViewController.startingPosition = [self.tableView rectForRowAtIndexPath:self.selectedIndexPath];
    }
    else if ([segue.identifier isEqualToString:@"TransitionTwoSegue"])
    {
        TransitionTwoViewController *transitionTwoViewController = segue.destinationViewController;
        transitionTwoViewController.modalPresentationStyle = UIModalPresentationCustom;
        CGRect selectedCellRect = [self.tableView rectForRowAtIndexPath:self.selectedIndexPath];
        transitionTwoViewController.startingPosition = selectedCellRect;

        // Make rect to take screenshot of the content above the selected cell
        CGRect topRect = CGRectMake(0, 0, selectedCellRect.size.width, selectedCellRect.origin.y);
        transitionTwoViewController.topImageView = [self screenshotImageViewWithCroppingRect:topRect];

        // Make rect to take screenshot of the content below the selected cell
        CGRect bottomRect = CGRectMake(0, selectedCellRect.origin.y + selectedCellRect.size.height, selectedCellRect.size.width, self.view.frame.size.height - selectedCellRect.size.height);
        transitionTwoViewController.bottomImageView = [self screenshotImageViewWithCroppingRect:bottomRect];
    }
}

#pragma mark - Table View

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    return indexPath;
}

#pragma mark - Screenshot 

- (UIImageView *)screenshotImageViewWithCroppingRect:(CGRect)croppingRect
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(croppingRect.size, YES, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(croppingRect.size);
    }

    // Create a graphics context and translate it the view we want to crop so
    // that even in grabbing (0,0), that origin point now represents the actual
    // cropping origin desired:
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, -croppingRect.origin.x, -croppingRect.origin.y);
    [self.view.layer renderInContext:ctx];

    // Retrieve a UIImage from the current image context:
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // Return the image in a UIImageView:
    return [[UIImageView alloc] initWithImage:snapshotImage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
