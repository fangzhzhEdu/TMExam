//
//  TMTestResult.m
//  TMExam
//
//  Created by zhang zhenfang on 13-7-14.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMTestResult.h"

@implementation TMTestResult
-(id) initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self != nil)
    {
        self.testDuration = [[dict objectForKey:@"test_duration"] longValue];
        self.rightCnt = [[dict objectForKey:@"right_cnt"] intValue];
        self.totalCnt = [[dict objectForKey:@"total_cnt"] intValue];
    }
    return self;
}

-(NSDictionary*) toDict
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:3];
    [dict setObject:[NSNumber numberWithLong:self.testDuration] forKey:@"test_duration"];
    [dict setObject:[NSNumber numberWithInt:self.rightCnt] forKey:@"right_cnt"];
    [dict setObject:[NSNumber numberWithInt:self.totalCnt] forKey:@"total_cnt"];
    return dict;
}

@end
