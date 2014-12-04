//
//  TransitionOneViewController.m
//  View Transitions Example
//
//  Created by Taylor Wright-Sanson on 12/4/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "TransitionOneViewController.h"

@interface TransitionOneViewController ()

@property CGRect selectedCellsLabelPosition;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TransitionOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self animateOnEntry];
}

//-(IBAction)doneWasPressed:(id)sender {
//    //animation on EXIT FROM CURRENT VIEW
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
//    [UIView animateWithDuration:0.5f animations:^
//     {
//         CGRect startFrame = self.startingPosition;
//         startFrame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height + 44;
//         self.view.frame = startFrame;
//         self.titleLabel.frame = CGRectMake(20, 10, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
//         CGRect endFrame = self.view.frame;
//         self.buttonLabel.alpha = 0.0;
//         self.buttonLabel.frame = CGRectMake(self.buttonLabel.frame.origin.x, self.buttonLabel.frame.origin.y - 400, self.buttonLabel.frame.size.width, self.buttonLabel.frame.size.height);
//         NSLog(@"Ending Frame: x:%f y:%f height:%f width:%f", self.selectedCellsLabelPosition.origin.x, self.selectedCellsLabelPosition.origin.y, endFrame.size.height, endFrame.size.width);
//     }
//                     completion:^(BOOL finished)
//     {
//         [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
//     }
//     ];
//}

- (void)animateOnEntry
{
    CGRect startFrame = self.startingPosition;
    startFrame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height + 44;

    self.selectedCellsLabelPosition = CGRectMake(142.5, 147, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);

    CGRect endLabelFrame = self.titleLabel.frame;
    self.titleLabel.frame = self.selectedCellsLabelPosition;

    CGRect imagePosition = CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
    CGRect endImageFrame = self.imageView.frame;
    self.imageView.frame = imagePosition;

    NSLog(@"Starting Frame: x:%f y:%f width:%f height:%f", startFrame.origin.x, startFrame.origin.y, startFrame.size.width, startFrame.size.height);
    CGRect endFrame = self.view.frame;

    self.view.frame = startFrame;


    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void)
     {
         self.view.frame = endFrame;
         self.titleLabel.frame = endLabelFrame;
         self.imageView.frame = endImageFrame;
     }
                     completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
