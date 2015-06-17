//
//  ScanDevicesTableViewController.m
//  AppscommBluetoothSDKDemo
//
//  Created by zhangwen on 15/5/16.
//  Copyright (c) 2015年 Appscomm. All rights reserved.
//

#import "ScanDevicesTableViewController.h"
#import "AppscommDevice.h"
#import "TestSDKViewController.h"

@interface ScanDevicesTableViewController ()
@property (nonatomic, strong) NSArray *devicesArray;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation ScanDevicesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.devicesArray = [NSArray new];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 10, 70, 30);
    [_rightButton setTitle:@"扫描设备" forState:UIControlStateNormal];
    [_rightButton setTitle:@"停止扫描" forState:UIControlStateSelected];
    [_rightButton addTarget:self action:@selector(searchDevices) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];

    [self searchDevices];
}

//测试连接已绑定的设备
- (void)connectSpecialDevice{

    [[AppscommBluetoothSDK sharedInstance] connectDeviceWithType:AppscommDeviceTypeL28S watchID:@"FCL28C14080426032437" timeoutInternal:10 completion:^(NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^(){
            if (!error) {
                [self performSegueWithIdentifier:@"TestSDKSegueID" sender:self];
            }else{
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"连接设备失败"
                                                                    message:[NSString stringWithFormat:@"%@", error]
                                                                   delegate:self
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
        });

    }];
}

//搜索设备，未绑定的情况下
- (void)searchDevices{
    self.rightButton.selected = !self.rightButton.selected;
    if (self.rightButton.selected) {
        self.devicesArray = nil;
        [self.tableView reloadData];
        
        [[AppscommBluetoothSDK sharedInstance] scanDevicesWithType:self.deviceType
                                                   timeoutInternal:5
                                                        completion:^(NSArray *scanedDevices,NSError *error){
                                                            ASYNC_MAIN_QUEUE_START
                                                            self.devicesArray = [NSArray arrayWithArray:scanedDevices];
                                                            if (self.rightButton.selected) {
                                                                self.rightButton.selected = NO;
                                                            }
                                                            [self.tableView reloadData];
                                                            ASYNC_MAIN_QUEUE_END
                                                            
                                                            
                                                        }];
    }else{
        [[AppscommBluetoothSDK sharedInstance] stopScanDevices];
    }

}

- (void)showAlertWithString:(NSString *)msg{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [alertController dismissViewControllerAnimated:NO completion:nil];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.devicesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DevicesCellID" forIndexPath:indexPath];
    
    AppscommDevice *p = [self.devicesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = p.name;
    cell.detailTextLabel.text = p.localName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppscommDevice *p = [self.devicesArray objectAtIndex:indexPath.row];
    [[AppscommBluetoothSDK sharedInstance] connectDevice:p timeoutInternal:10 completion:^(NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{

            if (!error) {
                [self performSegueWithIdentifier:@"TestSDKSegueID" sender:self];
            }else{
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"连接设备失败"
                                                                    message:[NSString stringWithFormat:@"%@", error]
                                                                   delegate:self
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
        });
    }];
                           
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
