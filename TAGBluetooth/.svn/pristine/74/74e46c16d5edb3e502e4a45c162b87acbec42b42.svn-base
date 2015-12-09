//
//  ShowLIneViewController.h
//  TGAMPower
//
//  Created by bai on 15/8/6.
//  Copyright (c) 2015年 bai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

static id<NSCopying, NSCoding, NSObject> TAG_Attention = @"Attention";
static id<NSCopying, NSCoding, NSObject> TAG_Meditation = @"Meditation";

@interface ShowLIneViewController : UIViewController<CPTPlotDataSource>

{
    CPTXYGraph                  *graph;             //画板
    int                         j1;
    int                         j2;
    int                         j3;
    int                         j4;
    int                         j5;
    int                         j6;
    int                         j7;
    int                         j8;
    

}

@property (strong, nonatomic) NSMutableArray *dataForPlot1;
@property (strong, nonatomic) NSMutableArray *dataForPlot2;
@property (strong, nonatomic) NSMutableArray *dataForPlot3;
@property (strong, nonatomic) NSMutableArray *dataForPlot4;
@property (strong, nonatomic) NSMutableArray *dataForPlot5;
@property (strong, nonatomic) NSMutableArray *dataForPlot6;
@property (strong, nonatomic) NSMutableArray *dataForPlot7;
@property (strong, nonatomic) NSMutableArray *dataForPlot8;


+ (instancetype )showCreatLineView;

- (void)createInitall:(CGRect )frame :(float )YMax :(float)XMax :(NSString *)kedu;

- (void)creatPlotInit:(CPTColor *)color :(NSString *)identifier touming:(CPTColor *)tmColor;

- (void)reloadMyView;

- (void)remoAllDATA;

- (void)setDataForPlot1MM:(id )dataForPlot1;
- (void)setDataForPlot2MM:(id )dataForPlot2;
- (void)setDataForPlot3MM:(id )dataForPlot3;
- (void)setDataForPlot4MM:(id )dataForPlot4;
- (void)setDataForPlot5MM:(id )dataForPlot5;
- (void)setDataForPlot6MM:(id )dataForPlot6;
- (void)setDataForPlot7MM:(id )dataForPlot7;
- (void)setDataForPlot8MM:(id )dataForPlot8;
@end
