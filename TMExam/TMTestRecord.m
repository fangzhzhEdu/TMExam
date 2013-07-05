//
//  TMTestRecord.m
//  TMExam
//
//  Created by zhang zhenfang on 13-7-5.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMTestRecord.h"
#import "TMUtility.h"

@implementation TMTestRecord

- (id)init
{
    self = [super init];
    if (self)
    {
        self.GUID = [TMUtility GenerateUUID];
        self.type = RECORD_TYPE_UNKNOW;
        self.body = @"";
    }
    
    return self;
}

- (BOOL)isRight
{
    return NO;
}

@end
