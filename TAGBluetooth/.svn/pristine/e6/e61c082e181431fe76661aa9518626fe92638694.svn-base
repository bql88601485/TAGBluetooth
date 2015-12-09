//
//  PlistReadWirte.m
//  TGAMPower
//
//  Created by bai on 15/7/12.
//  Copyright (c) 2015年 bai. All rights reserved.
//

#import "PlistReadWirte.h"

@implementation PlistReadWirte

//写入数据到plist文件
+(void)Modify:(NSDictionary *)getvalue
{
    /*
     注意：此方法更新和写入是共用的
     */
    //获取路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"log.plist"];
    
    NSMutableDictionary *applist = [[[NSMutableDictionary alloc]initWithContentsOfFile:path]mutableCopy];
    
    if (!applist) {
        //1. 创建一个plist文件
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:path contents:nil attributes:nil];
        
        applist = [[NSMutableDictionary alloc] init];
    }
    [applist removeAllObjects];
    [applist setDictionary:getvalue];
    //写入文件
    [applist writeToFile:path atomically:YES];
    
    [applist removeAllObjects];
    applist = nil;
    
}
//写入数据到plist文件
+(void)ModifyArray:(NSDictionary *)geeee
{
    /*
     注意：此方法更新和写入是共用的
     */
    //获取路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"logBql.plist"];
    
    NSMutableDictionary *applist = [[[NSMutableDictionary alloc]initWithContentsOfFile:path]mutableCopy];
    
    if (!applist) {
        //1. 创建一个plist文件
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:path contents:nil attributes:nil];
        
        applist = [[NSMutableDictionary alloc] init];
    }
    [applist removeAllObjects];
    [applist setDictionary:geeee];
    //写入文件
    [applist writeToFile:path atomically:YES];
    [applist removeAllObjects];
    applist = nil;
}

+ (NSDictionary *)readingPlist:(NSString *)key
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"log.plist"];
    //读文件
    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:path];
    
    return dic2;
}
+ (NSDictionary *)readingSamllPlist:(NSString *)key
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",key]];
    //读文件
    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:path];
    
    return dic2;
}
@end
