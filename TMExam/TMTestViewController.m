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

@interface TMTestViewController () <UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *webView;

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
    
    TMHtmlMaker *htmlMaker = [[TMChoiceQuestionMaker alloc] initWithQuestion:@"问题1：1+1=？" choices:@[@"A: 0", @"B: 1", @"C: 2"] previousButton:nil nextButton:@"下一题"];
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
            static NSUInteger index = 1;
            NSString *question = [NSString stringWithFormat:@"问题%i：1+1=？", ++index];
            TMHtmlMaker *htmlMaker = [[TMChoiceQuestionMaker alloc] initWithQuestion:question choices:@[@"A: 0", @"B: 1", @"C: 2"] previousButton:nil nextButton:@"下一题"];
            NSLog(@"%@", htmlMaker.htmlString);
            [self.webView loadHTMLString:htmlMaker.htmlString baseURL:nil];
        }
        else if ([request.URL.host isEqualToString:@"choice0"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"你选择了A" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([request.URL.host isEqualToString:@"choice1"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"你选择了B" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([request.URL.host isEqualToString:@"choice2"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"你选择了C" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
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
