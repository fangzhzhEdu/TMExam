//
//  TMChoiceQuestionMaker.h
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-7-3.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMQuestionMaker.h"

@interface TMChoiceQuestionMaker : TMQuestionMaker

- (id)initWithQuestion:(NSString *)question
        questionNumber:(NSString *)questionNumber
               choices:(NSArray *)choices
                chosen:(NSInteger)chosen
        previousButton:(NSString *)previous
            nextButton:(NSString *)next;
@end
