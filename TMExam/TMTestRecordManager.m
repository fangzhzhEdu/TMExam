//
//  TMTestRecordManager.m
//  TMExam
//
//  Created by zhang zhenfang on 13-7-5.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMTestRecordManager.h"
#import "TMTestrecord.h"
#import "TMTestRecordSingleSelection.h"
#import "TMTestResult.h"
@interface TMTestRecordManager()

- (id)initWithPlist;

@end


@implementation TMTestRecordManager

+ (TMTestRecordManager *)sharedManager
{
    static TMTestRecordManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[TMTestRecordManager alloc] initWithPlist];
    });
    
    return _sharedManager;
}


- (id)initWithPlist
{
    self = [super init];
    if (self)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        self.testResultInfoArray = [defaults objectForKey:@"com.topmost.testResult"];
        if (self.testResultInfoArray == nil) {
            self.testResultInfoArray = [[NSMutableArray alloc] initWithCapacity:10];
        }

        // 初始化变量
        self.testRecords = [[NSMutableArray alloc] initWithCapacity:10];
        self.type2RecordArrayDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        self.guid2RecordDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        
        // 加题目
        NSString *plist = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"TestRecord.plist"];
        NSArray *testArray = [NSArray arrayWithContentsOfFile:plist];
        for (NSDictionary *info in testArray)
        {
            int type = [[info objectForKey:@"type"] intValue];
            TMTestRecord *record = nil;
            if (type == RECORD_TYPE_SINGLE_SELECTION)
            {

                NSString * body = [info objectForKey:@"body"];
                NSString * selA = [info objectForKey:@"selA"];
                NSString * selB = [info objectForKey:@"selB"];
                NSString * selC = [info objectForKey:@"selC"];
                NSString * selD = [info objectForKey:@"selD"];
                
                int rightIdx = [[info objectForKey:@"rightIdx"] intValue];
                TMTestRecordSingleSelection *recordS =                [[TMTestRecordSingleSelection alloc]
                                                                       initWithBody:body
                                                                       selA:selA
                                                                       selB:selB
                                                                       selC:selC
                                                                       selD:selD
                                                                       rightIdx:rightIdx
                                                                       type:type];
                record = recordS;
            }
            
            [self.testRecords addObject:record];
            
            NSMutableArray *array = [self.type2RecordArrayDict objectForKey:[NSNumber numberWithInt:type]];
            if (array == nil)
            {
                array = [[NSMutableArray alloc] initWithCapacity:10];
                [self.type2RecordArrayDict setObject:array forKey:[NSNumber numberWithInt:type]];
            }
            
            [array addObject:record];
            [self.guid2RecordDict setObject:record forKey:record.GUID];
        }
    }
    
    return self;
}

- (void)doStatistics:(long)duration
{
    if (self.type2RightRecDict == nil)
    {
        self.type2RightRecDict = [[NSMutableDictionary alloc] initWithCapacity:RECORD_TYPE_MAX];
    }
    int totalCnt = 0;
    int totalRightCnt = 0;
    for (int k = RECORD_TYPE_SINGLE_SELECTION; k < RECORD_TYPE_MAX; ++k)
    {
        NSArray *array = [self.type2RecordArrayDict objectForKey:[NSNumber numberWithInt:k]];
        int right = 0;
        for (TMTestRecord *record in array)
        {
            if ([record isRight])
            {
                ++right;
                ++totalRightCnt;
            }
            ++totalCnt;
        }
        [self.type2RightRecDict setObject:[NSNumber numberWithInt:right] forKey:[NSNumber numberWithInt:k]];
    }
    TMTestResult *result = [[TMTestResult alloc] init];
    result.testDuration = self.finishAnswerTime - self.startAnswerTime;
    result.totalCnt = totalCnt;
    result.rightCnt= totalRightCnt;
    
    NSDictionary *dict = [result toDict];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self.testResultInfoArray addObject:dict];
    [defaults setObject:self.testResultInfoArray forKey:@"com.topmost.testResult"];
    [defaults synchronize];
}

@end
