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
    
}

- (IBAction)nextButtonClicked:(id)sender
{
    
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
