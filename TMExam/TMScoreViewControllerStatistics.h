//
//  TMScoreViewControllerStatistics.h
//  TMExam
//
//  Created by zhang zhenfang on 13-7-15.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMScoreViewControllerStatistics : UIViewController
@property (nonatomic, strong) IBOutlet UIButton *percentBtn;
@property (nonatomic, strong) IBOutlet UIButton *anserCntBtn;
@property (nonatomic, strong) IBOutlet UIImageView *percentBack;
@property (nonatomic, strong) IBOutlet UIImageView *anserCntBack;


- (IBAction)percentButtonClicked:(id)sender;
- (IBAction)anserCnttonClicked:(id)sender;
- (IBAction)newsToolbarButtonClicked:(id)sender;


@end
