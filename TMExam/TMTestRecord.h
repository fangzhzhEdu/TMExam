//
//  TMTestRecord.h
//  TMExam
//
//  Created by zhang zhenfang on 13-7-5.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RECORD_TYPE_UNKNOW 0
#define RECORD_TYPE_SINGLE_SELECTION 1
#define RECORD_TYPE_MULTIPLE_SELECTION 2
#define RECORD_TYPE_MAX 10

@interface TMTestRecord : NSObject

@property (nonatomic, readwrite) NSInteger type;
@property (nonatomic, strong) NSString* GUID;
@property (nonatomic, strong) NSString* body;
@property (nonatomic, readwrite) BOOL answered; // 本题目是否回答过
@property (nonatomic, readwrite) BOOL onceRighted; // 本题目,是否曾经被做对过
@property (nonatomic, readwrite) BOOL onceAnswered; // 本题目,是否曾经被回答过

- (BOOL)isRight;

@end
