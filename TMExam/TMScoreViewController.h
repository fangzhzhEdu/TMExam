//
//  TMScoreViewController.h
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-6-29.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMScoreViewController : UIViewController
- (id)initWithDict:(NSDictionary*)sampleInfo;


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


@property (nonatomic, strong) IBOutlet UIImageView *honorTitle;

#pragma mark record
// record
@property (nonatomic, strong) NSMutableArray *testRecordArray;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord0;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord1;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord2;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord3;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord4;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord5;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord6;

@property (nonatomic, strong) IBOutlet UIImageView *testRecord7;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord8;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord9;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord10;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord11;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord12;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord13;

@property (nonatomic, strong) IBOutlet UIImageView *testRecord14;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord15;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord16;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord17;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord18;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord19;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord20;

@property (nonatomic, strong) IBOutlet UIImageView *testRecord21;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord22;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord23;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord24;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord25;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord26;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord27;

@property (nonatomic, strong) IBOutlet UIImageView *testRecord28;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord29;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord30;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord31;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord32;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord33;
@property (nonatomic, strong) IBOutlet UIImageView *testRecord34;

#pragma mark indicator
// indicator
@property (nonatomic, strong) IBOutlet UIImageView *testPage0;
@property (nonatomic, strong) IBOutlet UIImageView *testPage1;
@property (nonatomic, strong) IBOutlet UIImageView *testPage2;

@property (nonatomic, strong) IBOutlet UIImageView *finishTest;


@end
