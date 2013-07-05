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

//@property (nonatomic, strong)NSString *selA;
//@property (nonatomic, strong)NSString *selB;
//@property (nonatomic, strong)NSString *selC;
//@property (nonatomic, strong)NSString *selD;

@property (nonatomic, strong) NSArray *options;
@property (nonatomic, readwrite) NSInteger rightIdx;
@property (nonatomic, readwrite) NSInteger selIdx;

- (id)initWithBody:(NSString*)body
              selA:(NSString*)selA
              selB:(NSString*)selB
              selC:(NSString*)selC
              selD:(NSString*)selD
          rightIdx:(NSInteger)rightIdx
              type:(NSInteger)type;

- (NSInteger)addOption:(NSString *)option right:(BOOL)right;

@end
