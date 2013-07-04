//
//  TMTestRecordSingleSelection.h
//  TMExam
//
//  Created by zhang zhenfang on 13-7-5.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMTestRecord.h"
@interface TMTestRecordSingleSelection : TMTestRecord
@property (nonatomic, strong)NSString *selA;
@property (nonatomic, strong)NSString *selB;
@property (nonatomic, strong)NSString *selC;
@property (nonatomic, strong)NSString *selD;
@property (nonatomic, readwrite)int  selIdx;

-(id)initWithBody:(NSString*)body
             selA:(NSString*)selA
             selB:(NSString*)selB
             selC:(NSString*)selC
             selD:(NSString*)selD
           selIdx:(int)selIdx
             type:(int)type;

@end
