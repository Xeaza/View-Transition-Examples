//
//  TransitionTwoViewController.m
//  View Transitions Example
//
//  Created by Taylor Wright-Sanson on 12/4/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "TransitionTwoViewController.h"

@interface TransitionTwoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation TransitionTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self animateOnEntry];
}

- (void)animateOnEntry
{
    CGRect startFrame = self.startingPosition;

    // Top part of view to animate up and out of view
    CGRect topImageViewStartFrame = CGRectMake(startFrame.origin.x, -startFrame.origin.y, startFrame.size.width, startFrame.size.height);
    startFrame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height + 44;

    CGRect topEndFrame = CGRectMake(0, -self.imageView.frame.size.height, self.topImageView.frame.size.width, self.topImageView.frame.size.height);
    self.topImageView.frame = topImageViewStartFrame;
    [self.view addSubview:self.topImageView];

    // Selected cell image to animate up
    CGRect imagePosition = CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
    CGRect endImageViewFrame = self.imageView.frame;
    self.imageView.frame = imagePosition;

    CGRect firstEndTopImageFrame = CGRectMake(endImageViewFrame.origin.x, endImageViewFrame.origin.y - endImageViewFrame.size.height, self.topImageView.frame.size.width, self.topImageView.frame.size.height);

    CGRect endFrame = self.view.frame;
    self.view.frame = startFrame;

    // Bottom Half of screen to animate down and out of view
    CGRect bottomEndFrame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.bottomImageView.frame.size.width, self.bottomImageView.frame.size.height);
    CGRect bottomStartFrame = CGRectMake(startFrame.origin.x, self.startingPosition.origin.y, self.bottomImageView.frame.size.width, self.bottomImageView.frame.size.height);
    self.bottomImageView.frame = bottomStartFrame;

    [self.view addSubview:self.bottomImageView];

    self.titleLabel.alpha = 0.0;

    [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^(void)
     {
         self.view.frame = endFrame;
         self.topImageView.frame = topEndFrame; //firstEndTopImageFrame;
         self.imageView.frame = endImageViewFrame;
         //self.topImageView.alpha = 0.0;
         self.bottomImageView.frame = bottomEndFrame;

     } completion:^(BOOL finished) {
         // your own completion code

         [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             //self.topImageView.frame = topEndFrame;
         } completion:^(BOOL finished) {
             [self.topImageView removeFromSuperview];
             [self.bottomImageView removeFromSuperview];
        }];
     }];
}

- (IBAction)onBackButtonPressed:(UIButton *)backButton
{
    //animation on EXIT FROM CURRENT VIEW
    self.view.translatesAutoresizingMaskIntoConstraints = NO;

    [UIView animateWithDuration:0.3 animations:^{
        backButton.alpha = 0.0;
    }];

    [self.view addSubview:self.topImageView];
    [self.view addSubview:self.bottomImageView];

    [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^(void)
     {
         CGRect startFrame = self.startingPosition;
         startFrame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height + 44;

         // Animate top image down
         CGRect topImageEndingFrame = CGRectMake(0, self.topImageView.frame.origin.y - 2, self.topImageView.frame.size.width, self.topImageView.frame.size.height);
         self.topImageView.frame = topImageEndingFrame;

         // Move imageView to y = 0
         CGRect imageViewRrect = CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
         self.imageView.frame = imageViewRrect;

         // Animate bottom image up
         CGRect bottomImageRect = CGRectMake(0, self.imageView.frame.size.height, self.bottomImageView.frame.size.width, self.bottomImageView.frame.size.height);
         self.bottomImageView.frame = bottomImageRect;

         self.view.frame = startFrame;
     }
                     completion:^(BOOL finished)
     {
         [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
         [self.topImageView removeFromSuperview];
         [self.bottomImageView removeFromSuperview];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
