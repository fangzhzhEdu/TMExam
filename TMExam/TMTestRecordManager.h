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
@property (nonatomic, strong) NSMutableDictionary *type2RightRecDict;       // 类别 -> 正确题目 的字典

+ (TMTestRecordManager *)sharedManager;

- (void)doStatistics;

@end
