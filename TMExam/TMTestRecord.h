//
//  TMTestRecord.h
//  TMExam
//
//  Created by zhang zhenfang on 13-7-5.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#define RECORD_TYPE_SINGLE_SELECTION 1
#define RECORD_TYPE_MULTIPLE_SELECTION 2

@interface TMTestRecord : NSObject
{
    
}
@property (nonatomic, readwrite)int  type;
@property (nonatomic, strong)NSString* GUID;
@property (nonatomic, strong)NSString* body;

@end
