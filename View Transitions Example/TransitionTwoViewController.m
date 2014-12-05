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
    //self.imageView.alpha = 0.0;
    //self.titleLabel.alpha = 0.0;
    [self animateOnEntry];

   // self.view.backgroundColor = [UIColor clearColor];
}

- (void)animateOnEntry
{
    CGRect startFrame = self.startingPosition;
    CGRect topImageViewStartFrame = CGRectMake(startFrame.origin.x, -startFrame.origin.y, startFrame.size.width, startFrame.size.height);
    startFrame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height + 44;

    CGRect topEndFrame = CGRectMake(0, -self.imageView.frame.size.height - 10, self.topImageView.frame.size.width, self.topImageView.frame.size.height);

    self.topImageView.frame = topImageViewStartFrame;
   // NSLog(@"%f %f %f %f", self.startingPosition.origin.x, -self.startingPosition.origin.y, self.startingPosition.size.width, self.startingPosition.size.height);

    CGRect imagePosition = CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
    CGRect endImageViewFrame = self.imageView.frame;
    self.imageView.frame = imagePosition;
    //NSLog(@"%f %f %f %f", imagePosition.origin.x, imagePosition.origin.y, imagePosition.size.width, imagePosition.size.height);

    CGRect firstEndTopImageFrame = CGRectMake(endImageViewFrame.origin.x, endImageViewFrame.origin.y - endImageViewFrame.size.height, self.topImageView.frame.size.width, self.topImageView.frame.size.height);

    [self.view addSubview:self.topImageView];
    //startFrame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height + 44;
    //startFrame.origin.y -= 110;
    CGRect endFrame = self.view.frame;
    self.view.frame = startFrame;

    //[self.view addSubview:self.topImageView];

    self.titleLabel.alpha = 0.0;
   // NSLog(@"Starting Frame: x:%f y:%f width:%f height:%f", startFrame.origin.x, startFrame.origin.y, startFrame.size.width, startFrame.size.height);

    [UIView animateWithDuration:3.0f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^(void)
     {
         self.view.frame = endFrame;
         self.topImageView.frame = firstEndTopImageFrame;
         self.imageView.frame = endImageViewFrame;

     } completion:^(BOOL finished) {
         // your own completion code

         [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             self.topImageView.frame = topEndFrame;
         } completion:^(BOOL finished) {
             [self.topImageView removeFromSuperview];
        }];
     }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
