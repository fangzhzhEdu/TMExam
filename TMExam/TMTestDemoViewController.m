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
@property (nonatomic, weak) NSArray *curRecordArray;        // 当前类型试题的数组
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
    
}

- (IBAction)optionBClicked:(id)sender
{
    
}

- (IBAction)optionCClicked:(id)sender
{
    
}

- (IBAction)optionDClicked:(id)sender
{
    
}

- (IBAction)previousButtonClicked:(id)sender
{
    TMTestRecordSingleSelection *record =  [self.curRecordArray objectAtIndex:--self.curTestRecordIdx];
    self.questionLabel.text = record.body;
    self.optionALabel.text = [record.options objectAtIndex:0];
    self.optionBLabel.text = [record.options objectAtIndex:1];
    self.optionCLabel.text = [record.options objectAtIndex:2];
    self.optionDLabel.text = [record.options objectAtIndex:3];
}

- (IBAction)nextButtonClicked:(id)sender
{
    ++self.curTestRecordIdx;
    [self loadTestRecord];
}
     
-(void )loadTestRecord
{
    TMTestRecordSingleSelection *record =  [self.curRecordArray objectAtIndex:self.curTestRecordIdx];
    self.questionLabel.text = record.body;
    
    if (record.options.count > 3)
    {
        self.optionALabel.text = [record.options objectAtIndex:0];
        self.optionBLabel.text = [record.options objectAtIndex:1];
        self.optionCLabel.text = [record.options objectAtIndex:2];
        self.optionDLabel.text = [record.options objectAtIndex:3];
    }
    else if (record.options.count > 2)
    {
        self.optionALabel.text = [record.options objectAtIndex:0];
        self.optionBLabel.text = [record.options objectAtIndex:1];
        self.optionCLabel.text = [record.options objectAtIndex:2];
        self.optionDLabel.hidden = YES;
        self.optionMarkDButton.hidden = YES;
    }
    else if (record.options.count > 1)
    {
        self.optionALabel.text = [record.options objectAtIndex:0];
        self.optionBLabel.text = [record.options objectAtIndex:1];
        self.optionDLabel.hidden = YES;
        self.optionDLabel.hidden = YES;

    }
    else if (record.options.count > 0)
    {
        self.optionDLabel.text = [record.options objectAtIndex:3];
        self.optionDLabel.hidden = YES;
        self.optionDLabel.hidden = YES;
        self.optionDLabel.hidden = YES;

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
