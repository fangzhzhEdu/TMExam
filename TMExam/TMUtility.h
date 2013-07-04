//
//  TMUtility.h
//  TMEnglish
//
//  Created by ZHANG SHI GUANG on 13-3-2.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMUtility : NSObject
/**
 生成新的UUID
 
 @return 返回新的UUID
 */
+ (NSString *)GenerateUUID;

/**
 字符串转时间
 
 @param dateString 源字符串

 @param formatString  类型字符串
 
 @return 由字符串转换来的日期类型
 */
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)formatString;
/**
 时间转字符串
 
 @param date date
 
 @param formatString  类型字符串
 
 @return 返回转换后的字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)formatString;
/**
 返回字符串转换出来的MD5
 
 @param string string 源字符串
 
 @return 返回字符串转换出来的MD5
 */
+ (NSString *)md5OfString:(NSString *)string;
/**
 固定范围内的随机值
 
 @param num1 num1
 
 @param num2 num2
 
 @return num1 和num2 之间的一个随机值
 */
+ (NSInteger)randomNumberBetween:(NSInteger)num1 and:(NSInteger)num2;
/**
 当前程序的文档所在位置
 
 @return 当前程序的文档所在位置
 */
+ (NSString *)documentDirectory;
/**
 临时文件夹所在位置
 
 @return  临时文件夹所在位置
 */
+ (NSString *)tmpDirctoryPath;
/**
 判断指定路径是否存在
 
 @param path path 路径
 
 @return 成功则返回TRUE, 其他错误返回FALSE
 */
+ (BOOL)fileExist:(NSString *)path;
/**
 删除指定路径的文件或者文件夹
 
 @param path path 指定文件名
 
 @return 成功则返回TRUE, 其他错误返回FALSE
 */
+ (BOOL)deleteFileAtPath:(NSString *)path;
/**
 解析文件路径,去掉尾部的/
 
 @param fullPath fullPath 源路径
 
 @return 返回解析后的文件路径
 */
+ (NSString *)parserFileName:(NSString *)fullPath;


@end
