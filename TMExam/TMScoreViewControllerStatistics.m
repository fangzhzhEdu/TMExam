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
        [self loadPercent];
    }
    
    return self;
}

-(void)loadAnswerTime
{
    
    /*{
     "data": [
     {
     "data": [
     null,
     null,
     30,
     45,
     69,
     70
     ],
     "title": "Smith"
     } ],
     "x_labels": [
     2006,
     2007,
     2008,
     2009,
     2010,
     2011
     ]
     }*/
//    /*
    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [self setTitle:@"Line Chart"];
    
    self.lineChart = [[PCLineChartView alloc] initWithFrame:CGRectMake(10,10,[self.view bounds].size.width-20,[self.view bounds].size.height-20)];
    [self.lineChart setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    self.lineChart.minValue = -40;
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
        [timesArray addObject:[NSNumber numberWithInt:k]];
        ++k;
    }
    // title
    [dataEntry setObject:@"正确题目" forKey:@"title"];

    // 装配 sampleInfo
    [data addObject:dataEntry];
    [sampleInfo setObject:data forKey:@"data"];
    [sampleInfo setObject:timesArray forKey:@"x_lables"];
    

    
    NSMutableArray *xLable = [[NSMutableArray alloc] initWithCapacity:1]; // 数字的 数组
    
    [sampleInfo setObject:data forKey:@"data"];
    [sampleInfo setObject:xLable forKey:@"x_labels"];

    
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
    int n = [[TMTestRecordManager sharedManager] testResultInfoArray].count;
    if (n <= 0) {
        return;
    }
    NSDictionary *testResultsDict = [[[TMTestRecordManager sharedManager] testResultInfoArray] objectAtIndex:n-1];
    TMTestResult *result = [[TMTestResult alloc] initWithDict:testResultsDict];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:10];
    NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:10];
    [dict setObject:data forKey:@"data"];
    NSMutableDictionary *record = [[NSMutableDictionary alloc] initWithCapacity:2];
    [record setObject:@"正确题目" forKey:@"title"];
    [record setObject:[NSNumber numberWithInt:result.rightCnt] forKey:@"value"];
    [data addObject:record];
    
    record = [[NSMutableDictionary alloc] initWithCapacity:2];
    [record setObject:@"错误题目" forKey:@"title"];
    [record setObject:[NSNumber numberWithInt:result.answeredCnt-result.rightCnt] forKey:@"value"];
    [data addObject:record];
    
    [self initWithDict:dict];
    
}

- (void)initWithDict:(NSDictionary*)sampleInfo
{
    self.title =  @"成绩统计";
    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    
    
    int height = [self.view bounds].size.width/3*2.; // 220;
    int width = [self.view bounds].size.width; //320;
    self.pieChart = [[PCPieChart alloc] initWithFrame:CGRectMake(([self.view bounds].size.width-width)/2,([self.view bounds].size.height-height)/2,width,height)];
    [self.pieChart setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [self.pieChart setDiameter:width/2];
    [self.pieChart setSameColorLabel:YES];
    
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
    [self loadPercent];
    [self.percentBtn setImage:[UIImage imageNamed:@"x77--y865"] forState:UIControlStateSelected];
    [self.percentBtn setImage:[UIImage imageNamed:@"x77--y865"] forState:UIControlStateNormal];

    [self.anserCntBtn setImage:[UIImage imageNamed:@"灰色_08"] forState:UIControlStateNormal];
}

- (IBAction)anserCnttonClicked:(id)sender
{
    [self loadAnswerTime];
    [self.anserCntBtn  setImage:[UIImage imageNamed:@"x319--y865"] forState:UIControlStateSelected];
    [self.anserCntBtn  setImage:[UIImage imageNamed:@"x319--y865"] forState:UIControlStateNormal];

    [self.percentBtn setImage:[UIImage imageNamed:@"灰色_07"] forState:UIControlStateNormal];

}



@end
