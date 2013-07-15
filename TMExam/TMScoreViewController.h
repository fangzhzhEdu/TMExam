//
//  TMScoreViewController.h
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-6-29.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMScoreViewController : UIViewController


#pragma  mark Statistics
// statisctics
@property (nonatomic, strong) IBOutlet UIImageView *time0;
@property (nonatomic, strong) IBOutlet UIImageView *time1;
@property (nonatomic, strong) IBOutlet UIImageView *time2;
@property (nonatomic, strong) IBOutlet UIImageView *time3;

@property (nonatomic, strong) IBOutlet UIImageView *statistics0;
@property (nonatomic, strong) IBOutlet UIImageView *statistics1;
@property (nonatomic, strong) IBOutlet UIImageView *statistics2;
@property (nonatomic, strong) IBOutlet UIImageView *statistics3;

@property (nonatomic, strong) IBOutlet UIImageView *testTimes0;
@property (nonatomic, strong) IBOutlet UIImageView *testTimes1;

@property (nonatomic, strong) IBOutlet UIImageView *testPercent0;
@property (nonatomic, strong) IBOutlet UIImageView *testPercent1;
@property (nonatomic, strong) IBOutlet UIImageView *testPercent2;


@property (nonatomic, strong) IBOutlet UIImageView *honorTitle;

#pragma mark record

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

#pragma mark indicator
// indicator
@property (nonatomic, strong) IBOutlet UIImageView *testPage0;
@property (nonatomic, strong) IBOutlet UIImageView *testPage1;
@property (nonatomic, strong) IBOutlet UIImageView *testPage2;

@property (nonatomic, strong) IBOutlet UIButton *finishTest;

- (IBAction)finishTestTouched:(id)sender;

@end
