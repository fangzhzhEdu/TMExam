//
//  TMScoreViewController.m
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-6-29.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMScoreViewController.h"
#import "PCPieChart.h"
#import "TMTestRecordManager.h"
#import "TMTestResult.h"
@interface TMScoreViewController ()

@end

@implementation TMScoreViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        int n = [[TMTestRecordManager sharedManager] testResultInfoArray].count;
        if (n <= 0) {
            return self;
        }
        
        TMTestResult *result = nil;
        result = [[[TMTestRecordManager sharedManager] testResultInfoArray] objectAtIndex:n-1];
        
        // 答题时间
        
        // 正确统计
        
        // 正确率
        
        
        // 答题次数统计
        
        
        // 称号
        
        // 每一个题目
    }
    
    return self;
}

- (id)initWithDict:(NSDictionary*)sampleInfo
{
    self = [super init];
    if (self)
    {
        self.title =  @"成绩统计";
        [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
		
		
		int height = [self.view bounds].size.width/3*2.; // 220;
		int width = [self.view bounds].size.width; //320;
		PCPieChart *pieChart = [[PCPieChart alloc] initWithFrame:CGRectMake(([self.view bounds].size.width-width)/2,([self.view bounds].size.height-height)/2,width,height)];
		[pieChart setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
		[pieChart setDiameter:width/2];
		[pieChart setSameColorLabel:YES];
		
		[self.view addSubview:pieChart];
		
		if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad)
		{
			pieChart.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30];
			pieChart.percentageFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:50];
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
		[pieChart setComponents:components];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


@end
