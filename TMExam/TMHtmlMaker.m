//
//  TMHtmlMaker.m
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-7-3.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMHtmlMaker.h"

@interface TMHtmlMaker()

@end

@implementation TMHtmlMaker

- (NSString *)htmlString
{
    NSString *html = [[self htmlTemplate] stringByReplacingOccurrencesOfString:@"%%CSS%%" withString:[self cssString]];
    return [html stringByReplacingOccurrencesOfString:@"%%BODY%%" withString:[self bodyString]];
}

- (NSString *)htmlTemplate
{
    static NSString *_htmlTemplate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
        _htmlTemplate = [NSString stringWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:nil];
    });
    
    return _htmlTemplate;
}

- (NSString *)cssString
{
    static NSString *_css = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"css"];
        _css = [NSString stringWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:nil];
    });
    
    return _css;
}

- (NSString *)bodyString
{
    return @"";
}

@end
