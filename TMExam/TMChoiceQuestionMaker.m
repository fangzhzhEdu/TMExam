//
//  TMChoiceQuestionMaker.m
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-7-3.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMChoiceQuestionMaker.h"

@interface TMChoiceQuestionMaker()

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSArray *choices;
@property (nonatomic, strong) NSString *next;
@property (nonatomic, strong) NSString *previous;

- (NSString *)questionLink;
- (NSString *)choiceLink:(NSUInteger)index;
- (NSString *)previousLink;
- (NSString *)nextLink;

@end

@implementation TMChoiceQuestionMaker

- (id)initWithQuestion:(NSString *)question
               choices:(NSArray *)choices
        previousButton:(NSString *)previous
            nextButton:(NSString *)next
{
    self = [super init];
    
    if (self)
    {
        self.question = question;
        self.choices = choices;
        self.next = next;
        self.previous = previous;
    }
    
    return self;
}



- (NSString *)bodyString
{
    NSString *bodyString = [NSString stringWithFormat:@"<div class='question'><p><a href='%@'>%@</a><p></div>", [self questionLink], self.question];
    
    NSString *choicesSection = @"";
    NSUInteger index = 0;
    for (NSString *choice in self.choices)
    {
        NSString *choiceSection = [NSString stringWithFormat:@"<div id='choice%i'><p><a href='%@'>%@</a><p></div>", index, [self choiceLink:index], choice];
        choicesSection = [choicesSection stringByAppendingString:choiceSection];
        index += 1;
    }
    bodyString = [bodyString stringByAppendingFormat:@"<div class='choices'>%@</div>", choicesSection];
    
    if (self.previous)
    {
        bodyString = [bodyString stringByAppendingFormat:@"<div class='previous'><a href='%@'>%@</a></div>", [self previousLink], self.previous];
    }
    
    if (self.next)
    {
        bodyString = [bodyString stringByAppendingFormat:@"<div class='next'><a href='%@'>%@</a></div>", [self nextLink], self.next];
    }
    
    return bodyString;
}

- (NSString *)questionLink
{
    return @"tmexam://question";
}

- (NSString *)choiceLink:(NSUInteger)index
{
    return [NSString stringWithFormat:@"tmexam://choice%i", index];
}

- (NSString *)previousLink
{
    return @"tmexam://previous";
}

- (NSString *)nextLink
{
    return @"tmexam://next";
}

@end
