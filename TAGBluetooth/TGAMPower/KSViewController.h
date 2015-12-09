//
//  KSViewController.h
//  CorePlotDemo
//
//  Created by kesalin on 2/4/13.
//  Copyright (c) 2013 kesalin@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface KSViewController : UIViewController<CPTPlotDataSource, CPTAxisDelegate>
- (void)setData:(id )object;
@property (nonatomic, strong)NSMutableArray * dataForPlot;
@property (nonatomic, assign)int xValue;

- (void)reloadMyView;

@end
