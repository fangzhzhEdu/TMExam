//
//  TMTestDemoViewController.h
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-7-7.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMTestDemoViewController : UIViewController


@property (nonatomic, strong) IBOutlet UILabel *questionLabel;
@property (nonatomic, strong) IBOutlet UILabel *optionALabel;
@property (nonatomic, strong) IBOutlet UILabel *optionBLabel;
@property (nonatomic, strong) IBOutlet UILabel *optionCLabel;
@property (nonatomic, strong) IBOutlet UILabel *optionDLabel;
@property (nonatomic, strong) IBOutlet UILabel *explainLeadingLabel;
@property (nonatomic, strong) IBOutlet UILabel *explainTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *explainContentLabel;

@property (nonatomic, strong) IBOutlet UIButton *optionMarkAButton;
@property (nonatomic, strong) IBOutlet UIButton *optionMarkBButton;
@property (nonatomic, strong) IBOutlet UIButton *optionMarkCButton;
@property (nonatomic, strong) IBOutlet UIButton *optionMarkDButton;

@property (nonatomic, strong) IBOutlet UIButton *optionQuestionAButton;
@property (nonatomic, strong) IBOutlet UIButton *optionQuestionBButton;
@property (nonatomic, strong) IBOutlet UIButton *optionQuestionCButton;
@property (nonatomic, strong) IBOutlet UIButton *optionQuestionDButton;


@property (nonatomic, strong) IBOutlet UIImageView *explainFrameImageView;



#pragma mark methods

- (IBAction)homeToolbarButtonClicked:(id)sender;
- (IBAction)textbookToolbarButtonClicked:(id)sender;
- (IBAction)newsToolbarButtonClicked:(id)sender;
- (IBAction)settingsToolbarButtonClicked:(id)sender;

- (IBAction)optionAClicked:(id)sender;
- (IBAction)optionBClicked:(id)sender;
- (IBAction)optionCClicked:(id)sender;
- (IBAction)optionDClicked:(id)sender;


- (IBAction)previousButtonClicked:(id)sender;
- (IBAction)nextButtonClicked:(id)sender;
- (IBAction)submitButtonClicked:(id)sender;
- (IBAction)undoneButtonClicked:(id)sender;
- (IBAction)counterButtonClicked:(id)sender;

@end
