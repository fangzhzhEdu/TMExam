//
//  TMChoiceQuestionMaker.m
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-7-3.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMChoiceQuestionMaker.h"

@interface TMChoiceQuestionMaker()

@property (nonatomic, strong) NSString *questionNumber;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSArray *choices;
@property (nonatomic, strong) NSString *next;
@property (nonatomic, strong) NSString *previous;
@property (nonatomic, assign) NSInteger chosen;

- (NSString *)questionLink;
- (NSString *)choiceLink:(NSUInteger)index;
- (NSString *)previousLink;
- (NSString *)nextLink;
- (NSString *)choiceBadge:(NSUInteger)index;

@end

@implementation TMChoiceQuestionMaker

- (id)initWithQuestion:(NSString *)question
        questionNumber:(NSString *)questionNumber
               choices:(NSArray *)choices
                chosen:(NSInteger)chosen
        previousButton:(NSString *)previous
            nextButton:(NSString *)next
{
    self = [super init];
    
    if (self)
    {
        self.question = question;
        self.questionNumber = questionNumber;
        self.choices = choices;
        self.chosen = chosen;
        self.next = next;
        self.previous = previous;
    }
    
    return self;
}

- (NSString *)bodyString
{
    NSString *question = nil;
    if (self.questionNumber)
        question =[NSString stringWithFormat:@"<h4><dl class='dl-horizontal'><dt>%@</dt><dd>%@</dd><dl></h4>", self.questionNumber, self.question];
    else
        question = [NSString stringWithFormat:@"<h4>%@</h4>", self.question];
    
    NSString *options = @"";
    for (int i = 0; i < self.choices.count; i++)
    {
        NSString *choiceSection = nil;
        if (i == self.chosen)
            choiceSection = [NSString stringWithFormat:@"<dt><a class='badge badge-info' href='%@'>%@</a></dt><dd>%@</dd>", [self choiceLink:i], [self choiceBadge:i], self.choices[i]];
        else
            choiceSection = [NSString stringWithFormat:@"<dt><a class='badge' href='%@'>%@</a></dt><dd>%@</dd>", [self choiceLink:i], [self choiceBadge:i], self.choices[i]];
        options = [options stringByAppendingString:choiceSection];
    }
    options = [NSString stringWithFormat:@"<dl class='dl-horizontal'>%@</dl>", options];
    
    NSString *pager = @"<ul class='pager'>";
    if (self.previous)
    {
        pager = [pager stringByAppendingFormat:@"<li><a href='%@'>%@</a></li>", [self previousLink], self.previous];
    }
    if (self.next)
    {
        pager = [pager stringByAppendingFormat:@"<li><a href='%@'>%@</a></li>", [self nextLink], self.next];
    }
    
    NSString *bodyString = [NSString stringWithFormat:@"<div class='container'>%@<hr />%@<hr />%@</div>", question, options, pager];
    
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

- (NSString *)choiceBadge:(NSUInteger)index
{
    static NSString *badges = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    if (index >= badges.length)
        return @"NONE";
    NSRange range;
    range.location = index;
    range.length = 1;
    return [badges substringWithRange:range];
}

@end
