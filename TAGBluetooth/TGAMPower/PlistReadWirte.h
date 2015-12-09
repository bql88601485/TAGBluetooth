//
//  PlistReadWirte.h
//  TGAMPower
//
//  Created by bai on 15/7/12.
//  Copyright (c) 2015年 bai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistReadWirte : NSObject

+(void)Modify:(NSDictionary *)getvalue;

+(void)ModifyArray:(NSDictionary *)geeee;

+ (NSDictionary *)readingPlist:(NSString *)key;

+ (NSDictionary *)readingSamllPlist:(NSString *)key;
@end
