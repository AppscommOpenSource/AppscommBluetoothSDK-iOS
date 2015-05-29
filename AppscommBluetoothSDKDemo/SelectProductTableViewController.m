//
//  SelectProductTableViewController.m
//  AppscommBluetoothSDKDemo
//
//  Created by zhangwen on 15/5/23.
//  Copyright (c) 2015年 Appscomm. All rights reserved.
//

#import "SelectProductTableViewController.h"
#import "ScanDevicesTableViewController.h"
@interface SelectProductTableViewController ()
@property (nonatomic, strong) NSArray *products;
@end

@implementation SelectProductTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.products = @[@"Unlimited",  @"L11", @"L23", @"L28C",
                 @"L28S", @"L28T", @"L28W", @"L30", @"L30B",
                 @"L30D", @"L38A", @"L40"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCellID" forIndexPath:indexPath];
    cell.textLabel.text = self.products[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ScanDeviceSegueID" sender:[tableView cellForRowAtIndexPath:indexPath]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ScanDevicesTableViewController *vc =  [segue destinationViewController];
    if ([vc respondsToSelector:@selector(setDeviceType:)]) {
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        vc.deviceType =(AppscommDeviceType)path.row;
    }
}


@end
