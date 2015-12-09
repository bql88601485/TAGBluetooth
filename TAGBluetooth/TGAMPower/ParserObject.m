//
//  ParserObject.m
//  TGAMPower
//
//  Created by bai on 15/7/10.
//  Copyright (c) 2015年 bai. All rights reserved.
//

#import "ParserObject.h"
#import <UIKit/UIKit.h>

#import "PlistReadWirte.h"
#define BIG_ITEM_KEY    @"aaaa2002"
#define SAMLL_ITEM_KEY  @"aaaa0480 02"

#define KEY_ALL_DATA    @"00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000"
@interface ParserObject()
{
    int parserStatus;
    int payloadLength;
    int payloadBytesReceived;
    int payloadSum;
    int checksum;
    Byte payload[256];
}
@end
static ParserObject *staticSelf = nil;
@implementation ParserObject

+ (ParserObject *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticSelf = [[ParserObject alloc] init];
        [staticSelf initAllData];
    });
    
    return staticSelf;
}
- (void)initAllData
{
    parserStatus = PARSER_STATE_SYNC;
}
- (int )parseByte:(uint32_t )buffer
{
    int returnValue = 0;
    switch (parserStatus)
    {
        case 1:
            if ((buffer & 0xFF) != PARSER_SYNC_BYTE) {break;}
            else
            {
             parserStatus = PARSER_STATE_SYNC_CHECK;
            }
            break;
        case 2:
            if ((buffer & 0xFF) == PARSER_SYNC_BYTE)
            {
                parserStatus = PARSER_STATE_PAYLOAD_LENGTH;
            }
            else
            {
                parserStatus = PARSER_STATE_SYNC;
            }
            break;
        case 3:
            payloadLength = (buffer & 0xFF);
            payloadBytesReceived = 0;
            payloadSum = 0;
            parserStatus = PARSER_STATE_PAYLOAD;
            break;
        case 4:
            payload[(payloadBytesReceived++)] = buffer;
            payloadSum += (buffer & 0xFF);
            if (payloadBytesReceived < payloadLength) {break;}
            else {
              parserStatus = PARSER_STATE_CHKSUM;
            }
            break;
        case 5:
            checksum = (buffer & 0xFF);
            parserStatus = PARSER_STATE_SYNC;
            if (checksum != ((payloadSum ^ 0xFFFFFFFF) & 0xFF))
            {
                returnValue = -2;
                NSLog(@"CheckSum ERROR!!");
            }
            else
            {
                returnValue = 1;
                [self parsePacketPayload];
            }
            break;
    }
    return returnValue;
}
- (void)parsePacketPayload
{
    int i = 0;
    int extendedCodeLevel = 0;
    int code = 0;
    int valueBytesLength = 0;
    
    int signal = 0; int config = 0; int heartrate = 0;
    int rawWaveData = 0;
    while (i < payloadLength)
    {
        extendedCodeLevel++;
        
        while (payload[i] == PARSER_EXCODE_BYTE)
        {
            i++;
        }
        
        code = payload[(i++)] & 0xFF;
        
        if (code > MULTI_BYTE_CODE_THRESHOLD)
        {
            valueBytesLength = payload[(i++)] & 0xFF;
        }
        else
        {
            valueBytesLength = 1;
        }
        
        if (code == PARSER_CODE_RAW)
        {
            if (valueBytesLength == RAW_DATA_BYTE_LENGTH)
            {
                Byte highOrderByte = payload[i];
                Byte lowOrderByte = payload[(i + 1)];
                rawWaveData = [self getRawWaveValue:highOrderByte lowOrderByte:lowOrderByte];
                
                if (rawWaveData > 32768) rawWaveData -= 65536;
                
                NSLog(@"Raw:%d",rawWaveData);
                
            }
            i += valueBytesLength;
        }
        else
        {
            switch (code)
            {
                case PARSER_CODE_POOR_SIGNAL:
                    signal = payload[i] & 0xFF;
                    i += valueBytesLength;
                    NSLog(@"PQ: %d",signal);
                    break;
                case PARSER_CODE_EEG_POWER:
                    i += valueBytesLength;
                    break;
                case PARSER_CODE_CONFIGURATION:
                    if ( signal == 29 || signal == 54 || signal == 55 || signal == 56 || signal == 80 || signal == 81 || signal == 82 || signal == 107 || signal == 200)
                    {
                        config = payload[i] & 0xFF;
                        
                        NSLog(@"--NoShouldAtt: %d",config);
                        
                        NSLog(@"\n");
                        
                        
                        i += valueBytesLength;
                        
                        break;
                    }
                    else
                    {
                        
                        config = payload[i] & 0xFF;
                        
                        NSLog(@"--Att: %d",config);
                        NSLog(@"\n");
                        
                    }
                    
                    i += valueBytesLength;
                    break;
                case PARSER_CODE_HEARTRATE:
                    heartrate = payload[i] & 0xFF;
                    i += valueBytesLength;
                    
                    break;
                case PARSER_CODE_DEBUG_ONE:
                    if (valueBytesLength == EEG_DEBUG_ONE_BYTE_LENGTH)
                    {
                        i += valueBytesLength;
                    }
                    break;
                case PARSER_CODE_DEBUG_TWO:
                    if (valueBytesLength == EEG_DEBUG_TWO_BYTE_LENGTH)
                    {
                        i += valueBytesLength;
                    }
                    break;
            }
        }
    }
    parserStatus = PARSER_STATE_SYNC;
}
- (int )getRawWaveValue:(Byte )highOrderByte lowOrderByte:(Byte )lowOrderByte
{
    /* Sign-extend the signed high byte to the width of a signed int */
    int hi = (int)highOrderByte;
    
    /* Extend low to the width of an int, but keep exact bits instead of sign-extending */
    int lo = ((int)lowOrderByte) & 0xFF;
    
    /* Calculate raw value by appending the exact low bits to the sign-extended high bits */
    int value = (hi << 8) | lo;
    
    return (value);
}
//校正
- (BOOL)checkSumIsOk:(NSString *)conter
{
    //校验 头+长度(96)
    NSRange range;
    range = [conter rangeOfString:@"aaaa2002"];
    if (range.location != NSNotFound) {
        if (conter.length == 96) {
            return YES;
        }
    }
    return NO;
}
- (void)setObjectForKeystr:(NSString *)conteStr did:(NSMutableDictionary *)dddd
{
    conteStr = [conteStr stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSInteger starX = 8;
    
    //截取字符串
    NSString *singelValue = [conteStr substringWithRange:NSMakeRange(starX,2)];
    
    starX += 6;
    
    NSString *Deltavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *Thetavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *LowAlphavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *HighAlphavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *LowBetavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *HighBetavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *LowGammavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *MiddleGammavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *Attentionvalue = [conteStr substringWithRange:NSMakeRange(starX+2, 2)];
    
    starX += 4;
    
    NSString *Meditationvalue = [conteStr substringWithRange:NSMakeRange(starX+2, 2)];
    
    starX += 4;
    
    //验证是否有效
    NSString *checkSum = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    
    starX += 10;

    NSString *yearStr = [conteStr substringWithRange:NSMakeRange(starX, 4)];
    starX += 4;
    
    NSInteger year = strtol([yearStr UTF8String], 0, 16);
    
    NSString *yueStr = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger yue = strtol([yueStr UTF8String], 0, 16);
    
    NSString *dayStr = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger day = strtol([dayStr UTF8String], 0, 16);
    
    NSString *hourStr = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger hour = strtol([hourStr UTF8String], 0, 16);
    
    NSString *mintrStr = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger minte = strtol([mintrStr UTF8String], 0, 16);
    
    NSString *miaoStr = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger miao = strtol([miaoStr UTF8String], 0, 16);
    
    NSString *weakStr = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger weak = strtol([weakStr UTF8String], 0, 16);
    
    
    int checksum = strtoul([checkSum UTF8String], 0, 16);
    
    if ([self checkSumIsOk:conteStr]) {
        //验证成功 开始存数数据
        
        NSMutableDictionary *createDic = [[NSMutableDictionary alloc] init];
        
        [createDic setObject:singelValue forKey:@"singel"];
        
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:Deltavalue]] forKey:@"Delta"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:Thetavalue]] forKey:@"Theta"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:LowAlphavalue]] forKey:@"LowAlpha"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:HighAlphavalue]] forKey:@"highAlpha"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:LowBetavalue]] forKey:@"LowBeta"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:HighBetavalue]] forKey:@"highBeta"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:LowGammavalue]] forKey:@"LowGamma"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:MiddleGammavalue]] forKey:@"MiddleGamma"];
        
        NSInteger Attentionvalue1 = strtol([Attentionvalue UTF8String],0,16);
        NSInteger Meditationvalue1 = strtol([Meditationvalue UTF8String], 0, 16);
        [createDic setObject:[NSNumber numberWithInteger:Attentionvalue1] forKey:@"Attention"];
        [createDic setObject:[NSNumber numberWithInteger:Meditationvalue1] forKey:@"Meditation"];
        
        NSString *key = [NSString stringWithFormat:@"%zd:%zd:%@%zd",hour,minte,(miao < 10) ? @"0" : @"",miao];
        
        [dddd setObject:createDic forKey:key];
    }
    
}

- (void)setSamllObjectForKey:(NSMutableDictionary *)dic str:(NSString *)conteStr
{
    //0000015f07df010101050a0400
    conteStr = [conteStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *timeStr = [conteStr substringWithRange:NSMakeRange(conteStr.length - 18, 18)];
    NSInteger starX = 0;
    NSString *yearStr = [timeStr substringWithRange:NSMakeRange(starX, 4)];
    starX += 4;
    
    NSInteger year = strtol([yearStr UTF8String], 0, 16);
    NSString *yueStr = [timeStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger yue = strtol([yueStr UTF8String], 0, 16);
    NSString *dayStr = [timeStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger day = strtol([dayStr UTF8String], 0, 16);
    NSString *hourStr = [timeStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger hour = strtol([hourStr UTF8String], 0, 16);
    NSString *mintrStr = [timeStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger minte = strtol([mintrStr UTF8String], 0, 16);
    NSString *miaoStr = [timeStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger miao = strtol([miaoStr UTF8String], 0, 16);
    NSString *weakStr = [timeStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger weak = strtol([weakStr UTF8String], 0, 16);
    
    NSString *dataStr = [conteStr substringToIndex:conteStr.length - 26];
    
    NSMutableArray *allData = [[NSMutableArray alloc] init];
    
    NSInteger fengeStar = 0;
    
    for (int i=0 ; i< dataStr.length/4; i++) {

        NSString *str = [dataStr substringWithRange:NSMakeRange(fengeStar, 4)];
        fengeStar += 4;
        
        NSInteger num = strtol([str UTF8String], 0, 16);
        
        [allData addObject:[NSNumber numberWithInteger:num]];
    }
    
    NSString *key = [NSString stringWithFormat:@"%zd-%zd-%zd-%zd-%zd-%zd",year,yue,day,hour,minte,miao];
    
    [dic setObject:allData forKey:key];
    
    
}
- (int )backRowData:(NSString *)value
{
    NSString *one = [value substringWithRange:NSMakeRange(0, 2)];
    NSString *two = [value substringWithRange:NSMakeRange(2, 2)];
    NSString *three = [value substringWithRange:NSMakeRange(4, 2)];
    int Delta = [self getRawWaveValue:strtol([one UTF8String], 0, 16) ZhongOrderByte:strtol([two UTF8String], 0, 16) lowOrderByte:strtol([three UTF8String], 0, 16)];
    return Delta;
}
- (NSMutableData *)huahsakdsa:(NSString *)str
{
    const char *buf = [str UTF8String];
    NSMutableData *data = [NSMutableData data];
    if (buf)
    {
        uint32_t len = strlen(buf);
        
        char singleNumberString[3] = {'\0', '\0', '\0'};
        uint32_t singleNumber = 0;
        for(uint32_t i = 0 ; i < len; i+=2)
        {
            if ( ((i+1) < len) && isxdigit(buf[i]) && (isxdigit(buf[i+1])) )
            {
                singleNumberString[0] = buf[i];
                singleNumberString[1] = buf[i + 1];
                sscanf(singleNumberString, "%x", &singleNumber);
                uint8_t tmp = (uint8_t)(singleNumber & 0x000000FF);
                [data appendBytes:(void *)(&tmp)length:1];
            }
            else
            {
                break;
            }
        }
        
        return data;
    }
    return nil;
}
- (int )getRawWaveValue:(int  )highOrderByte ZhongOrderByte:(int )zhongOrderByte lowOrderByte:(int)lowOrderByte
{
    //高字节左移16位,中字节左移8位,低字节不变,然后将他们或运算,得到的结 果就是Delta的值
    int hi = (int)highOrderByte;
    int zh = (int)zhongOrderByte;
    int lo = (int)lowOrderByte;
    int value = (hi << 16) | (zh << 8) | lo;
    return (value);
}
//数据解析
- (NSMutableDictionary *)getDataDic:(NSString *)strConent
{
    //剥去外层<>
    strConent = [strConent stringByReplacingOccurrencesOfString:@"<" withString:@""];
    strConent = [strConent stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSArray *getAllData = [strConent componentsSeparatedByString:KEY_ALL_DATA];
    
    NSMutableDictionary *samlldata = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *bigData = [[NSMutableDictionary alloc] init];
    for (NSString *str in getAllData) {
        /*解析大包数据*/
        NSMutableArray *array = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:BIG_ITEM_KEY]];
        [array removeObjectAtIndex:0];
        
        for (NSString *itemStr in array) {
            NSString *NewitemStr = [NSString stringWithFormat:@"%@%@",BIG_ITEM_KEY,itemStr];
            NSArray *lastArray = [NewitemStr componentsSeparatedByString:@"00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000"];
            if ([lastArray count] >= 2) {
                NewitemStr = [lastArray firstObject];
            }
            [self setObjectForKeystr:NewitemStr did:bigData];
        }
        
        /*解析小包数据*/
        NSMutableArray *samllArray = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:SAMLL_ITEM_KEY]];
        [samllArray removeObjectAtIndex:0];
        for (NSString *itemStr in samllArray) {
            NSString *NewitemStr = [NSString stringWithFormat:@"%@",itemStr];
            NSArray *lastArray = [NewitemStr componentsSeparatedByString:BIG_ITEM_KEY];
            if ([lastArray count] >= 2) {
                NewitemStr = [lastArray firstObject];
            }
            [self setSamllObjectForKey:samlldata str:NewitemStr];
        }
    }
    
    [PlistReadWirte ModifyArray:samlldata];
    [PlistReadWirte Modify:bigData];
    return nil;
}

- (NSDictionary *)getBigDataStr:(NSString *)conteStr
{
    NSInteger starX = 8;

    //截取字符串
    NSString *singelValue = [conteStr substringWithRange:NSMakeRange(starX,2)];
    
    starX += 6;
    
    NSString *Deltavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *Thetavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *LowAlphavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *HighAlphavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *LowBetavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *HighBetavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *LowGammavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *MiddleGammavalue = [conteStr substringWithRange:NSMakeRange(starX, 6)];
    
    starX += 6;
    
    NSString *Attentionvalue = [conteStr substringWithRange:NSMakeRange(starX+2, 2)];
    
    starX += 4;
    
    NSString *Meditationvalue = [conteStr substringWithRange:NSMakeRange(starX+2, 2)];
    
    starX += 4;
    
    //验证是否有效
    NSString *checkSum = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    
    starX += 10;
    
    NSString *yearStr = [conteStr substringWithRange:NSMakeRange(starX, 4)];
    starX += 4;
    
    NSInteger year = strtol([yearStr UTF8String], 0, 16);
    
    NSString *yueStr = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger yue = strtol([yueStr UTF8String], 0, 16);
    
    NSString *dayStr = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger day = strtol([dayStr UTF8String], 0, 16);
    
    NSString *hourStr = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger hour = strtol([hourStr UTF8String], 0, 16);
    
    NSString *mintrStr = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger minte = strtol([mintrStr UTF8String], 0, 16);
    
    NSString *miaoStr = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger miao = strtol([miaoStr UTF8String], 0, 16);
    
    NSString *weakStr = [conteStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger weak = strtol([weakStr UTF8String], 0, 16);
    
    
    int checksum = strtoul([checkSum UTF8String], 0, 16);
    
    NSMutableDictionary *dddd = [[NSMutableDictionary alloc] init];
    
    if ([self checkSumIsOk:conteStr]) {
        //验证成功 开始存数数据
        
        NSMutableDictionary *createDic = [[NSMutableDictionary alloc] init];
        
        
        
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:Deltavalue]] forKey:@"Delta"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:Thetavalue]] forKey:@"Theta"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:LowAlphavalue]] forKey:@"LowAlpha"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:HighAlphavalue]] forKey:@"highAlpha"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:LowBetavalue]] forKey:@"LowBeta"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:HighBetavalue]] forKey:@"highBeta"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:LowGammavalue]] forKey:@"LowGamma"];
        [createDic setObject:[NSNumber numberWithInt:[self backRowData:MiddleGammavalue]] forKey:@"MiddleGamma"];
        
        NSInteger Attentionvalue1 = strtol([Attentionvalue UTF8String],0,16);
        NSInteger Meditationvalue1 = strtol([Meditationvalue UTF8String], 0, 16);
        [createDic setObject:[NSNumber numberWithInteger:Attentionvalue1] forKey:@"Attention"];
        [createDic setObject:[NSNumber numberWithInteger:Meditationvalue1] forKey:@"Meditation"];
        
        
        NSString *singalValue = [conteStr substringWithRange:NSMakeRange(8,2)];
        NSInteger signal = strtol([singalValue UTF8String], 0, 16);
        
        [createDic setObject:[NSNumber numberWithInteger:signal] forKey:@"singel"];
        
        
        NSString *key = [NSString stringWithFormat:@"%zd:%zd:%@%zd",hour,minte,(miao < 10) ? @"0" : @"",miao];
        
        [dddd setObject:createDic forKey:key];
    }

    return dddd;
}
- (NSMutableDictionary *)getSamllObjectForKeystr:(NSString *)conteStr
{
    
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    if (!conteStr.length > 0) {
        return dic;
    }
    
    //0000015f07df010101050a0400
    conteStr = [conteStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *timeStr = [conteStr substringWithRange:NSMakeRange(conteStr.length - 18, 18)];
    NSInteger starX = 0;
    NSString *yearStr = [timeStr substringWithRange:NSMakeRange(starX, 4)];
    starX += 4;
    
    NSInteger year = strtol([yearStr UTF8String], 0, 16);
    NSString *yueStr = [timeStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger yue = strtol([yueStr UTF8String], 0, 16);
    NSString *dayStr = [timeStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger day = strtol([dayStr UTF8String], 0, 16);
    NSString *hourStr = [timeStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger hour = strtol([hourStr UTF8String], 0, 16);
    NSString *mintrStr = [timeStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger minte = strtol([mintrStr UTF8String], 0, 16);
    NSString *miaoStr = [timeStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger miao = strtol([miaoStr UTF8String], 0, 16);
    NSString *weakStr = [timeStr substringWithRange:NSMakeRange(starX, 2)];
    starX += 2;
    
    NSInteger weak = strtol([weakStr UTF8String], 0, 16);
    
    NSString *dataStr = [conteStr substringToIndex:conteStr.length - 26];
    
    dataStr = [dataStr stringByReplacingOccurrencesOfString:@"aaaa048002" withString:@""];
    
    NSMutableArray *allData = [[NSMutableArray alloc] init];
    
    NSInteger fengeStar = 0;
    
    for (int i=0 ; i< dataStr.length/4; i++) {
        
        NSString *str = [dataStr substringWithRange:NSMakeRange(fengeStar, 4)];
        fengeStar += 4;
        NSInteger num1 = 0;
        NSString *fuhao = [str substringWithRange:NSMakeRange(0,1)];
        NSString *shuzhi = [str substringWithRange:NSMakeRange(1,str.length - 1)];
        if ([fuhao isEqualToString:@"f"] || [fuhao isEqualToString:@"F"]) {//附属
            int numOne = strtol([str UTF8String], 0, 16);
            int numTwo = strtol([@"0XFFFF" UTF8String], 0, 16);;
            num1 =  numOne - numTwo;
        }
        else
        {
            num1 = strtol([shuzhi UTF8String], 0, 16);
        }
        
        [allData addObject:[NSNumber numberWithInteger:num1]];
    }
    
    NSString *key = [NSString stringWithFormat:@"%zd-%zd-%zd-%zd-%zd-%zd",year,yue,day,hour,minte,miao];
    
    [dic setObject:allData forKey:key];
    
    return dic;
}


-(NSData *)HexConvertToASCII:(NSString *)hexString{
    int j=0;
    Byte bytes[hexString.length/2];  ///3ds key的Byte 数组， 128位
    for(int i=0;i<[hexString length];i++)
    {
        int int_ch;  /// 两位16进制数转化后的10进制数
        
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        
        int int_ch1;
        
        if(hex_char1 >= '0' && hex_char1 <='9')
            
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        
        else
            
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        
        int int_ch2;
        
        if(hex_char2 >= '0' && hex_char2 <='9')
            
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        
        else
            
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        
        
        int_ch = int_ch1+int_ch2;
        
        NSLog(@"int_ch=%d",int_ch);
        
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        
        j++;
        
    }
    
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:hexString.length/2];
    return newData;
}


- (NSString *)backDreciv:(NSString *)str
{
    NSString *aString = [[NSString alloc] initWithData:[self HexConvertToASCII:str] encoding:NSASCIIStringEncoding];
    return aString;
}

@end
