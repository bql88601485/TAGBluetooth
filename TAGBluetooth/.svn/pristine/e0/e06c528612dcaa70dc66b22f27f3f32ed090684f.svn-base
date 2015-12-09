//
//  ViewController.m
//  TGAMPower
//
//  Created by bai on 15/7/6.
//  Copyright (c) 2015年 bai. All rights reserved.
//

#import "ViewController.h"
#import "PopDriverViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "QuartzCore/QuartzCore.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"
#import "FPNumberPadView.h"
#import "ParserObject.h"
#import "PlistReadWirte.h"

#import "FSLineChart.h"
#import "UIColor+FSPalette.h"

#import "PNLineChartView.h"
#import "PNPlot.h"

#import "UIWindow+YzdHUD.h"

#import <AVFoundation/AVFoundation.h>
#import "lame.h"
#import "CBChartView.h"

#import "TWRChart.h"

#import "PlaySong.h"

#import "OldlistViewController.h"

#import "ShowLIneViewController.h"

#import "KSViewController.h"


#define RSSI_THRESHOLD -60
#define WARNING_MESSAGE @"z"

#define KEY_FENGE_  @"a111111111111111111111111111111b"

@interface ViewController ()<AVAudioRecorderDelegate>
{
    NSString *fileName;
    
    
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    AVAudioSession * audioSession;
    
    NSURL* recordUrl;
   
    NSURL* audioFileSavePath;
    
    NSMutableDictionary *getDic ;
    NSMutableDictionary *getSamll;
    
    NSMutableArray *bqlArr;
    
    
    BOOL lianjieOK;
    
    
    BOOL kaishiReading;
    
    
    BOOL oldReadingStop;
}
@property (nonatomic, strong)  NSURL* mp3FilePath;
@property (nonatomic, strong) PopDriverViewController *vc;
@property (nonatomic, strong) UIPopoverController *popDriverList;

@property (nonatomic, strong) OldlistViewController *oldvc;
@property (nonatomic, strong) UIPopoverController *popoldList;

@property (strong, nonatomic) NSMutableArray *rssi_container; // used for contain the indexers of the lower rssi value

@property (weak, nonatomic) IBOutlet UITextField *MsgToBTMode;
@property (weak, nonatomic) IBOutlet UILabel *lbDevice;
@property (strong, nonatomic) ShowLIneViewController *kViewOne;
@property (strong, nonatomic) ShowLIneViewController *kViewTwo;

@property (strong, nonatomic) KSViewController *kViewThree;

@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewtow;
@property (weak, nonatomic) IBOutlet UIView *viewthree;


@property (weak, nonatomic) IBOutlet UILabel *tipsLable;
@property (weak, nonatomic) IBOutlet UILabel *deviceLable;


@property (weak, nonatomic) IBOutlet UIScrollView *bgView;


@property (weak, nonatomic) IBOutlet UITextField *deltafile;
@property (weak, nonatomic) IBOutlet UITextField *lowAlpha;
@property (weak, nonatomic) IBOutlet UITextField *lowbeta;
@property (weak, nonatomic) IBOutlet UITextField *lowgamma;
@property (weak, nonatomic) IBOutlet UITextField *middlegamma;
@property (weak, nonatomic) IBOutlet UITextField *theta;
@property (weak, nonatomic) IBOutlet UITextField *highalpha;
@property (weak, nonatomic) IBOutlet UITextField *highbeta;



@property (weak, nonatomic) IBOutlet UILabel *huiguData;



@property (weak, nonatomic) IBOutlet UIButton *kaishiJcButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (weak, nonatomic) IBOutlet UIButton *stopOldData;


- (void)setLoadingScreenView;

@property (weak, nonatomic) IBOutlet UIButton *oldListButton;
@end

@implementation ViewController
@synthesize sensor;
@synthesize peripheralViewControllerArray;
NSInteger numiii = 0;
NSInteger tongji = 1;
NSInteger countNum = 1;
- (void)initSallView:(BOOL)boo
{
    if (boo) {
        [getSamll removeAllObjects];
        return;
    }
    [getSamll removeAllObjects];
    [_kViewThree.view removeFromSuperview];
    
    bqlArr = [[NSMutableArray alloc] init ];
    
    _kViewThree = [[KSViewController alloc] initWithNibName:@"KSViewController" bundle:nil];
    _kViewThree.view.backgroundColor    = [UIColor clearColor];
    [_kViewThree.view setFrame:CGRectMake(-10, 0, _viewthree.bounds.size.width + 20, _viewthree.bounds.size.height)];
    [_viewthree addSubview:_kViewThree.view];
    _kViewThree.xValue = 0;
    
    
}
- (void)initallView:(BOOL)boo
{
    if (boo) {
        [getDic removeAllObjects];
        return;
    }
    [getDic removeAllObjects];
    [_kViewOne.view removeFromSuperview];
    [_kViewTwo.view removeFromSuperview];
    _kViewOne = nil;
    _kViewTwo = nil;
    
    _kViewOne = [ShowLIneViewController showCreatLineView];
    [_kViewOne.view setFrame:_viewOne.bounds];
    _kViewOne.view.backgroundColor    = [UIColor clearColor];
    [_viewOne addSubview:_kViewOne.view];
    
    [_kViewOne createInitall:_viewOne.bounds :3000000 :20 :@"600000"];
    
    [_kViewOne creatPlotInit:[CPTColor colorWithComponentRed:195.0/255 green:195.0/255 blue:188.0/255 alpha:1.0] :@"A" touming:[CPTColor colorWithComponentRed:0.76 green:0.76 blue:0.73 alpha:0.1]];
    [_kViewOne creatPlotInit:[CPTColor colorWithComponentRed:178.0/255 green:189.0/255 blue:204.0/255 alpha:1.0] :@"B" touming:[CPTColor colorWithComponentRed:0.69 green:0.74 blue:0.8 alpha:0.1]];
    [_kViewOne creatPlotInit:[CPTColor colorWithComponentRed:228.0/255 green:229.0/255 blue:158.0/255 alpha:1.0] :@"C" touming:[CPTColor colorWithComponentRed:0.69 green:0.89 blue:0.61 alpha:0.1]];
    [_kViewOne creatPlotInit:[CPTColor colorWithComponentRed:254.0/255 green:244.0/255 blue:244.0/255 alpha:1.0] :@"D" touming:[CPTColor colorWithComponentRed:0.99 green:0.95 blue:0.95 alpha:0.1]];
    [_kViewOne creatPlotInit:[CPTColor colorWithComponentRed:172.0/255 green:224.0/255 blue:160.0/255 alpha:1.0] :@"E" touming:[CPTColor colorWithComponentRed:0.67 green:0.87 blue:0.62 alpha:0.1]];
    [_kViewOne creatPlotInit:[CPTColor colorWithComponentRed:148.0/255 green:243.0/255 blue:143.0/255 alpha:1.0] :@"F" touming:[CPTColor colorWithComponentRed:0.58 green:0.95 blue:0.56 alpha:0.1]];
    [_kViewOne creatPlotInit:[CPTColor colorWithComponentRed:218.0/255 green:177.0/255 blue:170.0/255 alpha:1.0] :@"G" touming:[CPTColor colorWithComponentRed:0.85 green:0.69 blue:0.66 alpha:0.1]];
    [_kViewOne creatPlotInit:[CPTColor colorWithComponentRed:243.0/255 green:145.0/255 blue:140.0/255 alpha:1.0] :@"H" touming:[CPTColor colorWithComponentRed:0.95 green:0.56 blue:0.54 alpha:0.1]];
    
    
    
    _kViewTwo = [ShowLIneViewController showCreatLineView];
    [_kViewTwo.view setFrame:_viewtow.bounds];
    _kViewTwo.view.backgroundColor   = [UIColor clearColor];
    
    [_kViewTwo createInitall:_viewOne.bounds :100 :20 :@"50"];
    

    [_kViewTwo creatPlotInit:[CPTColor colorWithComponentRed:146.0/255 green:194.0/255 blue:140.0/255 alpha:1.0] :@"A" touming:[CPTColor colorWithComponentRed:0.57 green:0.76 blue:0.54 alpha:0.3]];
    [_kViewTwo creatPlotInit:[CPTColor colorWithComponentRed:145.0/255 green:147.0/255 blue:235.0/255 alpha:1.0] :@"B" touming:[CPTColor colorWithComponentRed:0.56 green:0.57 blue:0.92 alpha:0.3]];
    [_kViewTwo creatPlotInit:[CPTColor colorWithComponentRed:243.0/255 green:145.0/255 blue:140.0/255 alpha:1.0] :@"C" touming:[CPTColor colorWithComponentRed:243.0/255 green:145.0/255 blue:140.0/255 alpha:0.3]];
    
    [_viewtow addSubview:_kViewTwo.view];
    
    
}

- (void)connetBlut:(CBPeripheral *)perI
{
    if (sensor.activePeripheral && sensor.activePeripheral != perI) {
        [sensor disconnect:sensor.activePeripheral];
    }
    
    sensor.activePeripheral = perI;
    [sensor connect:sensor.activePeripheral];
}

- (IBAction)selectAction:(id)sender {

    _vc= [[PopDriverViewController alloc] initWithNibName:@"PopDriverViewController" bundle:nil];
    _vc.view.frame = CGRectMake(0, 0, 300, 400);

    _popDriverList = [[UIPopoverController alloc] initWithContentViewController:_vc];
    
    _popDriverList.popoverContentSize = CGSizeMake(300,400);
    CGRect rect = CGRectMake(60,80,10,10);
    
    //弹出关于界面
    [_popDriverList presentPopoverFromRect:rect         //中心点是用来画箭头的，如果中心点如果出了屏幕，系统会优化到窗口边缘
                                             inView:self.view
                           permittedArrowDirections:UIPopoverArrowDirectionUp   //箭头方向
                                           animated:YES];
    
    
    if ([sensor activePeripheral]) {
        if (sensor.activePeripheral.state == CBPeripheralStateConnected) {
            [sensor.manager cancelPeripheralConnection:sensor.activePeripheral];
            sensor.activePeripheral = nil;
        }
    }
    
    if ([sensor peripherals]) {
        sensor.peripherals = nil;
        [peripheralViewControllerArray removeAllObjects];
    }
    
    sensor.delegate = self;
    printf("now we are searching device...\n");
    [sensor findBLKAppPeripherals:5];
    
    __weak ViewController  *weakSelf = self;
    _vc.perI = ^(CBPeripheral *perI)
    {
        [weakSelf.popDriverList dismissPopoverAnimated:YES];
        [weakSelf connetBlut:perI];
        
    };
}
- (UIImage *)updateSignalStatus {
    
    if(poorSignalValue == 0) {
        return [UIImage imageNamed:@"Signal_Connected"];
    }
    else if(poorSignalValue > 0 && poorSignalValue < 50) {
        return [UIImage imageNamed:@"Signal_Connecting3"];
    }
    else if(poorSignalValue > 50 && poorSignalValue < 200) {
        return [UIImage imageNamed:@"Signal_Connecting2"];
    }
    else if(poorSignalValue == 200) {
        return [UIImage imageNamed:@"Signal_Connecting1"];
    }
    else {
        return [UIImage imageNamed:@"Signal_Disconnected"];
    }
}
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
}

- (void)handleTap
{
    [_MsgToBTMode resignFirstResponder];
}
// 设置录音和播放同时进行、且扬声器播放
-(void)SetRecordPlayAtSameTime_Func
{
    // 同时录音和播放
    UInt32 sessionCategory = kAudioSessionCategory_PlayAndRecord;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
    
    // 扬声器播放
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute, sizeof(audioRouteOverride), &audioRouteOverride);
    
    AudioSessionSetActive(true);
    
    /*
     AVAudioSession* session = [AVAudioSession sharedInstance];
     [session setCategory:AVAudioSessionCategoryPlayback error:nil];
     [session setActive: YES error:nil];
     */
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;
    
    
    
    [self SetRecordPlayAtSameTime_Func];

    _stopOldData.enabled = NO;
    
    NSNumber *nub = [NSNumber numberWithBool:NO];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"luyin"];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"delta"];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"theta"];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"lowalpha"];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"highalpha"];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"lowbeta"];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"highbeta"];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"lowgamma"];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"highgamma"];
    
    getDic = [[NSMutableDictionary alloc] init];
    getSamll = [[NSMutableDictionary alloc] init];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    sensor = [[SerialGATT alloc] init];
    [sensor setup];
    sensor.delegate = self;
    
    peripheralViewControllerArray = [[NSMutableArray alloc] init];
    
    
//
    
    
    //听键盘
    FPNumberPadView *numberPadView = [[FPNumberPadView alloc] initWithFrame:CGRectMake(0, 0, 1024, 178)];
    numberPadView.textField = _MsgToBTMode;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.view addGestureRecognizer:tap];
    
    __weak ViewController *weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself initallView:NO];
        [weakself initSallView:NO];
    });
    
}
- (void)stopMINGling
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - BLKAppSensorDelegate
-(void) peripheralFound:(CBPeripheral *)peripheral
{
    [peripheralViewControllerArray addObject:peripheral];
    [_vc setPeripheralViewControllerArray:peripheralViewControllerArray];
}

#pragma mark connetOk
// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"=======字符串=======%@",unicodeString);
    return unicodeString;
}

BOOL findHeadBIG = NO;
BOOL findHeadSamll = NO;
NSString *getStrSamll = @"";
NSString *getStrBig = @"";


BOOL findTogetDrow = NO;


#define BIG_DATA_HEAD   @"aaaa2002"
#define SAMILL_DATA_HEAD   @"aaaa0480"

//recv data
-(void) serialGATTCharValueUpdated:(NSString *)UUID value:(NSData *)data
{
    
    if (!output) {
        output = [[NSMutableData alloc] init];
    }
    
    
    
//    NSLog(@"我来了 ：\n \n %@ \n \n",data);
    //分析数据
    NSString *bigStr = [NSString stringWithFormat:@"%@",data];
    bigStr = [bigStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    bigStr = [bigStr stringByReplacingOccurrencesOfString:@">" withString:@""];
    bigStr = [bigStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSArray *getDrice = [bigStr componentsSeparatedByString:@"1001aa09aa"];
    
    if (getDrice.count == 2) {
        
        NSString *diceStr = [getDrice[1] stringByReplacingOccurrencesOfString:@"0d0a" withString:@""];
        
       NSString *diceName = [[ParserObject shareManager] backDreciv:diceStr];
        
        self.deviceLable.text = diceName;
        
        return;
    }
    
    
    NSArray *bigArray = [bigStr componentsSeparatedByString:BIG_DATA_HEAD];
    
    NSArray *samllArray = [bigStr componentsSeparatedByString:SAMILL_DATA_HEAD];
    
    if (samllArray.count == 2) {//发现了小包数据
        
        findTogetDrow = YES;
        
        if (findHeadSamll) {
            
            findHeadSamll = NO;
            
            getStrSamll = [NSString stringWithFormat:@"%@%@",getStrSamll,samllArray[0]];
            
            getStrSamll = [getStrSamll stringByReplacingOccurrencesOfString:@"<" withString:@""];
            getStrSamll = [getStrSamll stringByReplacingOccurrencesOfString:@">" withString:@""];
            getStrSamll = [getStrSamll stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSMutableData *data0 = [self huahsakdsa:samllArray[0]];
            
            NSMutableData *data1 = [self huahsakdsa:KEY_FENGE_];
            
            NSMutableData *data2 = [self huahsakdsa:[NSString stringWithFormat:@"%@%@",SAMILL_DATA_HEAD,samllArray[1]]];
            
            [output appendData:data0];
            
            [output appendData:data1];
            
            [output appendData:data2];
            
            
//            [self Samllfenjieshuju:0 :@[getStrSamll] :getSamll];
            
            
            getStrSamll = [NSString stringWithFormat:@"%@%@",SAMILL_DATA_HEAD,samllArray[1]];
            
            findHeadSamll = YES;
        }
        else if (findHeadBIG)//从大包数据过来的
        {
            
            findHeadSamll = YES;
            
            findHeadBIG = NO;
            
            getStrBig = [NSString stringWithFormat:@"%@%@",getStrBig,samllArray[0]];
            
            getStrBig = [getStrBig stringByReplacingOccurrencesOfString:@"<" withString:@""];
            getStrBig = [getStrBig stringByReplacingOccurrencesOfString:@">" withString:@""];
            getStrBig = [getStrBig stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSMutableData *data0 = [self huahsakdsa:samllArray[0]];
            
            NSMutableData *data1 = [self huahsakdsa:KEY_FENGE_];
            
            NSMutableData *data2 = [self huahsakdsa:[NSString stringWithFormat:@"%@%@",SAMILL_DATA_HEAD,samllArray[1]]];
            
            [output appendData:data0];
            
            [output appendData:data1];
            
            [output appendData:data2];
            
            
            
            
            
            [self fenjieshuju:0 :@[getStrBig] :getDic];
            
            [self Samllfenjieshuju:0 :@[getStrSamll] :getSamll];
            
            getStrSamll = [NSString stringWithFormat:@"%@%@",SAMILL_DATA_HEAD,samllArray[1]];

        }
        else
        {
            findHeadSamll = YES;
            
            NSMutableData *data2 = [self huahsakdsa:[NSString stringWithFormat:@"%@%@",SAMILL_DATA_HEAD,samllArray[1]]];
            
            [output appendData:data2];
            
            getStrSamll = [NSString stringWithFormat:@"%@%@",SAMILL_DATA_HEAD,samllArray[1]];
        }
    }
    else if (bigArray.count == 2)//发现大包数据
    {
        if (findHeadBIG) {
            
            findHeadBIG = NO;
            
            getStrBig = [NSString stringWithFormat:@"%@%@",getStrBig,bigArray[0]];
            
            getStrBig = [getStrBig stringByReplacingOccurrencesOfString:@"<" withString:@""];
            getStrBig = [getStrBig stringByReplacingOccurrencesOfString:@">" withString:@""];
            getStrBig = [getStrBig stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSMutableData *data0 = [self huahsakdsa:bigArray[0]];
            
            NSMutableData *data1 = [self huahsakdsa:KEY_FENGE_];
            
            NSMutableData *data2 = [self huahsakdsa:[NSString stringWithFormat:@"%@%@",BIG_DATA_HEAD,bigArray[1]]];
            
            [output appendData:data0];
            
            [output appendData:data1];
            
            [output appendData:data2];
            
            
//            NSLog(@"我完成一个 ：\n \n %@ \n \n",getStrBig);
            
            
//            [self fenjieshuju:0 :@[getStrBig] :getDic];
            
            
            getStrBig = [NSString stringWithFormat:@"%@%@",BIG_DATA_HEAD,bigArray[1]];
            
            findHeadBIG = YES;
            
            
 //           NSLog(@"我完成下一个开始 ：\n \n %@ \n \n",getStrBig);
            
        }
        else if (findHeadSamll)//从小包数据过来
        {
            
            findHeadBIG = YES;
            
            findHeadSamll = NO;
            
            getStrSamll = [NSString stringWithFormat:@"%@%@",getStrSamll,bigArray[0]];
            
            getStrSamll = [getStrSamll stringByReplacingOccurrencesOfString:@"<" withString:@""];
            getStrSamll = [getStrSamll stringByReplacingOccurrencesOfString:@">" withString:@""];
            getStrSamll = [getStrSamll stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSMutableData *data0 = [self huahsakdsa:bigArray[0]];
            
            NSMutableData *data1 = [self huahsakdsa:KEY_FENGE_];
            
            NSMutableData *data2 = [self huahsakdsa:[NSString stringWithFormat:@"%@%@",BIG_DATA_HEAD,bigArray[1]]];
            
            [output appendData:data0];
            
            [output appendData:data1];
            
            [output appendData:data2];
            
//            [self Samllfenjieshuju:0 :@[getStrSamll] :getSamll];
            
            getStrBig = [NSString stringWithFormat:@"%@%@",BIG_DATA_HEAD,bigArray[1]];
            
//            getStrSamll = @"";
        }
        else
        {
            findHeadBIG = YES;
            
            NSMutableData *data2 = [self huahsakdsa:[NSString stringWithFormat:@"%@%@",BIG_DATA_HEAD,bigArray[1]]];
            
            [output appendData:data2];
            
            getStrBig = [NSString stringWithFormat:@"%@%@",BIG_DATA_HEAD,bigArray[1]];
            
            
//            NSLog(@"我发现了一个头 ：\n \n %@ \n \n",getStrBig);
        }
        
        
    }
    else
    {
        if (findHeadSamll) {
            
            [output appendData:data];
            
            getStrSamll = [NSString stringWithFormat:@"%@%@",getStrSamll,samllArray[0]];
            
        }
        else if (findHeadBIG)
        {
            [output appendData:data];
            
            getStrBig = [NSString stringWithFormat:@"%@%@",getStrBig,bigArray[0]];
            
 //           NSLog(@"我拼接 ：\n \n %@ \n \n",getStrBig);
        }
    }
    
}
- (NSMutableData *)huahsakdsa:(NSString *)str
{
    
    str = [str stringByReplacingOccurrencesOfString:@"<" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@">" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
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
//send data
- (IBAction)sendMsgToBTMode:(id)sender {
    
    NSMutableData *data = [self huahsakdsa:_MsgToBTMode.text];
    [sensor write:sensor.activePeripheral data:data];

    [self performSelector:@selector(stopMINGling) withObject:nil afterDelay:60];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);
    NSTimeInterval anm = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:anm];
    if(offset > 0)
    {
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (NSString *)ToHex:(NSInteger )tmpid
{
    
    NSInteger leng = [NSString stringWithFormat:@"%d",tmpid].length;
    NSString *hexString = @"";
    
    switch (leng) {
        case 1:
            hexString = [[NSString alloc] initWithFormat:@"%02X",tmpid];
            break;
        case 2:
            hexString = [[NSString alloc] initWithFormat:@"%02X",tmpid];
            break;
        case 3:
            hexString = [[NSString alloc] initWithFormat:@"%03X",tmpid];
            break;
        case 4:
            hexString = [[NSString alloc] initWithFormat:@"%04X",tmpid];
            break;
        case 5:
            hexString = [[NSString alloc] initWithFormat:@"%05X",tmpid];
            break;
        case 6:
            hexString = [[NSString alloc] initWithFormat:@"%06X",tmpid];
            break;
        case 7:
            hexString = [[NSString alloc] initWithFormat:@"%07X",tmpid];
            break;
        case 8:
            hexString = [[NSString alloc] initWithFormat:@"%08X",tmpid];
            break;
            
        default:
            break;
    }
    
    return hexString;
}
- (float )getDistance:(NSNumber *)rssi
{
    float power = (abs([rssi intValue] - 59)/(10*2.0));
    return powf(10.0f, power);
}

- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error
{
    
}
-(void)setConnect
{
    CFStringRef s = CFUUIDCreateString(kCFAllocatorDefault, (__bridge CFUUIDRef )sensor.activePeripheral.identifier);
    
    float rssi =  [self getDistance:sensor.activePeripheral.RSSI];
    _lbDevice.text = [NSString stringWithFormat:@"设备已连接  设备号：%@",(__bridge NSString*)s];
    
    
    //，上面表示2015年1月1日1点1分1秒  07D0F07F010101
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[[NSDate alloc] init]];
    
    NSString *timestr = [NSString stringWithFormat:@"%@%@%@%@%@%@",[self ToHex:components.year],[self ToHex:components.month],[self ToHex:components.day],[self ToHex:components.hour],[self ToHex:components.minute],[self ToHex:components.second]];
    
    NSString *str = [NSString stringWithFormat:@"1001AA08A1%@0D0A",timestr];//@"07DF070A160001";
    NSMutableData *data = [self huahsakdsa:str];
    [sensor write:sensor.activePeripheral data:data];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableData *banben = [self huahsakdsa:@"1001AA01A90D0A"];
        [sensor write:sensor.activePeripheral data:banben];
    });
    
    lianjieOK = YES;
}

-(void)setDisconnect
{
    lianjieOK = NO;
    _lbDevice.text = [NSString stringWithFormat:@"设备连接失败  设备号：无"];
}
#pragma mark -
#pragma mark Internal helper methods
- (NSString *)getTimeNow
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd-hh-mm-ss"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@", date];
//    NSLog(@"%@", timeNow);
    return timeNow;
}
- (void)initLog {
    
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    fileName = [NSString stringWithFormat:@"%@/log%@.txt", documentsDirectory,[self getTimeNow]];
    
    //check if the file exists if not create it
    if(![[NSFileManager defaultManager] fileExistsAtPath:fileName])
        [[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
    
    logFile = [NSFileHandle fileHandleForWritingAtPath:fileName];
    [logFile seekToEndOfFile];
    
    NSString *avName = [NSString stringWithFormat:@"%@/log%@.caf", documentsDirectory,[self getTimeNow]];
    if(![[NSFileManager defaultManager] fileExistsAtPath:avName])
        [[NSFileManager defaultManager] createFileAtPath:avName contents:nil attributes:nil];
    [self initav:avName];
}

- (void)initav:(NSString *)path
{
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）, 采样率必须要设为11025才能使转化成mp3格式后不会失真
    [recordSetting setValue:[NSNumber numberWithFloat:11025.0] forKey:AVSampleRateKey];
    //录音通道数  1 或 2 ，要转换成mp3格式必须为双通道
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    //存储录音文件
    recordUrl = [NSURL URLWithString:path];
    
    //初始化
    audioRecorder = [[AVAudioRecorder alloc] initWithURL:recordUrl settings:recordSetting error:nil];
    //开启音量检测
    audioRecorder.meteringEnabled = YES;
    audioRecorder.delegate = self;
}

- (void)writeLog {
    
    [self clickOnButton:2];
    if (logFile) {
        [logFile writeData:output];
    }
    
    
    [self.view.window showHUDWithText:@"完毕" Type:ShowDismiss Enabled:YES];
}
- (void)showMyData:(NSDictionary *)ddd :(NSInteger )index :(NSArray *)fenpiArray :(BOOL)isBig
{
    if (isBig) {
      [self showData:ddd];
    }
    else
    {
        [self showSamllData:ddd];
    }
    
    index++;
    
    if (index >= fenpiArray.count ) {
        return;
    }
    else
    {
        __weak ViewController *weakSelf = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (isBig) {
                [weakSelf fenjieshuju:index :fenpiArray :nil];
            }
            else
            {
                [weakSelf Samllfenjieshuju:index :fenpiArray :nil];
            }
            
            
        });
        
    }
    
}

NSComparator cmptr = ^(id obj1, id obj2){
    if([[NSString stringWithFormat:@"%@",obj1] compare:[NSString stringWithFormat:@"%@",obj2] options:NSNumericSearch] > 0)
    {
        return (NSComparisonResult)NSOrderedDescending;
    }
    
    if([[NSString stringWithFormat:@"%@",obj1] compare:[NSString stringWithFormat:@"%@",obj2] options:NSNumericSearch] < 0)
    {
        return (NSComparisonResult)NSOrderedAscending;
    }
    
    return (NSComparisonResult)NSOrderedSame;
};

- (void)fenjieshuju:(NSInteger )index :(NSArray *)fenpiArray :(NSMutableDictionary *)alldic
{
    ParserObject *parObject = [ParserObject shareManager];
    
    NSString *str = fenpiArray[index];
    
    if (str.length < 96) {
        return;
    }
    str = [str substringToIndex:96];
    
    NSDictionary *Dic = [parObject   getBigDataStr:str];
    if (Dic.allKeys.count == 0) {
        return;
    }
    [self showMyData:Dic :index :fenpiArray :YES];
    
    
}

- (void)Samllfenjieshuju:(NSInteger )index :(NSArray *)fenpiArray :(NSMutableDictionary *)alldic
{
    ParserObject *parObject = [ParserObject shareManager];
    
    NSString *str = fenpiArray[index];
    
    NSDictionary *Dic = [parObject   getSamllObjectForKeystr:str];
    if (Dic.allKeys.count == 0) {
        return;
    }
    [self showMyData:Dic :index :fenpiArray :NO];
    
    
}
- (void)SamllShow:(NSString *)str
{

}
- (void)BigSHow:(NSString *)str
{
    
}
- (void)shishiLoadingData:(NSInteger )num :(NSArray *)array
{
    //    [self fenjieshuju:0 :fenpiArray :getDic];

    NSString *samllStr = array[num];
    NSString *bigStr = array[num+1];
    
    NSRange range = [samllStr rangeOfString:@"aaaa048002"];
    NSRange rangebig = [bigStr rangeOfString:@"aaaa2002"];
    
    if (range.length > 0 && rangebig.length > 0) {//有效数据
        
        [self Samllfenjieshuju:0 :@[samllStr] :getSamll];
        
        [self fenjieshuju:0 :@[bigStr] :getDic];
    }
    else
    {
        
    }
    
    num += 2;
    
    if (num +1 >= array.count) {
        return;
    }
    else
    {
        __weak ViewController    *weakSelf = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (!oldReadingStop) {
                [weakSelf shishiLoadingData:num :array];
            }
            else
            {
                oldReadingStop = NO;
            }
        });
    }
    
}

- (void)readingData:(NSString *)path
{
    
    _stopOldData.enabled = YES;
    
    _huiguData.text = @"历史数据回顾中...";
    kaishiReading = YES;
    
    numiii = 0;
    tongji = 1;
    countNum = 1;
    
    [self initAllAllData];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSLog(@"NSData类方法读取的内容是：%@",data);
    NSString *conent = [NSString stringWithFormat:@"%@",data];
    
    conent = [conent stringByReplacingOccurrencesOfString:@"<" withString:@""];
    conent = [conent stringByReplacingOccurrencesOfString:@">" withString:@""];
    conent = [conent stringByReplacingOccurrencesOfString:@" " withString:@""];
    
//    ParserObject *parObject = [ParserObject shareManager];
    
    [self clickOnButton:1];
    
    NSArray *fenpiArray = [conent componentsSeparatedByString:KEY_FENGE_];
    if (fenpiArray.count > 2) {
        [self shishiLoadingData:0 :fenpiArray];
    }
   


//    [parObject getDataDic:conent];
    
    data = nil;
//    parObject = nil;
    NSLog(@"over");
    
    kaishiReading = NO;
    
//    
//    [self   performSelector:@selector(showData) withObject:nil afterDelay:0.01];
    
//    [self initLog];
}

 - (UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
- (UIImage *) captureScreen:(UIView *)vvvv {
    CGRect rect = CGRectMake(vvvv.frame.origin.x, vvvv.frame.origin.y, 66, vvvv.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [vvvv.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


- (void)showSamllData:(NSDictionary *)dicBQL
{
    if (tongji == 21) {
        tongji = 1;
        [_kViewThree.dataForPlot removeAllObjects];
        _kViewThree.xValue = 0;
    }
    for (NSString *key in [dicBQL allKeys]) {
        for (NSNumber *value in [dicBQL objectForKey:key]) {
            
            NSNumber *tempDataa = @([value integerValue]);
            
            [_kViewThree setData:tempDataa];
        }
    }
    //[_graph reloadData];
    [_kViewThree reloadMyView];
    _kViewThree.xValue++;
    tongji++;
    
    
    [_bgView setHidden:YES];
}

- (void)showData:(NSDictionary *)dic
{
    
    NSArray *keys = [dic allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    
    
    if (countNum == 21) {
        countNum = 1;
        [_kViewOne remoAllDATA];
        [_kViewTwo remoAllDATA];

    }
    
    
   
    
    if (countNum == 1) {
        
        [_kViewOne setDataForPlot1MM:@"0"];
        [_kViewOne setDataForPlot2MM:@"0"];
        [_kViewOne setDataForPlot3MM:@"0"];
        [_kViewOne setDataForPlot4MM:@"0"];
        [_kViewOne setDataForPlot5MM:@"0"];
        [_kViewOne setDataForPlot6MM:@"0"];
        [_kViewOne setDataForPlot7MM:@"0"];
        [_kViewOne setDataForPlot8MM:@"0"];
        
        [_kViewTwo setDataForPlot1MM:@"0"];
        [_kViewTwo setDataForPlot2MM:@"0"];
        [_kViewTwo setDataForPlot3MM:@"0"];
    }
    
    
    
    NSInteger cout = 1;
    
    for (NSString *str in sortedArray) {
        
        
        NSDictionary *dic1 = [dic objectForKey:str];
        for (NSString *str1 in [dic1 allKeys]) {
            
            if ([str1 isEqualToString:@"Delta"]) {
                id getObject = [dic1 objectForKey:str1];
                if ([getObject isKindOfClass:[NSNumber class]]) {
                    
                    [_kViewOne setDataForPlot1MM:getObject];
                    
                    if ([getObject floatValue] > 1000) {
                       [PlaySong playSound:@"delta" :@"mp3"];
                    }
                    _deltafile.text = [NSString stringWithFormat:@"%@",getObject];
                    
                }
            }
            else if ([str1 isEqualToString:@"LowAlpha"]) {
                id getObject = [dic1 objectForKey:str1];
                if ([getObject isKindOfClass:[NSNumber class]]) {
                    
                    [_kViewOne setDataForPlot3MM:getObject];
                    
                    if ([getObject floatValue] > 1000) {
                        [PlaySong playSound:@"lowalpha" :@"mp3"];
                    }
                    
                    
                    _lowAlpha.text = [NSString stringWithFormat:@"%@",getObject];
                }
            }
            else if ([str1 isEqualToString:@"LowBeta"]) {
                id getObject = [dic1 objectForKey:str1];
                if ([getObject isKindOfClass:[NSNumber class]]) {
                    
                    [_kViewOne setDataForPlot5MM:getObject];
                    
                    if ([getObject floatValue] > 1000) {
                    
                        [PlaySong playSound:@"lowbeta" :@"mp3"];
                    }
                    
                    
                    _lowbeta.text = [NSString stringWithFormat:@"%@",getObject];
                }
            }
            else if ([str1 isEqualToString:@"LowGamma"]) {
                id getObject = [dic1 objectForKey:str1];
                if ([getObject isKindOfClass:[NSNumber class]]) {
               
                    
                    [_kViewOne setDataForPlot7MM:getObject];
                    
                    if ([getObject floatValue] > 1000) {
                    
                        [PlaySong playSound:@"lowgamma" :@"mp3"];
                    }
                    
                    _lowgamma.text = [NSString stringWithFormat:@"%@",getObject];
                }
            }
            else if ([str1 isEqualToString:@"MiddleGamma"]) {
                id getObject = [dic1 objectForKey:str1];
                if ([getObject isKindOfClass:[NSNumber class]]) {
                 
                    [_kViewOne setDataForPlot8MM:getObject];
                    
                    if ([getObject floatValue] > 1000) {
                        [PlaySong playSound:@"middlegamma" :@"mp3"];
                        
                    }
                    
                    
                    _middlegamma.text = [NSString stringWithFormat:@"%@",getObject];
                }
            }
            else if ([str1 isEqualToString:@"Theta"]) {
                id getObject = [dic1 objectForKey:str1];
                if ([getObject isKindOfClass:[NSNumber class]]) {
                    [_kViewOne setDataForPlot2MM:getObject];
                    if ([getObject floatValue] > 1000) {
                        [PlaySong playSound:@"theta" :@"mp3"];
                        
                    }
                    
                    _theta.text = [NSString stringWithFormat:@"%@",getObject];
                }
            }
            else if ([str1 isEqualToString:@"highAlpha"]) {
                id getObject;
                getObject = [dic1 objectForKey:str1];
                if ([getObject isKindOfClass:[NSNumber class]]) {
                    
                    
                    [_kViewOne setDataForPlot4MM:getObject];
                    
                    if ([getObject floatValue] > 1000) {
                    
                        [PlaySong playSound:@"highalpha" :@"mp3"];
                    }
                    
                    _highalpha.text = [NSString stringWithFormat:@"%@",getObject];
                    
                }
            }
            else if ([str1 isEqualToString:@"highBeta"]) {
                id getObject = [dic1 objectForKey:str1];
                if ([getObject isKindOfClass:[NSNumber class]]) {
                    
                    [_kViewOne setDataForPlot6MM:getObject];
                    
                    if ([getObject floatValue] > 1000) {
                    
                       [PlaySong playSound:@"highbeta" :@"mp3"];
                    }
                    
                    _highbeta.text = [NSString stringWithFormat:@"%@",getObject];
                }
            }
            
        }
        
        cout++;
        
        
    }
    
    [_kViewOne reloadMyView];
    
    [_bgView setHidden:YES];
    
    
    [self showkline:dic];
    
    countNum ++;

   
    
    
    
    
}
- (void)showkline:(NSDictionary *)dic
{
    
    NSInteger cout = 1;
    for (NSString *str in [dic allKeys]) {
        
        NSDictionary *dic1 = [dic objectForKey:str];
        for (NSString *str1 in [dic1 allKeys]) {
            
            if ([str1 isEqualToString:@"Attention"]) {
                id getObject = [dic1 objectForKey:str1];
                if ([getObject isKindOfClass:[NSNumber class]]) {
                    
                    [_kViewTwo setDataForPlot1MM:getObject];
                    
                    if ([getObject floatValue] > 1000) {
                    
                        [PlaySong playSound:@"attention" :@"mp3"];
                    }
                }
            }
            else if ([str1 isEqualToString:@"Meditation"]) {
                id getObject = [dic1 objectForKey:str1];
                if ([getObject isKindOfClass:[NSNumber class]]) {
                    
                    [_kViewTwo setDataForPlot2MM:getObject];
                    
                    if ([getObject floatValue] > 1000) {
                    
                        [PlaySong playSound:@"meditation" :@"mp3"];
                    }
                }
            }
            else if ([str1 isEqualToString:@"singel"]) {
                id getObject = [dic1 objectForKey:str1];
                if ([getObject isKindOfClass:[NSNumber class]]) {
                    
                    //获取singal值
                    
                    NSInteger signal = [getObject intValue];
                    
                    if (signal == 200) {
                        [self.tipsLable setHidden:NO];
                    }
                    else
                    {
                        [self.tipsLable setHidden:YES];
                    }

                    
                    [_kViewTwo setDataForPlot3MM:getObject];

                }
            }
        }
        
        cout++;
    }
    
    
    
    [_kViewTwo reloadMyView];
    
    [_bgView setHidden:YES];
}
- (float )getArraypJZ:(NSArray *)ARR
{
    float JJJ = 0;
    
    for (NSNumber *nuer in ARR) {
        JJJ += [nuer floatValue];
    }
    JJJ = JJJ/ARR.count;
    return JJJ;
}
- (NSMutableArray *)chaifen247:(NSMutableArray *)dic
{
    return dic;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i< [dic count]; i++) {
        
        NSNumber *nuber = dic[i];
        
        if (i+1 == dic.count) {
            [array addObject:nuber];
            break;
        }
        
        for (int i=0; i<248; i++) {
            [array addObject:nuber];
        }
    }
    return array;
}
- (NSMutableArray *)chaifenYYY247:(NSMutableArray *)dic
{
    return dic;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i< [dic count]; i++) {
        NSString *str = dic[i];
        [array addObject:str];
        if (i+1 == dic.count) {
            break;
        }
        
        for (int i=0; i<247; i++) {
            [array addObject:@"'"];
        }
    }
    
    return array;
}
#pragma mark -
#pragma mark action event

- (IBAction)lookOldData:(id)sender {
    
    
    _oldvc= [[OldlistViewController alloc] initWithNibName:@"OldlistViewController" bundle:nil];
    _oldvc.view.frame = CGRectMake(0, 0, 300, 400);
    
    _popoldList = [[UIPopoverController alloc] initWithContentViewController:_oldvc];
    
    _popoldList.popoverContentSize = CGSizeMake(300,400);
    CGRect rect = CGRectMake(self.view.frame.size.width - 100,self.view.frame.size.height - 50,10,10);
    
    //弹出关于界面
    [_popoldList presentPopoverFromRect:rect         //中心点是用来画箭头的，如果中心点如果出了屏幕，系统会优化到窗口边缘
                                    inView:self.view
                  permittedArrowDirections:UIPopoverArrowDirectionDown   //箭头方向
                               animated:YES];
    
    __weak ViewController  *weakSelf = self;
    _oldvc.selPath = ^(NSString *perI)
    {
        [weakSelf.popoldList dismissPopoverAnimated:YES];
   
        NSArray *getFilename = [perI componentsSeparatedByString:@"."];
        
        NSString *str = [NSString stringWithFormat:@"%@.caf",getFilename[0]];
        
        [weakSelf initav:str];
        
        [weakSelf performSelector:@selector(readingData:) withObject:perI afterDelay:0.0];
    };
    
}

#pragma mark -
#pragma mark allevent
- (IBAction)luying:(UIButton *)sender {
    
    if (kaishiReading) {
        return;
    }
    
    [sender setSelected:!sender.isSelected];
    
    NSNumber *nub = [NSNumber numberWithBool:sender.isSelected];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"luyin"];
    
}
- (IBAction)delta:(UIButton *)sender {
    
    
    if (kaishiReading) {
        return;
    }
    [sender setSelected:!sender.isSelected];
    
    NSNumber *nub = [NSNumber numberWithBool:sender.isSelected];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"delta"];
    
}
- (IBAction)theta:(UIButton *)sender {
    
    if (kaishiReading) {
        return;
    }
    [sender setSelected:!sender.isSelected];
    
    NSNumber *nub = [NSNumber numberWithBool:sender.isSelected];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"theta"];
    
}
- (IBAction)lowalpha:(UIButton *)sender {
    
    if (kaishiReading) {
        return;
    }
    [sender setSelected:!sender.isSelected];
    
    NSNumber *nub = [NSNumber numberWithBool:sender.isSelected];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"lowalpha"];
    
}
- (IBAction)highalpha:(UIButton *)sender {
    
    if (kaishiReading) {
        return;
    }
    [sender setSelected:!sender.isSelected];
    
    NSNumber *nub = [NSNumber numberWithBool:sender.isSelected];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"highalpha"];
    
}
- (IBAction)lowbeta:(UIButton *)sender {
    if (kaishiReading) {
        return;
    }
    [sender setSelected:!sender.isSelected];
    
    NSNumber *nub = [NSNumber numberWithBool:sender.isSelected];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"lowbeta"];
    
}
- (IBAction)hightbeta:(UIButton *)sender {
    if (kaishiReading) {
        return;
    }
    [sender setSelected:!sender.isSelected];
    
    NSNumber *nub = [NSNumber numberWithBool:sender.isSelected];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"highbeta"];
    
}
- (IBAction)lowgamma:(UIButton *)sender {
    if (kaishiReading) {
        return;
    }
    [sender setSelected:!sender.isSelected];
    
    NSNumber *nub = [NSNumber numberWithBool:sender.isSelected];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"lowgamma"];
    
}
- (IBAction)highgamma:(UIButton *)sender {
    if (kaishiReading) {
        return;
    }
    [sender setSelected:!sender.isSelected];
    
    NSNumber *nub = [NSNumber numberWithBool:sender.isSelected];
    [[NSUserDefaults standardUserDefaults] setObject:nub forKey:@"highgamma"];
    
}

- (void)initAllAllData
{
    [_kViewOne remoAllDATA];
    [_kViewTwo remoAllDATA];
    [_kViewThree.dataForPlot removeAllObjects];
    _kViewThree.xValue = 0;
    
     [audioPlayer stop];
}

- (IBAction)kaishiljianc:(id)sender {
    
    
    

    if (!lianjieOK) {
        
       [self.view.window showHUDWithText:@"未连接设备" Type:ShowPhotoNo Enabled:YES];
        
        return;
    }
    
    
     _huiguData.text = @"";
    [self initAllAllData];
    //kaishiReading
    
    kaishiReading = YES;
    [self initLog];
    
    numiii = 0;
    tongji = 1;
    countNum = 1;
    
//    [self.view.window showHUDWithText:@"数据装载中..." Type:ShowLoading Enabled:YES];
    [_kaishiJcButton setBackgroundColor:[UIColor lightGrayColor]];
    
    _kaishiJcButton.enabled = NO;
    NSMutableData *data = [self huahsakdsa:@"1001AA03A502010D0A"];
    [sensor write:sensor.activePeripheral data:data];
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"luyin"] boolValue]) {
        
        [self clickOnButton:3];
    
    
    }
    
    
   
    
}
- (IBAction)stopjiance:(id)sender {
    
     _huiguData.text = @"";
    
    kaishiReading = NO;
    
    numiii = 0;
    tongji = 1;
    countNum = 1;
    
    [self.view.window showHUDWithText:@"数据存储中..." Type:ShowLoading Enabled:YES];
    
    _kaishiJcButton.enabled = YES;
    [_kaishiJcButton setBackgroundColor:[UIColor orangeColor]];
    
    NSMutableData *data = [self huahsakdsa:@"1001AA03A402000D0A"];
    [sensor write:sensor.activePeripheral data:data];
    
    [self performSelector:@selector(writeLog) withObject:nil afterDelay:0.01];
}

- (IBAction)stopOldPlay:(id)sender {
    
    _huiguData.text = @"";
    [self initAllAllData];
    oldReadingStop = YES;
    
    _stopOldData.enabled = NO;
    
    [self initallView:NO];
    [self initSallView:NO];
}



- (void)clickOnButton:(NSInteger )sender {
    audioSession = [AVAudioSession sharedInstance];//得到AVAudioSession单例对象
    switch (sender) {
        case 1:{
            [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
            [audioSession setActive:YES error:nil];
            
            if (_mp3FilePath != nil) {
                audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_mp3FilePath error:nil];
            }
            else if (recordUrl != nil){
                audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:recordUrl error:nil];
            }
            
            [audioPlayer prepareToPlay];
            audioPlayer.volume = 1;
            [audioPlayer play];
        }
            break;
        case 4:
        {
            if ([audioRecorder isRecording]) {
                [audioRecorder pause];
            }
            else
            {
                [audioRecorder record];
            }
            
        }
            break;
        case 2:{
            [audioRecorder stop];
        }
            break;
        case 3:
        {
            if (![audioRecorder isRecording]) {
                [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];//设置类别,表示该应用同时支持播放和录音
                [audioSession setActive:YES error:nil];//启动音频会话管理,此时会阻断后台音乐的播放.
                
                [audioRecorder prepareToRecord];
                [audioRecorder peakPowerForChannel:0.0];
                [audioRecorder record];
            }
            else{
                [audioRecorder stop];                          //录音停止
                [audioSession setActive:NO error:nil];         //一定要在录音停止以后再关闭音频会话管理（否则会报错），此时会延续后台音乐播放
            }

        }
        default:
            break;
    }
}
- (void)transformCAFToMP3:(NSString *)filename {
    
    if (filename) {
         _mp3FilePath = [NSURL URLWithString:[NSHomeDirectory() stringByAppendingString:[NSString     stringWithFormat:@"/Documents/%@.mp3",filename]]];
    }
   else
   {
        _mp3FilePath = [NSURL URLWithString:[NSHomeDirectory() stringByAppendingString:[NSString     stringWithFormat:@"/Documents/log%@.mp3",[NSDate date]]]];
   }
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([[recordUrl absoluteString] cStringUsingEncoding:1], "rb");   //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                                   //skip file header
        FILE *mp3 = fopen([[_mp3FilePath absoluteString] cStringUsingEncoding:1], "wb"); //output 输出生成的Mp3文件位置
        if (!mp3) {
            return;
        }
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
//        NSLog(@"%@",[exception description]);
    }
    @finally {
        audioFileSavePath = _mp3FilePath;
//        NSLog(@"MP3生成成功: %@",audioFileSavePath);
    }
}
//AVAudioRecorderDelegate方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [audioSession setActive:NO error:nil];
}


- (IBAction)clearData:(id)sender {
    
    NSMutableData *banben = [self huahsakdsa:@"1001AA02AB020D0A"];
    [sensor write:sensor.activePeripheral data:banben];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.view.window showHUDWithText:@"清除成功" Type:ShowPhotoYes Enabled:YES];
        
    });
    
    
}


@end
