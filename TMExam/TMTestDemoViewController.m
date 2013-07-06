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
@property (nonatomic, readwrite) TMTestRecordSingleSelection  *curTestRecord;
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
    self.questionLabel.font    = [UIFont systemFontOfSize: 14];
//    self.questionLabel.textAlignment = NSTextAlignmentLeft;
//    self.questionLabel.baselineAdjustment = NSWritingDirectionRightToLeft;
    [self.questionLabel sizeToFit];
    self.optionALabel.textAlignment = NSTextAlignmentCenter;
    self.optionBLabel.textAlignment = NSTextAlignmentCenter;
    self.optionCLabel.textAlignment = NSTextAlignmentCenter;
    self.optionDLabel.textAlignment = NSTextAlignmentCenter;
    [self.explainContentLabel sizeToFit];

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

//    self.curSel = 0;
    self.curTestRecord.selIdx = 0;
    [self.optionQuestionAButton setImage:[UIImage imageNamed:@"OptionBackWrong"] forState:UIControlStateNormal];
    [self.optionQuestionBButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionCButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionDButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];

    [self.optionMarkAButton setImage:[UIImage imageNamed:@"OptionMarkWhiteA"] forState:UIControlStateNormal];
    [self.optionMarkBButton setImage:[UIImage imageNamed:@"OptionMarkBlackB"] forState:UIControlStateNormal];
    [self.optionMarkCButton setImage:[UIImage imageNamed:@"OptionMarkBlackC"] forState:UIControlStateNormal];
    [self.optionMarkDButton setImage:[UIImage imageNamed:@"OptionMarkBlackD"] forState:UIControlStateNormal];
    [self doNext];

}

- (IBAction)optionBClicked:(id)sender
{
    if (self.answerWrong) {
        return;
    }

//    self.curSel = 1;
        self.curTestRecord.selIdx = 1;
    [self.optionQuestionAButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionBButton setImage:[UIImage imageNamed:@"OptionBackWrong"] forState:UIControlStateNormal];
    [self.optionQuestionCButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionDButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    
    [self.optionMarkAButton setImage:[UIImage imageNamed:@"OptionMarkBlackA"] forState:UIControlStateNormal];
    [self.optionMarkBButton setImage:[UIImage imageNamed:@"OptionMarkWhiteB"] forState:UIControlStateNormal];
    [self.optionMarkCButton setImage:[UIImage imageNamed:@"OptionMarkBlackC"] forState:UIControlStateNormal];
    [self.optionMarkDButton setImage:[UIImage imageNamed:@"OptionMarkBlackD"] forState:UIControlStateNormal];
    
    [self doNext];

}

- (IBAction)optionCClicked:(id)sender
{
    if (self.answerWrong) {
        return;
    }

//    self.curSel = 2;
        self.curTestRecord.selIdx = 2;
    [self.optionQuestionAButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionBButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionCButton setImage:[UIImage imageNamed:@"OptionBackWrong"] forState:UIControlStateNormal];
    [self.optionQuestionDButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];

    [self.optionMarkAButton setImage:[UIImage imageNamed:@"OptionMarkBlackA"] forState:UIControlStateNormal];
    [self.optionMarkBButton setImage:[UIImage imageNamed:@"OptionMarkBlackB"] forState:UIControlStateNormal];
    [self.optionMarkCButton setImage:[UIImage imageNamed:@"OptionMarkWhiteC"] forState:UIControlStateNormal];
    [self.optionMarkDButton setImage:[UIImage imageNamed:@"OptionMarkBlackD"] forState:UIControlStateNormal];
    
    [self doNext];

}

- (IBAction)optionDClicked:(id)sender
{
    if (self.answerWrong) {
        return;
    }

//    self.curSel = 3;
        self.curTestRecord.selIdx = 3;
    [self.optionQuestionAButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionBButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionCButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionDButton setImage:[UIImage imageNamed:@"OptionBackWrong"] forState:UIControlStateNormal];
    
    [self.optionMarkAButton setImage:[UIImage imageNamed:@"OptionMarkBlackA"] forState:UIControlStateNormal];
    [self.optionMarkBButton setImage:[UIImage imageNamed:@"OptionMarkBlackB"] forState:UIControlStateNormal];
    [self.optionMarkCButton setImage:[UIImage imageNamed:@"OptionMarkBlackC"] forState:UIControlStateNormal];
    [self.optionMarkDButton setImage:[UIImage imageNamed:@"OptionMarkWhiteD"] forState:UIControlStateNormal];
    
    [self doNext];

}

- (IBAction)previousButtonClicked:(id)sender
{
    return;
    if (self.curTestRecordIdx == 0) {
        UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:@"no more test"
                                                             message:@"no more test"
                                                            delegate:self
                                                   cancelButtonTitle:@"知道了"
                                                   otherButtonTitles:nil, nil];
        [alertView show];
        [[TMTestRecordManager sharedManager] doStatistics];
        return;
    }

    TMTestRecordSingleSelection *record =  [self.curRecordArray objectAtIndex:--self.curTestRecordIdx];
    [self loadTestRecord];
    if (record.isRight  )
    { // 选择正确
        // 还原正确的选择界面
    }
    else
    { // 选择错误, 还原错误选择界面

        self.explainFrameImageView.hidden = NO;
        self.explainTitleLabel.hidden = NO;
        self.explainContentLabel.hidden = NO;
        self.explainTitleLabel.text =  [NSString stringWithFormat:@"正确答案是: %c", 'A' + record.rightIdx] ;
        self.explainContentLabel.text = [NSString stringWithFormat:@"%@", [record.options objectAtIndex:record.rightIdx]];
        self.answerWrong = YES;
    }


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
    [self doNext];
    
}

-(void)doNext
{
    TMTestRecordSingleSelection *record =  [self.curRecordArray objectAtIndex:self.curTestRecordIdx];
    if (record.selIdx == record.rightIdx  || self.answerWrong)
    { // 选择正确, 或者已经 认定 错误答案
        ++self.curTestRecordIdx;
        // 判断是否结束
        self.answerWrong = NO;
        [self loadTestRecord];
    }
    else
    { // 选择错误
        
        switch (record.rightIdx)
        {
            case 0:
                [self.optionQuestionAButton setImage:[UIImage imageNamed:@"OptionBackRight"] forState:UIControlStateNormal];
                [self.optionMarkAButton setImage:[UIImage imageNamed:@"OptionMarkWhiteA"] forState:UIControlStateNormal];
                break;
            case 1:
                [self.optionQuestionBButton setImage:[UIImage imageNamed:@"OptionBackRight"] forState:UIControlStateNormal];
                [self.optionMarkBButton setImage:[UIImage imageNamed:@"OptionMarkWhiteB"] forState:UIControlStateNormal];
                break;
            case 2:
                [self.optionQuestionCButton setImage:[UIImage imageNamed:@"OptionBackRight"] forState:UIControlStateNormal];
                [self.optionMarkCButton setImage:[UIImage imageNamed:@"OptionMarkWhiteC"] forState:UIControlStateNormal];
                break;
            case 3:
                [self.optionQuestionDButton setImage:[UIImage imageNamed:@"OptionBackRight"] forState:UIControlStateNormal];
                [self.optionMarkDButton setImage:[UIImage imageNamed:@"OptionMarkWhiteD"] forState:UIControlStateNormal];
                break;
        }
        
        self.explainFrameImageView.hidden = NO;
        self.explainTitleLabel.hidden = NO;
        self.explainContentLabel.hidden = NO;
        self.explainTitleLabel.text =  [NSString stringWithFormat:@"正确答案是: %c", 'A' + record.rightIdx] ;
        
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.explainTitleLabel.attributedText];
        [text addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:0.1216 green:0.608 blue:0.228 alpha:1] range: NSMakeRange(7, 1)];
        [self.explainTitleLabel setAttributedText: text];
        self.explainContentLabel.text = [NSString stringWithFormat:@"%@", [record.options objectAtIndex:record.rightIdx]];
        self.answerWrong = YES;
    }

}
-(void )loadTestRecord
{
    
    TMTestRecordSingleSelection *record =  [self.curRecordArray objectAtIndex:self.curTestRecordIdx];
    self.curTestRecord = record;
    self.questionLabel.text = record.body;
    
    // 答案
    self.explainTitleLabel.hidden = YES;
    self.explainContentLabel.hidden = YES;
    self.explainFrameImageView.hidden = YES;
    
    [self.optionQuestionAButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionBButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionCButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];
    [self.optionQuestionDButton setImage:[UIImage imageNamed:@"OptionBackNormal"] forState:UIControlStateNormal];

    [self.optionMarkAButton setImage:[UIImage imageNamed:@"OptionMarkBlackA"] forState:UIControlStateNormal];
    [self.optionMarkBButton setImage:[UIImage imageNamed:@"OptionMarkBlackB"] forState:UIControlStateNormal];
    [self.optionMarkCButton setImage:[UIImage imageNamed:@"OptionMarkBlackC"] forState:UIControlStateNormal];
    [self.optionMarkDButton setImage:[UIImage imageNamed:@"OptionMarkBlackD"] forState:UIControlStateNormal];

    self.optionMarkAButton.hidden = NO;
    self.optionMarkBButton.hidden = NO;
    self.optionMarkCButton.hidden = NO;
    self.optionMarkDButton.hidden = NO;
    
    self.optionALabel.hidden = NO;
    self.optionBLabel.hidden = NO;
    self.optionCLabel.hidden = NO;
    self.optionDLabel.hidden = NO;
    
    self.optionQuestionAButton.hidden = NO;
    self.optionQuestionBButton.hidden = NO;
    self.optionQuestionCButton.hidden = NO;
    self.optionQuestionDButton.hidden = NO;
    
    
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
