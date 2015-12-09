//
//  PopDriverViewController.m
//  TGAMPower
//
//  Created by bai on 15/7/6.
//  Copyright (c) 2015年 bai. All rights reserved.
//

#import "PopDriverViewController.h"

@interface PopDriverViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@end

@implementation PopDriverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setPeripheralViewControllerArray:(NSMutableArray *)peripheralViewControllerArray
{
    _peripheralViewControllerArray = peripheralViewControllerArray;
    [self.tableVIew reloadData];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.peripheralViewControllerArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"peripheral";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    // Configure the cell
    NSUInteger row = [indexPath row];
    CBPeripheral *peripheral  = [_peripheralViewControllerArray objectAtIndex:row];
    cell.textLabel.text = peripheral.name;
    //cell.detailTextLabel.text = [NSString stringWithFormat:(NSString *), ...
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_perI) {
        _perI(_peripheralViewControllerArray[indexPath.row]);
    }
}
@end
