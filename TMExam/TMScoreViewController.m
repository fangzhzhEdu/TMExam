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
@interface TMScoreViewController () <UIScrollViewDelegate>

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

-(id)init
{
    self = [super init];
    if (self)
    {
        int n = [[TMTestRecordManager sharedManager] testResultInfoArray].count;
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
    return self;
}

- (void)initWithDict:(NSDictionary*)sampleInfo
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
//    decimal = result.answeredCnt / 10;
    decimal = result.totalCnt / 10;
//    unit = result.answeredCnt % 10;
    unit = result.totalCnt % 10;
    
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
//    int percent = result.rightCnt * 100 / result.answeredCnt ;
    int percent = result.rightCnt * 100 / result.totalCnt ;
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

    
    //分页显示每个题目的答题情况
    NSUInteger pages = result.totalCnt / 35;
    if (result.totalCnt % 35)
        pages += 1;

    NSUInteger PAGE_WIDTH = 320;
    NSUInteger LEFT_X = 40;
    NSUInteger SPAN_X = 40;
    NSUInteger TOP_Y = 40;
    NSUInteger SPAN_Y = 39;
    NSUInteger DOT_WIDTH = 30;
    NSUInteger DOT_HEIGHT = 30;

    self.pageControl.numberOfPages = pages;
    self.pageControl.currentPage = 0;
    
    self.scrollView.pagingEnabled = YES;
	self.scrollView.contentSize = CGSizeMake(PAGE_WIDTH * pages, self.scrollView.frame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    
    
    NSArray *array = [[TMTestRecordManager sharedManager].type2RecordArrayDict objectForKey:[NSNumber numberWithInt:RECORD_TYPE_SINGLE_SELECTION]];

    BOOL done = NO;
    for (NSUInteger i = 0; i < pages; i++)
    {
        for (NSUInteger j = 0; j < 5; j++)
        {
            for (NSUInteger k = 0; k < 7; k++)
            {
                NSUInteger index = i * 35 + j * 7 + k;
                if (index >= result.totalCnt)
                {
                    done = YES;
                    break;
                }
                
                NSInteger x = PAGE_WIDTH * i + LEFT_X + SPAN_X * k - DOT_WIDTH / 2;
                NSInteger y = TOP_Y + SPAN_Y * j - DOT_HEIGHT / 2;
                
                CGRect imageFrame = CGRectMake(x, y, DOT_WIDTH, DOT_HEIGHT);
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
                TMTestRecord *record = array[index];
                NSString *number = [NSString stringWithFormat:@"%d", index];

                CGRect numberFrame = imageFrame;
                 UIFont *percentageFont = [UIFont boldSystemFontOfSize:20];


                NSString *imageName = nil;
                if (!record.answered)
                {
                    imageName = @"DotUnanswered";
                }
                else if (record.isRight)
                {
                    imageName = @"DotRight";
                }
                else
                {
                    imageName = @"DotWrong";
                }
                
                imageView.image = [UIImage imageNamed:imageName];
                
                [self.scrollView addSubview:imageView];
                [number drawInRect:numberFrame withFont:percentageFont lineBreakMode:NSLineBreakByWordWrapping  alignment: NSTextAlignmentRight];

            }
            
            if (done)
                break;
        }
        if (done)
            break;
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

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}


@end
