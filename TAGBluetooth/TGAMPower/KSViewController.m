//
//  KSViewController.m
//  CorePlotDemo
//
//  Created by kesalin on 2/4/13.
//  Copyright (c) 2013 kesalin@gmail.com. All rights reserved.
//

#import "KSViewController.h"

//#define PERFORMANCE_TEST
#define GREEN_PLOT_IDENTIFIER       @"Green Plot"
#define BLUE_PLOT_IDENTIFIER        @"Blue Plot"

/*
 * Notes:
 * 1, You should change the type of view in KSViewController.xib to CPTGraphHostingView;
 * 2, You should add '-all_load -ObjC' to other linker flags in build settings.
 */

@interface KSViewController ()
{
    CPTXYGraph * _graph;
    
}

- (void)setupCoreplotViews;

-(CPTPlotRange *)CPTPlotRangeFromFloat:(float)location length:(float)length;

@end

@implementation KSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self setupCoreplotViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Rotation

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark -
#pragma mark Setup coreplot views

- (void)setupCoreplotViews
{
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    
    // Create graph from theme: 设置主题
    //
    _graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    CPTTheme * theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    [_graph applyTheme:theme];
    
    CPTGraphHostingView * hostingView = (CPTGraphHostingView *)self.view;
    hostingView.collapsesLayers = YES; // Setting to YES reduces GPU memory usage, but can slow drawing/scrolling
    hostingView.hostedGraph = _graph;
    
    _graph.plotAreaFrame.paddingLeft = -700 ;
    _graph.plotAreaFrame.paddingTop = 10 ;
    _graph.plotAreaFrame.paddingRight = 5 ;
    _graph.plotAreaFrame.paddingBottom = 10 ;
    
    _graph.paddingLeft = _graph.paddingRight = 10.0;
    _graph.paddingTop = _graph.paddingBottom = 10.0;
    
    // Setup plot space: 设置一屏内可显示的x,y量度范围
    //
    CPTXYPlotSpace * plotSpace = (CPTXYPlotSpace *)_graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = NO;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-20) length:CPTDecimalFromFloat(40)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-1500) length:CPTDecimalFromFloat(3000)];
    
    // Axes: 设置x,y轴属性，如原点，量度间隔，标签，刻度，颜色等
    //
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)_graph.axisSet;
    
    lineStyle.miterLimit = 1.0f;
    lineStyle.lineWidth = 2.0;
    lineStyle.lineColor = [CPTColor whiteColor];
    
    CPTXYAxis * x = axisSet.xAxis;
    x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0"); // 原点的 x 位置
    x.majorIntervalLength = CPTDecimalFromString(@"1");   // x轴主刻度：显示数字标签的量度间隔
    x.minorTicksPerInterval = 1;    // x轴细分刻度：每一个主刻度范围内显示细分刻度的个数
    x.minorTickLineStyle = lineStyle;
    
    
    CPTXYAxis * y = axisSet.yAxis;
    y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0"); // 原点的 y 位置
    y.majorIntervalLength = CPTDecimalFromString(@"750");   // y轴主刻度：显示数字标签的量度间隔
    y.minorTicksPerInterval = 1;    // y轴细分刻度：每一个主刻度范围内显示细分刻度的个数
    y.minorTickLineStyle = lineStyle;
    y.delegate = self;
    
    // Create a green plot area: 画破折线
    //
    lineStyle                = [CPTMutableLineStyle lineStyle];
    lineStyle.lineWidth      = 1.f;
    lineStyle.lineColor      = [CPTColor colorWithComponentRed:170.0/255 green:103.0/255 blue:49.0/255 alpha:1.0];
    
    CPTScatterPlot * dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    dataSourceLinePlot.identifier = GREEN_PLOT_IDENTIFIER;
    dataSourceLinePlot.dataSource = self;
    
    
    // Animate in the new plot: 淡入动画
    dataSourceLinePlot.opacity = 0.0f;
    
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnimation.duration            = 0.0f;
    fadeInAnimation.removedOnCompletion = NO;
    fadeInAnimation.fillMode            = kCAFillModeForwards;
    fadeInAnimation.toValue             = [NSNumber numberWithFloat:1.0];
    [dataSourceLinePlot addAnimation:fadeInAnimation forKey:@"animateOpacity"];
    
    [_graph addPlot:dataSourceLinePlot];
    
    // Add some initial data
    //
    _dataForPlot = [NSMutableArray arrayWithCapacity:100];
   

    
}

double gogo = 0.000000;

- (void)setXValue:(int)xValue
{
    _xValue = xValue;
    gogo = 0;
}

- (void)setData:(id )object
{
    
    id x = [NSNumber numberWithFloat:_xValue + gogo];
    id y = [NSNumber numberWithFloat:[object floatValue]];
    [_dataForPlot addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
    gogo += 0.00404858;
}
-(void)changePlotRange
{
    // Change plot space
    CPTXYPlotSpace * plotSpace = (CPTXYPlotSpace *)_graph.defaultPlotSpace;
    
    plotSpace.xRange = [self CPTPlotRangeFromFloat:0.0 length:( rand() / RAND_MAX)];
    plotSpace.yRange = [self CPTPlotRangeFromFloat:0.0 length:( rand() / RAND_MAX)];
}

-(CPTPlotRange *)CPTPlotRangeFromFloat:(float)location length:(float)length
{
    return [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(location) length:CPTDecimalFromFloat(length)];
}
- (void)reloadMyView
{
    [_graph reloadData];
}
#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [_dataForPlot count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSString * key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
    NSNumber * num = [[_dataForPlot objectAtIndex:index] valueForKey:key];
    
    // Green plot gets shifted above the blue
    if ([(NSString *)plot.identifier isEqualToString:GREEN_PLOT_IDENTIFIER]) {
        if (fieldEnum == CPTScatterPlotFieldY) {
            num = [NSNumber numberWithDouble:[num doubleValue]];
        }
    }
    
    return num;
}

#pragma mark -
#pragma mark Axis Delegate Methods

-(BOOL)axis:(CPTAxis *)axis shouldUpdateAxisLabelsAtLocations:(NSSet *)locations
{
    return YES;
}



@end
