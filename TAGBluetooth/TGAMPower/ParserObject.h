//
//  ParserObject.h
//  TGAMPower
//
//  Created by bai on 15/7/10.
//  Copyright (c) 2015年 bai. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int PARSER_CODE_POOR_SIGNAL = 2;
static const int PARSER_CODE_HEARTRATE = 3;
static const int PARSER_CODE_CONFIGURATION = 4;
static const int PARSER_CODE_RAW = 128;
static const int PARSER_CODE_DEBUG_ONE = 132;
static const int PARSER_CODE_DEBUG_TWO = 133;
static const int PARSER_CODE_EEG_POWER = 131;

static const int PST_PACKET_CHECKSUM_FAILED = -2;
static const int PST_NOT_YET_COMPLETE_PACKET = 0;
static const int PST_PACKET_PARSED_SUCCESS = 1;
static const int MESSAGE_READ_RAW_DATA_PACKET = 17;
static const int MESSAGE_READ_DIGEST_DATA_PACKET = 18;

static const int RAW_DATA_BYTE_LENGTH = 2;
static const int EEG_DEBUG_ONE_BYTE_LENGTH = 5;
static const int EEG_DEBUG_TWO_BYTE_LENGTH = 3;
static const int PARSER_SYNC_BYTE = 170;
static const int PARSER_EXCODE_BYTE = 85;
static const int MULTI_BYTE_CODE_THRESHOLD = 127;
static const int PARSER_STATE_SYNC = 1;
static const int PARSER_STATE_SYNC_CHECK = 2;
static const int PARSER_STATE_PAYLOAD_LENGTH = 3;
static const int PARSER_STATE_PAYLOAD = 4;
static const int PARSER_STATE_CHKSUM = 5;

@interface ParserObject : NSObject

+ (ParserObject *)shareManager;


- (int )parseByte:(uint32_t )buffer;

- (NSMutableDictionary *)getDataDic:(NSString *)strConent;



- (NSDictionary *)getBigDataStr:(NSString *)conteStr;
- (NSMutableDictionary *)getSamllObjectForKeystr:(NSString *)conteStr;


- (NSString *)backDreciv:(NSString *)str;

@end
