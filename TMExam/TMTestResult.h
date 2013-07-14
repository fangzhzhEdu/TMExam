//
//  TMTestResult.h
//  TMExam
//
//  Created by zhang zhenfang on 13-7-14.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMTestResult : NSObject
@property ( nonatomic, readwrite) long testDuration;
@property ( nonatomic, readwrite) int  rightCnt;
@property (nonatomic, readwrite) int totalCnt;

-(id) initWithDict:(NSDictionary*)dict;
-(NSDictionary*) toDict;
@end
