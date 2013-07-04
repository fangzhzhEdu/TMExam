//
//  TMTestRecordSingleSelection.m
//  TMExam
//
//  Created by zhang zhenfang on 13-7-5.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMTestRecordSingleSelection.h"
#import "TMUtility.h"
@implementation TMTestRecordSingleSelection
-(id)initWithBody:(NSString*)body
             selA:(NSString*)selA
             selB:(NSString*)selB
             selC:(NSString*)selC
             selD:(NSString*)selD
           selIdx:(int)selIdx
             type:(int)type

{
    self = [super init];
    if (self) {
        self.body = body;
        self.selA = selA;
        self.selB = selB;
        self.selC = selC;
        self.selD = selD;
        self.selIdx = selIdx;
        self.GUID = [TMUtility GenerateUUID];
    }
    return self;
    
}
@end
