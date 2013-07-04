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
@property (nonatomic, readwrite)int  curTestRecordIdx;
@property (nonatomic, strong)NSMutableArray *testRecords; //  试题的一个集合, 暂时不用, 以后可以扩展为, 此数组配置化, 可以定制从题库中选择显示哪些试题. 此版本显示所有试题
@property (nonatomic, weak)NSArray *curRecordArray; // 当前类型试题的数组
@property (nonatomic, readwrite) int curSelection;  //
- (BOOL)processLinkClick:(NSURLRequest *)request;

@end

@implementation TMTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"模拟测试";
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
    if (self.curRecordArray == nil) {
        return;
    }
    TMTestRecordSingleSelection *record = [self.curRecordArray objectAtIndex:self.curTestRecordIdx];
    TMHtmlMaker *htmlMaker = [[TMChoiceQuestionMaker alloc] initWithQuestion:record.body  choices:@[record.selA, record.selB, record.selC] previousButton:nil nextButton:@"下一题"];

    NSLog(@"%@", htmlMaker.htmlString);
    [self.webView loadHTMLString:htmlMaker.htmlString baseURL:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)processLinkClick:(NSURLRequest *)request
{
    NSLog(@"%@", request.URL.scheme);
    NSLog(@"%@", request.URL.host);
    
    if ([request.URL.scheme isEqualToString:@"tmexam"])
    {
        if ([request.URL.host isEqualToString:@"next"])
        {
            TMTestRecordSingleSelection *record = [self.curRecordArray objectAtIndex:++self.curTestRecordIdx];
            record.selIdx = self.curSelection;

            if (self.curTestRecordIdx+1 >= [self.curRecordArray count]) {
                UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:@"no more test"
                                                                     message:@"no more test"
                                                                    delegate:self
                                                           cancelButtonTitle:@"知道了"
                                                           otherButtonTitles:nil, nil];
                [alertView show];
                return NO;
            }
            record = [self.curRecordArray objectAtIndex:++self.curTestRecordIdx];
            TMHtmlMaker *htmlMaker = [[TMChoiceQuestionMaker alloc] initWithQuestion:record.body  choices:@[record.selA, record.selB, record.selC] previousButton:nil nextButton:@"下一题"];
            NSLog(@"%@", htmlMaker.htmlString);
            [self.webView loadHTMLString:htmlMaker.htmlString baseURL:nil];
        }
        else if ([request.URL.host isEqualToString:@"choice0"])
        {
            self.curSelection = 0;
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"你选择了A" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alertView show];
        }
        else if ([request.URL.host isEqualToString:@"choice1"])
        {
            self.curSelection = 1;

//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"你选择了B" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alertView show];
        }
        else if ([request.URL.host isEqualToString:@"choice2"])
        {
            self.curSelection = 2;
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"你选择了C" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alertView show];
        }
    }
    
    return NO;
}

#pragma mark --UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSLog(@"- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType");
//    NSLog(@"%@", request);
//    
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
