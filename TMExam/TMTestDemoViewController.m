                                                //
//  TMTestDemoViewController.m
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-7-7.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMTestDemoViewController.h"
#import "TMTestRecordManager.h"
#import "TMTestRecord.h"
#import "TMTestRecordSingleSelection.h"
#import "TMScoreViewController.h"

@interface TMTestDemoViewController ()

@property (nonatomic, readwrite) NSInteger curTestRecordIdx;
@property (nonatomic, weak) NSArray *curRecordArray;            // 当前类型试题的数组

- (void)loadSingleSelectionRecord:(TMTestRecordSingleSelection *)record;

@end

@implementation TMTestDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.curTestRecordIdx = 0;
        self.curRecordArray = [[TMTestRecordManager sharedManager].type2RecordArrayDict objectForKey:[NSNumber numberWithInt:RECORD_TYPE_SINGLE_SELECTION]];
        [self.curRecordArray enumerateObjectsUsingBlock:^(TMTestRecordSingleSelection *obj, NSUInteger idx, BOOL *stop) {
            obj.answered = NO;
        }];
        [TMTestRecordManager sharedManager].startAnswerTime = time(NULL);
        
        if (self.curRecordArray == nil)
        {
            return nil;
        }
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self.explainContentLabel sizeToFit];
    [self loadSingleSelectionRecord:self.curRecordArray[self.curTestRecordIdx]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)homeToolbarButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)textbookToolbarButtonClicked:(id)sender
{
    
}

- (IBAction)newsToolbarButtonClicked:(id)sender
{
    
}

- (IBAction)settingsToolbarButtonClicked:(id)sender
{
    
}

- (IBAction)optionAClicked:(id)sender
{
    TMTestRecordSingleSelection *record = self.curRecordArray[self.curTestRecordIdx];


    if (record.answered)
        return;
    
    record.answered = YES;
    record.selIdx = 0;

    [self loadSingleSelectionRecord:record];
    
    if (record.selIdx == record.rightIdx)
    {
        record.onceRighted = YES;
        [self doNext];
    }
}

- (IBAction)optionBClicked:(id)sender
{
    TMTestRecordSingleSelection *record = self.curRecordArray[self.curTestRecordIdx];


    if (record.answered)
        return;

    record.answered = YES;
    record.selIdx = 1;
    
    [self loadSingleSelectionRecord:record];
    
    if (record.selIdx == record.rightIdx)
    {
        record.onceRighted = YES;
        [self doNext];
    }
}

- (IBAction)optionCClicked:(id)sender
{
    TMTestRecordSingleSelection *record = self.curRecordArray[self.curTestRecordIdx];


    if (record.answered)
        return;
    
    record.answered = YES;
    record.selIdx = 2;
    
    [self loadSingleSelectionRecord:record];
    
    if (record.selIdx == record.rightIdx)
    {
        record.onceRighted = YES;
        [self doNext];
    }

}

- (IBAction)optionDClicked:(id)sender
{
    TMTestRecordSingleSelection *record = self.curRecordArray[self.curTestRecordIdx];


    if (record.answered)
        return;

    record.answered = YES;
    record.selIdx = 3;
    
    [self loadSingleSelectionRecord:record];
    
    if (record.selIdx == record.rightIdx)
    {
        record.onceRighted = YES;
        [self doNext];
    }
}

- (IBAction)previousButtonClicked:(id)sender
{
    if (self.curTestRecordIdx - 1 < 0)
    {
        return;
    }

    self.curTestRecordIdx -= 1;
    TMTestRecordSingleSelection *record =  self.curRecordArray[self.curTestRecordIdx];
    [self loadSingleSelectionRecord:record];
}

- (IBAction)nextButtonClicked:(id)sender
{
    [self doNext];
}

-(void)doNext
{
    TMTestRecordSingleSelection *record =  [self.curRecordArray objectAtIndex:self.curTestRecordIdx];
    if (!record.answered) {
        if ([record isRight])
            record.onceRighted = YES;

        record.selIdx = -1;
        record.answered = YES;
        if (!record.onceAnswered) {
            record.onceAnswered = YES;
        }
        [self loadSingleSelectionRecord:record];
        return;
    }
    if (self.curTestRecordIdx + 1 >= self.curRecordArray.count) {
//        UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:@"no more test"
//                                                             message:@"no more test"
//                                                            delegate:self
//                                                   cancelButtonTitle:@"知道了"
//                                                   otherButtonTitles:nil, nil];
//        [alertView show];
        [TMTestRecordManager sharedManager].finishAnswerTime = time(NULL);
        [[TMTestRecordManager sharedManager] doStatistics:([TMTestRecordManager sharedManager].finishAnswerTime-[TMTestRecordManager sharedManager].startAnswerTime)];
        TMScoreViewController *scoreViewController = [[TMScoreViewController alloc] initWithNibName:@"TMScoreViewController-ip5" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:scoreViewController animated:YES];

        return;
        
    }

    self.curTestRecordIdx += 1;
   
    record =  [self.curRecordArray objectAtIndex:self.curTestRecordIdx];
    [self loadSingleSelectionRecord:record];
}

- (void)loadSingleSelectionRecord:(TMTestRecordSingleSelection *)record
{
    self.questionLabel.text = record.body;
    
    [self.optionQuestionAButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionBButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionCButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionDButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    
    [self.optionMarkAButton setImage:[UIImage imageNamed:@"OptionMarkBlackA"] forState:UIControlStateNormal];
    [self.optionMarkBButton setImage:[UIImage imageNamed:@"OptionMarkBlackB"] forState:UIControlStateNormal];
    [self.optionMarkCButton setImage:[UIImage imageNamed:@"OptionMarkBlackC"] forState:UIControlStateNormal];
    [self.optionMarkDButton setImage:[UIImage imageNamed:@"OptionMarkBlackD"] forState:UIControlStateNormal];

    
    // 题目
    if (record.options.count > 3)
    {
        self.optionALabel.text = [record.options objectAtIndex:0];
        self.optionBLabel.text = [record.options objectAtIndex:1];
        self.optionCLabel.text = [record.options objectAtIndex:2];
        self.optionDLabel.text = [record.options objectAtIndex:3];
    }
    else if (record.options.count > 2)
    {
        self.optionMarkDButton.hidden = YES;
        self.optionDLabel.hidden = YES;
        self.optionQuestionDButton.hidden = YES;
        
        self.optionALabel.text = [record.options objectAtIndex:0];
        self.optionBLabel.text = [record.options objectAtIndex:1];
        self.optionCLabel.text = [record.options objectAtIndex:2];
    }
    else if (record.options.count > 1)
    {
        self.optionMarkCButton.hidden = YES;
        self.optionCLabel.hidden = YES;
        self.optionQuestionCButton.hidden = YES;
        
        self.optionMarkDButton.hidden = YES;
        self.optionDLabel.hidden = YES;
        self.optionQuestionDButton.hidden = YES;
        
        self.optionALabel.text = [record.options objectAtIndex:0];
        self.optionBLabel.text = [record.options objectAtIndex:1];
    }
    else if (record.options.count > 0)
    {
        self.optionMarkBButton.hidden = YES;
        self.optionBLabel.hidden = YES;
        self.optionQuestionBButton.hidden = YES;
        
        self.optionMarkCButton.hidden = YES;
        self.optionCLabel.hidden = YES;
        self.optionQuestionCButton.hidden = YES;
        
        self.optionMarkDButton.hidden = YES;
        self.optionDLabel.hidden = YES;
        self.optionQuestionDButton.hidden = YES;
        
        self.optionDLabel.text = [record.options objectAtIndex:0];
    }

    
    if (record.answered) //已经做过选择，显示上次的选择和答案
    {
        self.explainFrameImageView.hidden = NO;
        self.explainTitleLabel.hidden = NO;
        self.explainContentLabel.hidden = NO;
        self.explainLeadingLabel.hidden = NO;
        self.explainTitleLabel.text =  [NSString stringWithFormat:@"%c", 'A' + record.rightIdx] ;
        self.explainContentLabel.text = [NSString stringWithFormat:@"%@", [record.options objectAtIndex:record.rightIdx]];
        
        switch (record.selIdx)
        {
            case 0:
                [self.optionQuestionAButton setImage:[UIImage imageNamed:@"OptionBackWrong"] forState:UIControlStateNormal];
                [self.optionMarkAButton setImage:[UIImage imageNamed:@"OptionMarkWhiteA"] forState:UIControlStateNormal];
                break;
            case 1:
                [self.optionQuestionBButton setImage:[UIImage imageNamed:@"OptionBackWrong"] forState:UIControlStateNormal];
                [self.optionMarkBButton setImage:[UIImage imageNamed:@"OptionMarkWhiteB"] forState:UIControlStateNormal];
                break;
            case 2:
                [self.optionQuestionCButton setImage:[UIImage imageNamed:@"OptionBackWrong"] forState:UIControlStateNormal];
                [self.optionMarkCButton setImage:[UIImage imageNamed:@"OptionMarkWhiteC"] forState:UIControlStateNormal];
                break;
            case 3:
                [self.optionQuestionDButton setImage:[UIImage imageNamed:@"OptionBackWrong"] forState:UIControlStateNormal];
                [self.optionMarkDButton setImage:[UIImage imageNamed:@"OptionMarkWhiteD"] forState:UIControlStateNormal];
                break;
        }
        
        switch (record.rightIdx)
        {
            case 0:
                [self.optionQuestionAButton setImage:[UIImage imageNamed:@"OptionBackRight"] forState:UIControlStateNormal];
                [self.optionMarkAButton setImage:[UIImage imageNamed:@"OptionMarkWhiteA"] forState:UIControlStateNormal];
                break;
            case 1:
                [self.optionQuestionBButton setImage:[UIImage imageNamed:@"OptionBackRight"] forState:UIControlStateNormal];
                [self.optionMarkBButton setImage:[UIImage imageNamed:@"OptionMarkWhiteA"] forState:UIControlStateNormal];
                break;
            case 2:
                [self.optionQuestionCButton setImage:[UIImage imageNamed:@"OptionBackRight"] forState:UIControlStateNormal];
                [self.optionMarkCButton setImage:[UIImage imageNamed:@"OptionMarkWhiteA"] forState:UIControlStateNormal];
                break;
            case 3:
                [self.optionQuestionDButton setImage:[UIImage imageNamed:@"OptionBackRight"] forState:UIControlStateNormal];
                [self.optionMarkDButton setImage:[UIImage imageNamed:@"OptionMarkWhiteA"] forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
    }
    else
    {
        self.explainFrameImageView.hidden = YES;
        self.explainTitleLabel.hidden = YES;
        self.explainContentLabel.hidden = YES;
        self.explainLeadingLabel.hidden = YES;
    }
}

- (IBAction)submitButtonClicked:(id)sender
{
    [TMTestRecordManager sharedManager].finishAnswerTime = time(NULL);
    [[TMTestRecordManager sharedManager] doStatistics:([TMTestRecordManager sharedManager].finishAnswerTime-[TMTestRecordManager sharedManager].startAnswerTime)];


    // 本次
    TMScoreViewController *scoreViewController = [[TMScoreViewController alloc] initWithNibName:@"TMScoreViewController-ip5" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:scoreViewController animated:YES];

}

- (IBAction)undoneButtonClicked:(id)sender
{
    
}

- (IBAction)counterButtonClicked:(id)sender
{
    
}

@end
