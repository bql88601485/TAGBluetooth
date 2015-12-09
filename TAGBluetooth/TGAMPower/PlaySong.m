//
//  PlaySong.m
//  TGAMPower
//
//  Created by bai on 15-7-31.
//  Copyright (c) 2015年 bai. All rights reserved.
//

#import "PlaySong.h"
#import <AudioToolbox/AudioToolbox.h>
@implementation PlaySong

+ (void)playSound:(NSString *)fName :(NSString *) ext
{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:fName] boolValue]) {
        
        SystemSoundID soundID;
        NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:fName ofType:ext];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
        AudioServicesPlaySystemSound(soundID);
    }
    
}

@end
