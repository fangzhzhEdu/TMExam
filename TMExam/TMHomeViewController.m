//
//  TMHomeViewController.m
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-7-6.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMHomeViewController.h"
#import "TMTestViewController.h"
#import "TMScoreViewController.h"
#import "TMTestDemoViewController.h"
#import "TMScoreViewControllerStatistics.h"

@interface TMHomeViewController ()

@end

@implementation TMHomeViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeToolbarButtonClicked:(id)sender
{
    
}

- (IBAction)textbookToolbarButtonClicked:(id)sender
{
    
}

- (IBAction)newsToolbarButtonClicked:(id)sender
{
    
}

- (IBAction)settingsToolbarButtonClicked:(id)sender
{
    
}

- (IBAction)testButtonClicked:(id)sender
{
//    TMTestViewController *testViewController = [[TMTestViewController alloc] init];
//    [self.navigationController pushViewController:testViewController animated:YES];

    TMTestDemoViewController *testViewController = [[TMTestDemoViewController alloc] initWithNibName:@"TMTestDemoViewController-ip5" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:testViewController animated:YES];
}

- (IBAction)scoreButtonClicked:(id)sender
{
//    TMScoreViewController *scoreViewController = [[TMScoreViewController alloc] init];
    TMScoreViewControllerStatistics *scoreViewController = [[TMScoreViewControllerStatistics alloc] initWithNibName:@"TMScoreViewControllerStatistics-ip5" bundle:[NSBundle mainBundle]];
    
//    TMScoreViewController *scoreViewController = [[TMScoreViewController alloc] initWithNibName:@"TMScoreViewController-ip5" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:scoreViewController animated:YES];
}

- (IBAction)trainningButtonClicked:(id)sender
{
    
}

- (IBAction)newsButtonClicked:(id)sender
{
    
}

@end
