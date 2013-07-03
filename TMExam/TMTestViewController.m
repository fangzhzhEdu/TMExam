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

@interface TMTestViewController ()

@property (nonatomic, retain) UIWebView *webView;

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
    [self.view addSubview:self.webView];
    
    TMHtmlMaker *htmlMaker = [[TMChoiceQuestionMaker alloc] initWithQuestion:@"问题：1+1=？" choices:@[@"A: 0", @"B: 1", @"C: 2"] previousButton:nil nextButton:@"下一题"];
    [self.webView loadHTMLString:htmlMaker.htmlString baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
