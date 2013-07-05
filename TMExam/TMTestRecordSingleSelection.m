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
           rightIdx:(int)rightIdx
             type:(int)type

{
    self = [super init];
    if (self)
    {
        self.body = body;

        NSMutableArray *options = [[NSMutableArray alloc] init];

        if (selA)
            [options addObject:selA];
        if (selB)
            [options addObject:selB];
        if (selC)
            [options addObject:selC];
        if (selD)
            [options addObject:selD];
        
        self.options = [NSArray arrayWithArray:options];
        self.rightIdx = rightIdx;
        self.selIdx = -1;
        
    }
    
    return self;
}

-(BOOL)isRight
{
    return self.rightIdx == self.selIdx;
}

- (NSInteger)addOption:(NSString *)option right:(BOOL)right
{
    self.options = [self.options arrayByAddingObject:option];

    NSInteger index = self.options.count - 1;
    if (right)
        self.rightIdx = index;
    
    return index;
}

@end
