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
#import "TMTestRecord.h"
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
    int n = [[TMTestRecordManager sharedManager] testResultInfoArray].count;

    NSDictionary *dict = [[[TMTestRecordManager sharedManager] testResultInfoArray] objectAtIndex:n-1];
    TMTestResult *result = [[TMTestResult alloc] initWithDict:dict];
    
    long duration = result.testDuration;
    int minutes = duration / 60;
    int seconds = duration % 60;
    
    int decimal = minutes / 10;
    int unit = minutes  % 10;
    
    NSString *imageName = nil;
    UIImage *image = nil;
    
    // 答题时间
    if (decimal != 0) {
        imageName =  [NSString stringWithFormat:@"%d_06", decimal];
        image = [UIImage imageNamed:imageName];
        [self.time0 setImage:image];
    }
    if (unit != 0) {
        imageName =  [NSString stringWithFormat:@"%d_06", unit];
        image = [UIImage imageNamed:imageName];
        [self.time1 setImage:image];
    }
    
    decimal = seconds / 10;
    unit = seconds  % 10;
    

    if (decimal != 0) {
        imageName =  [NSString stringWithFormat:@"%d_06", decimal];
        image = [UIImage imageNamed:imageName];
        [self.time2 setImage:image];
    }
    
    imageName =  [NSString stringWithFormat:@"%d_06", unit];
    image = [UIImage imageNamed:imageName];
    [self.time3 setImage:image];
    
    
    //  正确统计
    decimal = result.answeredCnt / 10;
    unit = result.answeredCnt % 10;
    
    if (decimal != 0) {

        imageName = [NSString stringWithFormat:@"%d_14", decimal];
        [self.statistics2 setImage:[UIImage imageNamed:imageName]];
    }
    imageName = [NSString stringWithFormat:@"%d_14", unit];
    [self.statistics3 setImage:[UIImage imageNamed:imageName]];

    decimal = result.rightCnt / 10;
    unit = result.rightCnt % 10;
    
        if (decimal != 0) {
            imageName = [NSString stringWithFormat:@"%d_14", decimal];
            [self.statistics0 setImage:[UIImage imageNamed:imageName]];
        }
    imageName = [NSString stringWithFormat:@"%d_14", unit];
    [self.statistics1 setImage:[UIImage imageNamed:imageName]];
    
    
    // 正确率
    int percent = result.rightCnt * 100 / result.answeredCnt ;
    decimal = percent / 10;
    unit = percent % 10;
    if (decimal < 10) {
        self.testPercent2.hidden = YES;
    }
    if (decimal != 0) {
        imageName = [NSString stringWithFormat:@"%d_10", decimal];
        [self.testPercent0 setImage:[UIImage imageNamed:imageName]];
    }
    imageName = [NSString stringWithFormat:@"%d_10", unit];
    [self.testPercent1 setImage:[UIImage imageNamed:imageName]];

    // 称号
    if (percent < 60)
        [self.honorTitle setImage:[UIImage imageNamed:@"60以下_06"]];
    else if(percent >= 60 && percent < 85)
        [self.honorTitle setImage:[UIImage imageNamed:@"60以上--x318--435"]];
    else if(percent >= 85 && percent < 95)
        [self.honorTitle setImage:[UIImage imageNamed:@"85以上_06"]];
    else if(percent >= 95 )
        [self.honorTitle setImage:[UIImage imageNamed:@"95以上_06"]];


    
    // 答题次数统计
    decimal = n / 10;
    unit = n % 10;

    if (decimal != 0) {
        imageName = [NSString stringWithFormat:@"%d_23", decimal];
        [self.testTimes0  setImage:[UIImage imageNamed:imageName]];
    }
    
    imageName = [NSString stringWithFormat:@"%d_23", unit];
    [self.testTimes1 setImage:[UIImage imageNamed:imageName]];
    
    
    // 每一个题目
    self.testRecordArray = [[NSMutableArray alloc] initWithObjects:
        self.testRecord0,
        self.testRecord1,
        self.testRecord2,
        self.testRecord3,
        self.testRecord4,
        self.testRecord5,
        self.testRecord6,
        self.testRecord7,
        self.testRecord8,
        self.testRecord9,
        self.testRecord10,
        self.testRecord11,
        self.testRecord12,
        self.testRecord13,
        self.testRecord14,
        self.testRecord15,
        self.testRecord16,
        self.testRecord17,
        self.testRecord18,
        self.testRecord19,
        self.testRecord20,
        self.testRecord21,
        self.testRecord22,
        self.testRecord23,
        self.testRecord24,
        self.testRecord25,
        self.testRecord26,
        self.testRecord27,
        self.testRecord28,
        self.testRecord29,
        self.testRecord30,
        self.testRecord31,
        self.testRecord32,
        self.testRecord33,
        self.testRecord34,
        nil];

    NSArray *array = [[TMTestRecordManager sharedManager].type2RecordArrayDict objectForKey:[NSNumber numberWithInt:RECORD_TYPE_SINGLE_SELECTION]];

    int k = 0;
    for (TMTestRecord *record in array)
    {
        if ([record answered] && ![record isRight])
        {
            UIImageView *imageView = [self.testRecordArray objectAtIndex:k];
            [imageView setImage:[UIImage imageNamed:@"错误_10"]];
            CGRect rect = imageView.frame;
            int yoffset = 0;
            if (k >= 0 && k < 7 )
                yoffset = 3;
            else if( k >= 7 && k < 14)
                yoffset = 0;
            else if( k >= 14 && k < 21)
                yoffset = -1;
            else if( k >= 21 && k < 28)
                yoffset = 0;
            else if( k >= 28 && k < 35)
                yoffset = -3;

            int xoffset = 0;
            switch (k) {
                case 0:
                case 7:
                case 14:
                case 21:
                case 28:
                    xoffset = 4;
                    break;
                case 1:
                case 8:
                case 15:
                case 22:
                case 29:
                    xoffset = 4;
                    break;
                    
                case 2:
                case 9:
                case 16:
                case 23:
                case 30:
                    xoffset = 3.5;
                    break;
                case 3:
                case 10:
                case 17:
                case 24:
                case 31:
                    xoffset = 3;
                    break;
                    
                case 4:
                case 11:
                case 18:
                case 25:
                case 32:
                case 5:
                case 12:
                case 19:
                case 26:
                case 33:
                    xoffset = 0;
                    break;
                case 6:
                case 13:
                case 20:
                case 27:
                case 34:
                    xoffset = -2.5;
                    
                default:
                    break;
            }


            [imageView setFrame:CGRectMake(rect.origin.x+xoffset, rect.origin.y + yoffset, rect.size.width, rect.size.height)];
        }
        
        if (![record answered]) {
            break;
        }
        ++k;
    }
    
    int panelCnt = k / 35;
    
    if (panelCnt == 0) {
        self.testPage0.hidden = YES;
        self.testPage1.hidden = YES;
        self.testPage2.hidden = YES;
    }
    else if(panelCnt == 1)
    {
        self.testPage2.hidden = YES;
    }
    else if(panelCnt == 2)
    {
        
    }
    
//    else if()
    
    for (; k < self.testRecordArray.count; ++k)
    {
        UIImageView *imageView = [self.testRecordArray objectAtIndex:k];
        imageView.hidden = YES;
    }
    


}

- (IBAction)finishTestTouched:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


@end
