//
//  NTDataBaseObject.m
//  NoteTools
//
//  Created by wanglei on 17/3/29.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "NTDataBaseObject.h"
#import <Realm.h>

@implementation NTDataBaseObject

-(void)createNTDataBaseWithName: (NSString *)dataBaseName
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:dataBaseName];
    NSLog(@"数据库目录---%@",filePath);
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL URLWithString:filePath];
    config.readOnly = NO;
    int currentVersion = 1.0;
    config.schemaVersion = currentVersion;
    
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

@end
