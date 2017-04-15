//
//  NTUtilities.h
//  NoteTools
//
//  Created by wanglei on 17/3/30.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTUtilities : NSObject

//时间转换
+ (NSString *)yyyyMMddTimeConvertFromDate: (NSDate *)date;

//file operation
+(NSString *)saveContentToLocalWithFileName:(NSString *)fileName andData: (NSData *)data;
+(NSData *)loadContentFromLocalWithFileName: (NSString *)fileName;

+(NSData *)returnDataWithDictionary:(NSDictionary *)dict;
+(NSDictionary *)returnDictionaryWithData: (NSData *)data;
@end
