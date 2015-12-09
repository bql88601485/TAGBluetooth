//
//  ViewController.h
//  TGAMPower
//
//  Created by bai on 15/7/6.
//  Copyright (c) 2015年 bai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SerialGATT.h"
// the eSense values
typedef struct {
    int attention;
    int meditation;
} ESenseValues;

// the EEG power bands
typedef struct {
    int delta;
    int theta;
    int lowAlpha;
    int highAlpha;
    int lowBeta;
    int highBeta;
    int lowGamma;
    int highGamma;
} EEGValues;

@interface ViewController : UIViewController<BTSmartSensorDelegate>
{
    short rawValue;
    int rawCount;
    int buffRawCount;
    int blinkStrength;
    int poorSignalValue;
    int heartRate;
    float respiration;
    int heartRateAverage;
    int heartRateAcceleration;
    
    ESenseValues eSenseValues;
    EEGValues eegValues;
    
    bool logEnabled;
    NSFileHandle * logFile;
    NSMutableData * output;
    
    UIView * loadingScreen;
    
    NSThread * updateThread;

}
@property (strong, nonatomic) SerialGATT *sensor;
@property (nonatomic, retain) NSMutableArray *peripheralViewControllerArray;

- (UIImage *)updateSignalStatus;

- (void)initLog;
- (void)writeLog;

@property (nonatomic, retain) IBOutlet UIView * loadingScreen;

@end

