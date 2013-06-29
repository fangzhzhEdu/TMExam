//
//  TMWelcomeViewController.m
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-6-29.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMWelcomeViewController.h"
#import "TMHomeViewController.h"

@interface TMWelcomeViewController ()

- (IBAction)enterButtonClicked:(id)sender;

@end

@implementation TMWelcomeViewController

- (IBAction)enterButtonClicked:(id)sender
{
    TMHomeViewController *homeViewController = [[TMHomeViewController alloc] init];
    [self.navigationController pushViewController:homeViewController animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我是安全员";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect imageRect = CGRectMake(self.view.frame.origin.x + 10,
                                  self.view.frame.origin.y + 10,
                                  self.view.frame.size.width - 20,
                                  self.view.frame.size.width - 20);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageRect];
    imageView.image = [UIImage imageNamed:@"model.jpg"];
    
    [self.view addSubview:imageView];
    
    CGRect buttonRect = CGRectMake(imageRect.origin.x + 10,
                                   imageRect.origin.y + imageRect.size.height + 5,
                                   imageRect.size.width - 20,
                                   40);
    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    enterButton.frame = buttonRect;
    [enterButton setTitle:@"开始" forState:UIControlStateNormal];
    [enterButton addTarget:self action:@selector(enterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:enterButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
