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

    if ([segue.identifier isEqualToString:@"TransitionOneSegue"]) {

        TransitionOneViewController *transitionOneViewController = segue.destinationViewController;

        transitionOneViewController.modalPresentationStyle = UIModalPresentationCustom;
        transitionOneViewController.startingPosition = [self.tableView rectForRowAtIndexPath:self.selectedIndexPath];
    }

}

#pragma mark - Table View

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        self.selectedIndexPath = indexPath;
        return indexPath;
    }
    return indexPath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
