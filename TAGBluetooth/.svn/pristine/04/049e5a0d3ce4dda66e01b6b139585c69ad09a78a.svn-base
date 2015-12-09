//
//  OldlistViewController.m
//  TGAMPower
//
//  Created by bai on 15/8/5.
//  Copyright (c) 2015年 bai. All rights reserved.
//

#import "OldlistViewController.h"

#define FILEPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface OldlistViewController ()
@property (weak, nonatomic) IBOutlet UITableView *oldtableview;

@property (strong, nonatomic) NSMutableArray *getOldList;

@end

@implementation OldlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    _getOldList = [[NSMutableArray alloc] init];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:FILEPATH error:nil]];
    
    for (NSString *text in arr) {
        NSArray *getFilename = [text componentsSeparatedByString:@"."];
        
        if (getFilename.count == 2) {
            if ([getFilename[1] isEqualToString:@"txt"]) {
                [_getOldList addObject:text];
            }
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.getOldList count];
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
    NSString *peripheral  = [_getOldList objectAtIndex:row];
    cell.textLabel.text = peripheral;
    //cell.detailTextLabel.text = [NSString stringWithFormat:(NSString *), ...
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_selPath) {
        NSString *peripheral  = [_getOldList objectAtIndex:indexPath.row];
        peripheral = [NSString stringWithFormat:@"%@/%@",FILEPATH,peripheral];
        _selPath(peripheral);
    }
    
}
@end
