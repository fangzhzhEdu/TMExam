//
//  TMHtmlMaker.h
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-7-3.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMHtmlMaker : NSObject

@property (nonatomic, strong) NSString *htmlString;

- (NSString *)htmlTemplate;

- (NSString *)cssString;
- (NSString *)bodyString;

@end
