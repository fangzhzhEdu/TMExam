//
//  TMUtility.m
//  TMEnglish
//
//  Created by ZHANG SHI GUANG on 13-3-2.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMUtility.h"
#import <CommonCrypto/CommonDigest.h>

@implementation TMUtility

+ (NSString *)GenerateUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    
    NSString *strUUID = [[NSString alloc] initWithString:(__bridge NSString *)string];
    return strUUID;
}

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)formatString
{
    if (!formatString)
        formatString = @"yyyy-MM-dd HH:mm:ss";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)formatString
{
    if (!formatString)
        formatString = @"yyyy-MM-dd HH:mm:ss";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)md5OfString:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSInteger)randomNumberBetween:(NSInteger)num1 and:(NSInteger)num2
{
    if (num1 > num2)
    {
        NSInteger temp = num1;
        num1 = num2;
        num2 = temp;
    }
    
    if (num1 == num2)
        return num1;
    
    NSInteger delta = rand() % (num2 - num1);
    
    return num1 + delta;
}

+ (NSString *)documentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)tmpDirctoryPath
{
    return NSTemporaryDirectory();
}

+ (NSString *)parserFileName:(NSString *)fullPath
{
    NSArray *splits = [fullPath componentsSeparatedByString:@"/"];
    return splits[[splits count] - 1];
}

+ (BOOL)deleteFileAtPath:(NSString *)path
{
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    return [defaultManager removeItemAtPath:path error:nil];
}

+ (BOOL)fileExist:(NSString *)path
{
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    return [defaultManager fileExistsAtPath:path];
}


@end
