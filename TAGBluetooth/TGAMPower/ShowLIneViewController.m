//
//  ShowLIneViewController.m
//  TGAMPower
//
//  Created by bai on 15/8/6.
//  Copyright (c) 2015年 bai. All rights reserved.
//

#import "ShowLIneViewController.h"

static ShowLIneViewController *staticSelf = nil;

@interface ShowLIneViewController ()

@end

@implementation ShowLIneViewController

+ (instancetype )showCreatLineView
{
    staticSelf = [[ShowLIneViewController alloc] init];
    
    return staticSelf;
}
- (void)createInitall:(CGRect )frame :(float )YMax :(float)XMax :(NSString *)kedu 
{
    
    j1 = 0;
    j2 = 0;
    j3 = 0;
    j4 = 0;
    j5 = 0;
    j6 = 0;
    j7 = 0;
    j8 = 0;
    
    
        _dataForPlot1 = [[NSMutableArray alloc] init];
        _dataForPlot2 = [[NSMutableArray alloc] init];
        _dataForPlot3 = [[NSMutableArray alloc] init];
        _dataForPlot4 = [[NSMutableArray alloc] init];
        _dataForPlot5 = [[NSMutableArray alloc] init];
        _dataForPlot6 = [[NSMutableArray alloc] init];
        _dataForPlot7 = [[NSMutableArray alloc] init];
        _dataForPlot8 = [[NSMutableArray alloc] init];
    
    
    graph = [[CPTXYGraph alloc] initWithFrame:frame];
    
    //给画板添加一个主题
    CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    [graph applyTheme:theme];
    
    //创建主画板视图添加画板
    CPTGraphHostingView *hostingView = [[CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
    hostingView.hostedGraph = graph;
    [self.view addSubview:hostingView];
    
    //设置留白
    graph.paddingLeft = 0;
    graph.paddingTop = 0;
    graph.paddingRight = 0;
    graph.paddingBottom = 0;
    
    graph.plotAreaFrame.paddingLeft = 70 ;
    graph.plotAreaFrame.paddingTop = 10 ;
    graph.plotAreaFrame.paddingRight = 5 ;
    graph.plotAreaFrame.paddingBottom = 20 ;
    //设置坐标范围
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = NO;
    
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(XMax)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(YMax)];
    
    //设置坐标刻度大小
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) graph.axisSet ;
    CPTXYAxis *x = axisSet.xAxis ;
    x. minorTickLineStyle = nil ;
    // 大刻度线间距： 50 单位
    x. majorIntervalLength = CPTDecimalFromString (@"1");
    // 坐标原点： 0
    x. orthogonalCoordinateDecimal = CPTDecimalFromString ( @"0" );
    
    CPTXYAxis *y = axisSet.yAxis ;
    //y 轴：不显示小刻度线
    y. minorTickLineStyle = nil ;
    
    // 大刻度线间距： 50 单位
    y. majorIntervalLength = CPTDecimalFromString (kedu);
    // 坐标原点： 0
    y. orthogonalCoordinateDecimal = CPTDecimalFromString (@"0");
    
}
- (void)creatPlotInit:(CPTColor *)color :(NSString *)identifier touming:(CPTColor *)tmColor
{
    //创建绿色区域
    CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    dataSourceLinePlot.identifier = identifier;
    
    //设置绿色区域边框的样式
    CPTMutableLineStyle *lineStyle = [dataSourceLinePlot.dataLineStyle mutableCopy];
    lineStyle.lineWidth = 3.f;
    lineStyle.lineColor = color;
    dataSourceLinePlot.dataLineStyle = lineStyle;
    //设置透明实现添加动画
    dataSourceLinePlot.opacity = 0.0f;
    
    //设置数据元代理
    dataSourceLinePlot.dataSource = self;
    [graph addPlot:dataSourceLinePlot];
    
    // 创建一个颜色渐变：从 建变色 1 渐变到 无色
    CPTGradient *areaGradient = [ CPTGradient gradientWithBeginningColor :color endingColor :tmColor];
    // 渐变角度： -90 度（顺时针旋转）
    areaGradient.angle = -90.0f ;
    // 创建一个颜色填充：以颜色渐变进行填充
    CPTFill *areaGradientFill = [ CPTFill fillWithGradient :areaGradient];
    // 为图形设置渐变区
    dataSourceLinePlot. areaFill = areaGradientFill;
    dataSourceLinePlot. areaBaseValue = CPTDecimalFromString ( @"0" );
    dataSourceLinePlot.interpolation = CPTScatterPlotInterpolationLinear ;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)setDataForPlot1MM:(id )dataForPlot1
{
    NSString *xp = [NSString stringWithFormat:@"%d",j1];
    NSString *yp = [NSString stringWithFormat:@"%d",[dataForPlot1 intValue]];
    NSMutableDictionary *point1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:xp, @"x", yp, @"y", nil];
    [_dataForPlot1 addObject:point1];
    j1++;
//    [self reloadMyView];
}
- (void)setDataForPlot2MM:(id )dataForPlot2
{
    NSString *xp = [NSString stringWithFormat:@"%d",j2];
    NSString *yp = [NSString stringWithFormat:@"%d",[dataForPlot2 intValue]];
    NSMutableDictionary *point1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:xp, @"x", yp, @"y", nil];
    [_dataForPlot2 addObject:point1];
    j2++;
//    [self reloadMyView];
}
- (void)setDataForPlot3MM:(id)dataForPlot3
{
    NSString *xp = [NSString stringWithFormat:@"%d",j3];
    NSString *yp = [NSString stringWithFormat:@"%d",[dataForPlot3 intValue]];
    NSMutableDictionary *point1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:xp, @"x", yp, @"y", nil];
    [_dataForPlot3 addObject:point1];
    
    j3++;
//    [self reloadMyView];
}
- (void)setDataForPlot4MM:(id)dataForPlot4
{
    NSString *xp = [NSString stringWithFormat:@"%d",j4];
    NSString *yp = [NSString stringWithFormat:@"%d",[dataForPlot4 intValue]];
    NSMutableDictionary *point4 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:xp, @"x", yp, @"y", nil];
    [_dataForPlot4 addObject:point4];
    
    j4++;
//    [self reloadMyView];
}
- (void)setDataForPlot5MM:(id)dataForPlot5
{
    NSString *xp = [NSString stringWithFormat:@"%d",j5];
    NSString *yp = [NSString stringWithFormat:@"%d",[dataForPlot5 intValue]];
    NSMutableDictionary *point1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:xp, @"x", yp, @"y", nil];
    [_dataForPlot5 addObject:point1];
    
    j5++;
//    [self reloadMyView];
}
- (void)setDataForPlot6MM:(id)dataForPlot6
{
    NSString *xp = [NSString stringWithFormat:@"%d",j6];
    NSString *yp = [NSString stringWithFormat:@"%d",[dataForPlot6 intValue]];
    NSMutableDictionary *point1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:xp, @"x", yp, @"y", nil];
    [_dataForPlot6 addObject:point1];
    
    j6++;
    
//    [self reloadMyView];
}
- (void)setDataForPlot7MM:(id)dataForPlot7
{
    NSString *xp = [NSString stringWithFormat:@"%d",j7];
    NSString *yp = [NSString stringWithFormat:@"%d",[dataForPlot7 intValue]];
    NSMutableDictionary *point7 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:xp, @"x", yp, @"y", nil];
    [_dataForPlot7 addObject:point7];
    
    j7++;
//    [self reloadMyView];
}
- (void)setDataForPlot8MM:(id)dataForPlot8
{
    NSString *xp = [NSString stringWithFormat:@"%d",j8];
    NSString *yp = [NSString stringWithFormat:@"%d",[dataForPlot8 intValue]];
    NSMutableDictionary *point8 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:xp, @"x", yp, @"y", nil];
    [_dataForPlot8 addObject:point8];
    
    j8++;
//    [self reloadMyView];
}
- (void)reloadMyView
{
    [graph reloadData];
}
- (void)remoAllDATA
{
    [_dataForPlot1 removeAllObjects];
    [_dataForPlot2 removeAllObjects];
    [_dataForPlot3 removeAllObjects];
    [_dataForPlot4 removeAllObjects];
    [_dataForPlot5 removeAllObjects];
    [_dataForPlot6 removeAllObjects];
    [_dataForPlot7 removeAllObjects];
    [_dataForPlot8 removeAllObjects];
    j1 = 0;
    j2 = 0;
    j3 = 0;
    j4 = 0;
    j5 = 0;
    j6 = 0;
    j7 = 0;
    j8 = 0;
}
#pragma mark - dataSourceOpt

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    if ([((NSString *)plot.identifier) isEqualToString:@"A"]) {
        return _dataForPlot1.count;
    }
    else if ([((NSString *)plot.identifier) isEqualToString:@"B"]) {
    
      return _dataForPlot2.count;
    }
    else if ([((NSString *)plot.identifier) isEqualToString:@"C"]) {
        
        return _dataForPlot3.count;
    }
    else if ([((NSString *)plot.identifier) isEqualToString:@"D"]) {
        
        return _dataForPlot4.count;
    }
    else if ([((NSString *)plot.identifier) isEqualToString:@"E"]) {
        
        return _dataForPlot5.count;
    }
    else if ([((NSString *)plot.identifier) isEqualToString:@"F"]) {
        
        return _dataForPlot6.count;
    }
    else if ([((NSString *)plot.identifier) isEqualToString:@"G"]) {
        
        return _dataForPlot7.count;
    }
    else if ([((NSString *)plot.identifier) isEqualToString:@"H"]) {
        
        return _dataForPlot8.count;
    }
    return 0;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
    NSNumber *num;
    //让视图偏移
    if ( [(NSString *)plot.identifier isEqualToString:@"A"] ) {
        num = [[_dataForPlot1 objectAtIndex:index] valueForKey:key];
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            
        }
    }
    else if ( [(NSString *)plot.identifier isEqualToString:@"B"] ) {
        num = [[_dataForPlot2 objectAtIndex:index] valueForKey:key];
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            
        }
    }
    else if ( [(NSString *)plot.identifier isEqualToString:@"C"] ) {
        num = [[_dataForPlot3 objectAtIndex:index] valueForKey:key];
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            
        }
    }
    else if ( [(NSString *)plot.identifier isEqualToString:@"D"] ) {
        num = [[_dataForPlot4 objectAtIndex:index] valueForKey:key];
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            
        }
    }
    else if ( [(NSString *)plot.identifier isEqualToString:@"E"] ) {
        num = [[_dataForPlot5 objectAtIndex:index] valueForKey:key];
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            
        }
    }
    else if ( [(NSString *)plot.identifier isEqualToString:@"F"] ) {
        num = [[_dataForPlot6 objectAtIndex:index] valueForKey:key];
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            
        }
    }
    else if ( [(NSString *)plot.identifier isEqualToString:@"G"] ) {
        num = [[_dataForPlot7 objectAtIndex:index] valueForKey:key];
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            
        }
    }
    else if ( [(NSString *)plot.identifier isEqualToString:@"H"] ) {
        num = [[_dataForPlot8 objectAtIndex:index] valueForKey:key];
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            
        }
    }
    //添加动画效果
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnimation.duration = 0.01;
    fadeInAnimation.removedOnCompletion = NO;
    fadeInAnimation.fillMode = kCAFillModeForwards;
    fadeInAnimation.toValue = [NSNumber numberWithFloat:1];
    [plot addAnimation:fadeInAnimation forKey:@"animateOpacity"];
    
    return num;
}


@end
