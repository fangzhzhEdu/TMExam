//
//  TMTestViewController.m
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-7-3.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMTestViewController.h"
#import "TMHtmlMaker.h"
#import "TMChoiceQuestionMaker.h"
#import "TMTestRecordManager.h"
#import "TMTestRecord.h"
#import "TMTestRecordSingleSelection.h"

@interface TMTestViewController () <UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, readwrite) NSInteger curTestRecordIdx;
@property (nonatomic, strong) NSMutableArray *testRecords;  //  试题的一个集合, 暂时不用, 以后可以扩展为, 此数组配置化, 可以定制从题库中选择显示哪些试题. 此版本显示所有试题
@property (nonatomic, weak) NSArray *curRecordArray;        // 当前类型试题的数组
@property (nonatomic, readwrite) NSInteger curSelection;    //

- (BOOL)processLinkClick:(NSURLRequest *)request;
- (BOOL)loadQuestion;

@end

@implementation TMTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"模拟测试";
        self.curRecordArray = nil;
        self.curTestRecordIdx = 0;
        self.testRecords = nil;
        self.curSelection = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    self.curRecordArray = [[TMTestRecordManager sharedManager].type2RecordArrayDict objectForKey:[NSNumber numberWithInt:RECORD_TYPE_SINGLE_SELECTION]];
    if (self.curRecordArray == nil)
    {
        return;
    }

    [self loadQuestion];

//    NSURL *bundleURL = [[NSBundle mainBundle] resourceURL];
//    [self.webView loadHTMLString:[self htmlStringForQuestion:self.curSelection] baseURL:bundleURL];
    
//    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
//    NSString *html = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    NSURL *bundleURL = [[NSBundle mainBundle] resourceURL];
//    [self.webView loadHTMLString:html baseURL:bundleURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)processLinkClick:(NSURLRequest *)request
{
    if ([request.URL.scheme isEqualToString:@"tmexam"])
    {
        TMTestRecordSingleSelection *record = [self.curRecordArray objectAtIndex:self.curTestRecordIdx];
        
        if ([request.URL.host isEqualToString:@"next"])
        {            
            if (self.curTestRecordIdx + 1 >= [self.curRecordArray count])
            {
                UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:@"no more test"
                                                                     message:@"no more test"
                                                                    delegate:self
                                                           cancelButtonTitle:@"知道了"
                                                           otherButtonTitles:nil, nil];
                [alertView show];
//                [[TMTestRecordManager sharedManager] doStatistics:self.];
                return NO;
            }
            
            self.curTestRecordIdx += 1;
            [self loadQuestion];
        }
        else if ([request.URL.host isEqualToString:@"previous"])
        {
            if (self.curTestRecordIdx - 1 < [self.curRecordArray count] && self.curTestRecordIdx - 1 >= 0)
            {
                self.curTestRecordIdx -= 1;
                [self loadQuestion];
            }
        }
        else if ([request.URL.host isEqualToString:@"choice0"])
        {
            self.curSelection = 0;
            record.selIdx = self.curSelection;
            [self loadQuestion];
        }
        else if ([request.URL.host isEqualToString:@"choice1"])
        {
            self.curSelection = 1;
            record.selIdx = self.curSelection;
            [self loadQuestion];
        }
        else if ([request.URL.host isEqualToString:@"choice2"])
        {
            self.curSelection = 2;
            record.selIdx = self.curSelection;
            [self loadQuestion];
        }
        else if ([request.URL.host isEqualToString:@"choice3"])
        {
            self.curSelection = 3;
            record.selIdx = self.curSelection;
            [self loadQuestion];
        }
    }
    
    return NO;
}

- (BOOL)loadQuestion
{
    TMTestRecordSingleSelection *record = [self.curRecordArray objectAtIndex:self.curTestRecordIdx];
    if (nil == record)
        return NO;
    
    NSString *indexString = [NSString stringWithFormat:@"%i", self.curTestRecordIdx + 1];
    TMHtmlMaker *htmlMaker = [[TMChoiceQuestionMaker alloc] initWithQuestion:record.body
                                                              questionNumber:indexString
                                                                     choices:record.options
                                                                      chosen:record.selIdx
                                                              previousButton:@"上一题"
                                                                  nextButton:@"下一题"];

    self.curSelection = record.selIdx;
    
    NSString *htmlString = htmlMaker.htmlString;
    NSURL *bundleURL = [[NSBundle mainBundle] resourceURL];
    [self.webView loadHTMLString:htmlString baseURL:bundleURL];

    return YES;
}

#pragma mark --UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
        return [self processLinkClick:request];
    
//    switch (navigationType) {
//        case UIWebViewNavigationTypeLinkClicked:
//            NSLog(@"UIWebViewNavigationTypeLinkClicked");
//            return NO;
//        case UIWebViewNavigationTypeFormSubmitted:
//            NSLog(@"UIWebViewNavigationTypeFormSubmitted");
//            break;
//        case UIWebViewNavigationTypeBackForward:
//            NSLog(@"UIWebViewNavigationTypeBackForward");
//            break;
//        case UIWebViewNavigationTypeReload:
//            NSLog(@"UIWebViewNavigationTypeReload");
//            break;
//        case UIWebViewNavigationTypeFormResubmitted:
//            NSLog(@"UIWebViewNavigationTypeFormResubmitted");
//            break;
//        case UIWebViewNavigationTypeOther:
//            NSLog(@"UIWebViewNavigationTypeOther");
//    }
 
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    NSLog(@"- (void)webViewDidStartLoad:(UIWebView *)webView");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    NSLog(@"- (void)webViewDidFinishLoad:(UIWebView *)webView");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    NSLog(@"- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error");
}

@end
