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

@interface TMTestDemoViewController ()
@property (nonatomic, readwrite) NSInteger curTestRecordIdx;
@property (nonatomic, readwrite) NSInteger curSel;
@property (nonatomic, weak) NSArray *curRecordArray;        // 当前类型试题的数组
@property (nonatomic, readwrite)BOOL answerWrong;
@end

@implementation TMTestDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.curRecordArray = [[TMTestRecordManager sharedManager].type2RecordArrayDict objectForKey:[NSNumber numberWithInt:RECORD_TYPE_SINGLE_SELECTION]];
    [self loadTestRecord];
    self.answerWrong = NO;
    if (self.curRecordArray == nil)
    {
        return;
    }

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
    if (self.answerWrong) {
        return;
    }
    self.optionMarkAButton.hidden = YES;
    self.optionMarkBButton.hidden = YES;
    self.optionMarkCButton.hidden = YES;
    self.optionMarkDButton.hidden = YES;

    self.curSel = 0;
    self.optionMarkAButton.hidden = NO;

}

- (IBAction)optionBClicked:(id)sender
{
    if (self.answerWrong) {
        return;
    }

    self.optionMarkAButton.hidden = YES;
    self.optionMarkBButton.hidden = YES;
    self.optionMarkCButton.hidden = YES;
    self.optionMarkDButton.hidden = YES;

    self.curSel = 1;
    self.optionMarkBButton.hidden = NO;
}

- (IBAction)optionCClicked:(id)sender
{
    if (self.answerWrong) {
        return;
    }

    self.optionMarkAButton.hidden = YES;
    self.optionMarkBButton.hidden = YES;
    self.optionMarkCButton.hidden = YES;
    self.optionMarkDButton.hidden = YES;

    self.curSel = 2;
    self.optionMarkCButton.hidden = NO;
}

- (IBAction)optionDClicked:(id)sender
{
    if (self.answerWrong) {
        return;
    }

    self.optionMarkAButton.hidden = YES;
    self.optionMarkBButton.hidden = YES;
    self.optionMarkCButton.hidden = YES;
    self.optionMarkDButton.hidden = YES;

    self.curSel = 3;
    self.optionMarkDButton.hidden = NO;
}

- (IBAction)previousButtonClicked:(id)sender
{
    TMTestRecordSingleSelection *record =  [self.curRecordArray objectAtIndex:self.curTestRecordIdx];
    self.questionLabel.text = record.body;
    self.optionALabel.text = [record.options objectAtIndex:0];
    self.optionBLabel.text = [record.options objectAtIndex:1];
    self.optionCLabel.text = [record.options objectAtIndex:2];
    self.optionDLabel.text = [record.options objectAtIndex:3];
}

- (IBAction)nextButtonClicked:(id)sender
{
    if (self.curTestRecordIdx == self.curRecordArray.count) {
        UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:@"no more test"
                                                             message:@"no more test"
                                                            delegate:self
                                                   cancelButtonTitle:@"知道了"
                                                   otherButtonTitles:nil, nil];
        [alertView show];
        [[TMTestRecordManager sharedManager] doStatistics];
        return;
    }
    TMTestRecordSingleSelection *record =  [self.curRecordArray objectAtIndex:self.curTestRecordIdx];
    if (self.curSel == record.rightIdx  || self.answerWrong)
    { // 选择正确, 或者已经 认定 错误答案
        ++self.curTestRecordIdx;
        // 判断是否结束
        self.answerWrong = NO;
        [self loadTestRecord];
    }
    else
    { // 选择错误
        self.explainFrameImageView.hidden = NO;
        self.explainTitleLabel.hidden = NO;
        self.explainContentLabel.hidden = NO;
        self.explainTitleLabel.text =  [NSString stringWithFormat:@"正确答案是: %c", 'A' + record.rightIdx] ;
        self.explainContentLabel.text = [NSString stringWithFormat:@"%@", [record.options objectAtIndex:record.rightIdx]];
        self.answerWrong = YES;

    }
}
    
-(void )loadTestRecord
{
    TMTestRecordSingleSelection *record =  [self.curRecordArray objectAtIndex:self.curTestRecordIdx];
    self.questionLabel.text = record.body;
    
    // 答案
    self.explainTitleLabel.hidden = YES;
    self.explainContentLabel.hidden = YES;
    self.explainFrameImageView.hidden = YES;
    
    // 题目
    if (record.options.count > 3)
    {
        self.optionMarkAButton.hidden = YES;
        self.optionMarkBButton.hidden = YES;
        self.optionMarkCButton.hidden = YES;
        self.optionMarkDButton.hidden = YES;

        self.optionALabel.text = [record.options objectAtIndex:0];
        self.optionBLabel.text = [record.options objectAtIndex:1];
        self.optionCLabel.text = [record.options objectAtIndex:2];
        self.optionDLabel.text = [record.options objectAtIndex:3];
    }
    else if (record.options.count > 2)
    {
        self.optionMarkAButton.hidden = YES;
        self.optionMarkBButton.hidden = YES;
        self.optionMarkCButton.hidden = YES;
        self.optionMarkDButton.hidden = YES;

        self.optionALabel.text = [record.options objectAtIndex:0];
        self.optionBLabel.text = [record.options objectAtIndex:1];
        self.optionCLabel.text = [record.options objectAtIndex:2];

        self.optionQuestionDButton.hidden = YES;
        self.optionDLabel.hidden = YES;
    }
    else if (record.options.count > 1)
    {
        self.optionMarkAButton.hidden = YES;
        self.optionMarkBButton.hidden = YES;
        self.optionMarkCButton.hidden = YES;
        self.optionMarkDButton.hidden = YES;

        self.optionALabel.text = [record.options objectAtIndex:0];
        self.optionBLabel.text = [record.options objectAtIndex:1];
        
        self.optionQuestionDButton.hidden = YES;
        self.optionDLabel.hidden = YES;

        self.optionQuestionCButton.hidden = YES;
        self.optionCLabel.hidden = YES;

    }
    else if (record.options.count > 0)
    {
        self.optionMarkAButton.hidden = YES;
        self.optionMarkBButton.hidden = YES;
        self.optionMarkCButton.hidden = YES;
        self.optionMarkDButton.hidden = YES;

        self.optionDLabel.text = [record.options objectAtIndex:0];
        
        self.optionQuestionDButton.hidden = YES;
        self.optionDLabel.hidden = YES;
        
        self.optionQuestionCButton.hidden = YES;
        self.optionCLabel.hidden = YES;
        
        self.optionQuestionBButton.hidden = YES;
        self.optionBLabel.hidden = YES;

    }
}

- (IBAction)submitButtonClicked:(id)sender
{
    
}

- (IBAction)undoneButtonClicked:(id)sender
{
    
}

- (IBAction)counterButtonClicked:(id)sender
{
    
}

@end
