//
//  TMScoreViewControllerStatistics.m
//  TMExam
//
//  Created by zhang zhenfang on 13-7-15.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMScoreViewControllerStatistics.h"
#import "TMTestRecordManager.h"
#import "TMTestResult.h"
#import "PCPieChart.h"
#import "PCLineChartView.h"
#import "TMTestRecord.h"
#import "TBViewController.h"
#import "TMNewsViewController.h"

@interface TMScoreViewControllerStatistics()
@property (nonatomic, strong) PCPieChart *pieChart;
@property (nonatomic, strong) PCLineChartView *lineChart;
@end

@implementation TMScoreViewControllerStatistics
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
    [self loadPercent];
    [self.percentBtn setImage:[UIImage imageNamed:@"x77--y865"] forState:UIControlStateNormal];
    
    [self.anserCntBtn setImage:[UIImage imageNamed:@"灰色_08"] forState:UIControlStateNormal];

    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
}

-(void)loadAnswerTime
{
    self.pieChart.hidden = YES;
    self.percentBack.hidden = YES;
    self.anserCntBack.hidden = YES;


    if (self.lineChart != nil && self.lineChart.hidden == NO) {
        return;
    }
    self.lineChart = [[PCLineChartView alloc] initWithFrame:CGRectMake(25,150,[self.view bounds].size.width-30,[self.view bounds].size.height-230)];
    [self.lineChart setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    self.lineChart.minValue = 0;
    self.lineChart.maxValue = 100;
    [self.view addSubview:self.lineChart];
    
    NSMutableDictionary *sampleInfo = [[NSMutableDictionary alloc] initWithCapacity:10];
    NSMutableArray *timesArray = [[NSMutableArray alloc ] initWithCapacity:10];

    NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:10]; // dic 的数组, 每个dict有一个 array 的data, 一个string的title
    
    // data的一个entry
    NSMutableDictionary *dataEntry = [[NSMutableDictionary alloc] initWithCapacity:2];
    // entry中data部分, 即每次的正确个数
    NSMutableArray *dataEntryData = [[NSMutableArray alloc] initWithCapacity:2];
    [dataEntry setObject: dataEntryData forKey:@"data"];
    int k = 1;
    for (NSDictionary *dict in [TMTestRecordManager sharedManager].testResultInfoArray)
    {
        TMTestResult *result = [[TMTestResult alloc] initWithDict:dict];
        [dataEntryData addObject:[NSNumber numberWithInt:result.rightCnt]];
        [timesArray addObject:[NSString stringWithFormat:@"%d",k]];
        ++k;
    }
    // title
    [dataEntry setObject:@"" forKey:@"title"];
    // 装配data
    [data addObject:dataEntry];
    
    // 装配 sampleInfo

    [sampleInfo setObject:data forKey:@"data"];
    [sampleInfo setObject:timesArray forKey:@"x_labels"];
    

    NSMutableArray *components = [NSMutableArray array];
    for (int i=0; i<[[sampleInfo objectForKey:@"data"] count]; i++)
    {
        NSDictionary *point = [[sampleInfo objectForKey:@"data"] objectAtIndex:i];
        PCLineChartViewComponent *component = [[PCLineChartViewComponent alloc] init];
        [component setTitle:[point objectForKey:@"title"]];
        [component setPoints:[point objectForKey:@"data"]];
        [component setShouldLabelValues:NO];
        
        if (i==0)
        {
            [component setColour:PCColorYellow];
        }
        else if (i==1)
        {
            [component setColour:PCColorGreen];
        }
        else if (i==2)
        {
            [component setColour:PCColorOrange];
        }
        else if (i==3)
        {
            [component setColour:PCColorRed];
        }
        else if (i==4)
        {
            [component setColour:PCColorBlue];
        }
        
        [components addObject:component];
    }
    [self.lineChart setComponents:components];
    [self.lineChart setXLabels:[sampleInfo objectForKey:@"x_labels"]];
//     */
}

-(void)loadPercent
{
    self.percentBack.hidden = YES;
    self.lineChart.hidden = YES;
    self.anserCntBack.hidden = YES;

    int n = [[TMTestRecordManager sharedManager] testResultInfoArray].count;
    if (n <= 0) {
        return;
    }
    
    if (self.pieChart != nil && self.pieChart.hidden == NO) {
        return;
    }
    


//    NSDictionary *testResultsDict = [[[TMTestRecordMa nager sharedManager] testResultInfoArray] objectAtIndex:n-1];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:10];
    NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:10];
    [dict setObject:data forKey:@"data"];
    NSMutableDictionary *record = [[NSMutableDictionary alloc] initWithCapacity:2];
    // 找正确, 错误, 未答题目的方式1,
    int totalRight = 0;
    int totalWrong = 0;
    int totalNone = 0;
    NSArray *array = [[TMTestRecordManager sharedManager].type2RecordArrayDict objectForKey:[NSNumber numberWithInt:RECORD_TYPE_SINGLE_SELECTION]];

    for (TMTestRecord *record in array)
    {
        if (![record answered]) {
            ++totalNone;
            continue;
        }
        if ([record onceRighted])
            ++totalRight;
        else
            ++totalWrong;
    }

    // 正确

    [record setObject:@"正确题目" forKey:@"title"];
    [record setObject:[NSNumber numberWithInt:totalRight] forKey:@"value"];
    [data addObject:record];
    // 错误
    record = [[NSMutableDictionary alloc] initWithCapacity:2];
    [record setObject:@"错误题目" forKey:@"title"];
    [record setObject:[NSNumber numberWithInt:totalWrong+totalNone] forKey:@"value"];
    [data addObject:record];
//    // 未答题
//    [record setObject:@"未做题目" forKey:@"title"];
//    [record setObject:[NSNumber numberWithInt:totalNone] forKey:@"value"];
//    [data addObject:record];

    
    
    [self initWithDict:dict];
    
}

- (void)initWithDict:(NSDictionary*)sampleInfo
{

    int height = [self.view bounds].size.width/3*3.; // 220;
    int width = [self.view bounds].size.width/3*2.8; //320;
    self.pieChart = [[PCPieChart alloc] initWithFrame:CGRectMake(([self.view bounds].size.width-width)/10,([self.view bounds].size.height-height)/2,width,height)];
    [self.pieChart setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [self.pieChart setDiameter:width/2];
    [self.pieChart setSameColorLabel:YES];
    [self.pieChart setShowArrow:NO];

    
    [self.view addSubview:self.pieChart];


    
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad)
    {
        self.pieChart.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30];
        self.pieChart.percentageFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:50];
    }
    
    NSMutableArray *components = [NSMutableArray array];
    for (int i=0; i<[[sampleInfo objectForKey:@"data"] count]; i++)
    {
        NSDictionary *item = [[sampleInfo objectForKey:@"data"] objectAtIndex:i];
        PCPieComponent *component = [PCPieComponent pieComponentWithTitle:[item objectForKey:@"title"] value:[[item objectForKey:@"value"] floatValue]];
        [components addObject:component];
        
        if (i==0)
        {
            [component setColour:PCColorYellow];
        }
        else if (i==1)
        {
            [component setColour:PCColorGreen];
        }
        else if (i==2)
        {
            [component setColour:PCColorOrange];
        }
        else if (i==3)
        {
            [component setColour:PCColorRed];
        }
        else if (i==4)
        {
            [component setColour:PCColorBlue];
        }
    }
    [self.pieChart setComponents:components];
    
}

- (IBAction)percentButtonClicked:(id)sender
{
    if (self.pieChart.hidden == NO) {
        return;
    }
    [self loadPercent];

    [self.percentBtn setImage:[UIImage imageNamed:@"x77--y865"] forState:UIControlStateNormal];

    [self.anserCntBtn setImage:[UIImage imageNamed:@"灰色_08"] forState:UIControlStateNormal];
}

- (IBAction)anserCnttonClicked:(id)sender
{
    [self loadAnswerTime];
//    [self.anserCntBtn  setImage:[UIImage imageNamed:@"x319--y865"] forState:UIControlStateSelected];
    [self.anserCntBtn  setImage:[UIImage imageNamed:@"x319--y865"] forState:UIControlStateNormal];

    [self.percentBtn setImage:[UIImage imageNamed:@"灰色_07"] forState:UIControlStateNormal];

}

- (IBAction)homeToolbarButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)newsToolbarButtonClicked:(id)sender
{
    TMNewsViewController *newViewController = [[TMNewsViewController alloc] initWithNibName:@"TMNewsViewController-ip5" bundle:nil];
    [self.navigationController pushViewController:newViewController animated:YES];
}


@end
