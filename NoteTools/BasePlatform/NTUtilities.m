//
//  NTUtilities.m
//  NoteTools
//
//  Created by wanglei on 17/3/30.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "NTUtilities.h"

@implementation NTUtilities

+(NSString *)yyyyMMddTimeConvertFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateResult = [formatter stringFromDate:date];
    return dateResult;
}




+(NSString *)saveContentToLocalWithFileName:(NSString *)fileName andData: (NSData *)data
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    [data writeToFile:filePath atomically:YES];
    
    return fileName;
}

+(NSData *)loadContentFromLocalWithFileName: (NSString *)fileName
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

+(NSData *)returnDataWithDictionary:(NSDictionary *)dict
{
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"noteTools"];
    [archiver finishEncoding];
    
    return data;
}

+(NSDictionary *)returnDictionaryWithData: (NSData *)data
{
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary * myDictionary = [unarchiver decodeObjectForKey:@"noteTools"];
    [unarchiver finishDecoding];

    return myDictionary;
}

@end
