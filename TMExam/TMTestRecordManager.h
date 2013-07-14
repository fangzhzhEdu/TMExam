//
//  TMTestRecordManager.h
//  TMExam
//
//  Created by zhang zhenfang on 13-7-5.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMTestRecordManager : NSObject

@property (nonatomic, strong) NSMutableArray *testRecords;                  // 试题汇总
@property (nonatomic, strong) NSMutableDictionary *type2RecordArrayDict;    // 类别 -> 类别试题 的字典
@property (nonatomic, strong) NSMutableDictionary *guid2RecordDict;         // guid -> 试题的字典
@property (nonatomic, strong) NSMutableDictionary *type2RightRecDict;       // 类别 -> 正确题目个数 的字典
@property (nonatomic, strong) NSMutableArray *testResultInfoArray;     // 答题信息统计数组

#pragma mark game logic property
@property (nonatomic, readwrite)long   startAnswerTime;
@property (nonatomic, readwrite)long   finishAnswerTime;


+ (TMTestRecordManager *)sharedManager;

/*
 * 计算出,每个类别的正确题目的个数
 *
 * duration  答题时间
 */

- (void)doStatistics:(long)duration;

@end
