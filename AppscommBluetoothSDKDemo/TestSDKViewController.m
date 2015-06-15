//
//  TestSDKViewController.m
//  AppscommBluetoothSDKDemo
//
//  Created by zhangwen on 15/5/15.
//  Copyright (c) 2015年 Appscomm. All rights reserved.
//

#import "TestSDKViewController.h"
#import "AppscommBluetoothSDK.h"
#import "DetailViewController.h"
@interface TestSDKViewController ()
@property (nonatomic, strong) NSArray *deviceInfo;
@property (nonatomic, strong) NSArray *sportSleepData;
@property (nonatomic, strong) NSArray *userInfo;
@property (nonatomic, strong) NSArray *goal;
@property (nonatomic, strong) NSArray *settings;
@property (nonatomic, strong) NSArray *reminder;
@property (nonatomic, strong) NSMutableArray *allCmds;
@property (nonatomic, copy) NSString *data;
@end

@implementation TestSDKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _deviceInfo =@[@"获取产品类型",@"获取设备串号", @"获取WatchID", @"获取固件版本号", @"获取电量"];
    _sportSleepData =@[@"设备当前状态",@"获取今天的运动汇总数据",@"获取运动详细数据数量",@"获取运动详细数据",@"获取睡眠详细数据数量",@"获取睡眠详细数据"];
    _userInfo= @[@"初始化用户信息(删除数据)", @"初始化用户信息(不删数据)",@"读取用户信息"];
    _goal = @[@"设置步数目标", @"设置卡路里目标", @"设置距离目标"];
    _settings = @[@"恢复出厂设置", @"设置时间", @"设置时间格式和距离单位", @"设置自动睡眠时间", @"设置通知开关",@"读取通知开关", @"设置久坐提醒",@"读取久坐提醒", @"设置屏幕亮度",@"读取屏幕亮度", @"手动进入睡眠", @"手动退出睡眠"];
    _reminder = @[@"添加提醒", @"读取所有提醒", @"删除提醒", @"清空提醒"];

    
    _allCmds = [NSMutableArray new];
   [_allCmds addObjectsFromArray:_deviceInfo];
   [_allCmds addObjectsFromArray:_sportSleepData];
   [_allCmds addObjectsFromArray:_userInfo];
   [_allCmds addObjectsFromArray:_goal];
   [_allCmds addObjectsFromArray:_settings];
   [_allCmds addObjectsFromArray:_reminder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertWithString:(NSString *)msg{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [alertController dismissViewControllerAnimated:NO completion:nil];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:NO completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"ShowDetailID"]) {
        DetailViewController *vc = segue.destinationViewController;
        [vc setDetail:[NSString stringWithFormat:@"%@", self.data]];
    }
}

#pragma mark - UITableViewDelegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0: return @"设备信息";
        case 1: return @"运动睡眠数据";
        case 2: return @"用户信息";
        case 3: return @"目标";
        case 4: return @"参数设置";
        case 5: return @"提醒";
        default:return @"";
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0: return self.deviceInfo.count;
        case 1: return self.sportSleepData.count;
        case 2: return self.userInfo.count;
        case 3: return self.goal.count;
        case 4: return self.settings.count;
        case 5: return self.reminder.count;
        default:return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommandCellID" forIndexPath:indexPath ];
    NSString *title = @"";
    switch (indexPath.section) {
        case 0: title = _deviceInfo[indexPath.row]; break;
        case 1: title = _sportSleepData[indexPath.row]; break;
        case 2: title = _userInfo[indexPath.row]; break;
        case 3: title = _goal[indexPath.row]; break;
        case 4: title = _settings[indexPath.row]; break;
        case 5: title = _reminder[indexPath.row]; break;
        default:
            break;
    }
    cell.textLabel.text = title;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        [self TestDeviceInfoWithIndex:indexPath.row];
    } else if(indexPath.section == 1){
        [self TestSportSleepDataWithIndex:indexPath.row];

    } else if(indexPath.section == 2){
        [self TestUserInfoWithIndex:indexPath.row];
    } else if(indexPath.section == 3){
        [self TestGoalWithIndex:indexPath.row];
    } else if(indexPath.section == 4){
        [self TestSettingsWithIndex:indexPath.row];
    } else if(indexPath.section == 5){
        [self TestReminderWithIndex:indexPath.row];
    } else if(indexPath.section == 6){
        
    }
}

- (void)TestDeviceInfoWithIndex:(NSUInteger)index{
    
    __weak TestSDKViewController *weakSelf = self;
    switch (index) {
        case 0:{
            [[AppscommBluetoothSDK sharedInstance] readProductType:^(NSString *name,NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:name];
                });
            }];
            break;
        }
        case 1:{
            [[AppscommBluetoothSDK sharedInstance] readFirmwareInformation:^(NSString *name,NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf showAlertWithString:name];
                    });
            }];
            break;
        }
    
        case 2:{
            [[AppscommBluetoothSDK sharedInstance] readWatchID:^(NSString *name,NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf showAlertWithString:name];
                });
                
            }];
            break;
        }
            
        case 3:{
            [[AppscommBluetoothSDK sharedInstance] readFirmwareVersion:^(NSString *ver,NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:ver];
                });
            }];
            break;
        }
            
        case 4:{
            [[AppscommBluetoothSDK sharedInstance] readDeviceBatteryPower:^(NSUInteger value, NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%ld%%", (long)value]];
                });
            }];
            break;
        }
    }
}
- (void)TestSportSleepDataWithIndex:(NSUInteger)index{
    
    __weak TestSDKViewController *weakSelf = self;
    switch (index) {
        case 0:{
            [[AppscommBluetoothSDK sharedInstance] readDeviceCurrentStatus:^(AppscommDeviceStatus status, NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == AppscommDeviceInSleep) {
                        [weakSelf showAlertWithString:@"睡眠"];
                    }else if(status == AppscommDeviceNormal){
                        [weakSelf showAlertWithString:@"正常"];
                    }else{
                        [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error]];
                    }
                });
            }];
            break;
        }
            
        case 1:{
            [[AppscommBluetoothSDK sharedInstance] readTodaySportTotalData:^(NSUInteger steps, NSUInteger calories,NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"步数:%ld , 卡路里:%ld", (long)steps, (long)calories]];
                });
            }];
            break;
        }
    
        case 2:{
            [[AppscommBluetoothSDK sharedInstance] readSportDetailDataCount:^(NSUInteger count,NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"运动详细数据数量:%ld", (long)count]];
                });
            }];
            break;
        }
        
        case 3:{
            [[AppscommBluetoothSDK sharedInstance] readSportData:^(NSArray *data,NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.data = [NSString stringWithFormat:@"%@", data];
                    [weakSelf performSegueWithIdentifier:@"ShowDetailID" sender:self];
                    
                });
            }];
            break;
        }
            
        case 4:{
            [[AppscommBluetoothSDK sharedInstance] readSleepDetailDataCount:^(NSUInteger count,NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"睡眠详细数据数量:%ld", (long)count]];
                });
            }];
            break;
        }
            
        case 5:{
            [[AppscommBluetoothSDK sharedInstance] readSleepData:^(NSArray *data,NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.data = @"";
                    [data enumerateObjectsUsingBlock:^(AppscommSleepTotalData *total, NSUInteger index, BOOL *stop){
                        self.data = [self.data stringByAppendingFormat:@"%@", total];
                    }];
                    
                    [self performSegueWithIdentifier:@"ShowDetailID" sender:self];
                });
            }];
            break;
        }
 
    }
}
- (void)TestUserInfoWithIndex:(NSUInteger)index{
    __weak TestSDKViewController *weakSelf = self;
    switch (index) {
        case 0:{
            [[AppscommBluetoothSDK sharedInstance] writeUserInfoWithGenderIsFemale:NO
                                                                            height:180
                                                                            weight:88000
                                                                     willCleanData:YES
                                                                        completion:^(NSError *error){
                                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                                [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                                                                            });
                                                                        }];
            break;
        }
            
        case 1:{
            [[AppscommBluetoothSDK sharedInstance] writeUserInfoWithGenderIsFemale:YES
                                                                            height:180
                                                                            weight:88000
                                                                     willCleanData:NO
                                                                        completion:^(NSError *error){
                                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                                [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                                                                            });
                                                                        }];
            break;
        }
            
        case 2:{
            [[AppscommBluetoothSDK sharedInstance] readUserInfo:^(BOOL isFemale,
                                                                  NSUInteger height,
                                                                  NSUInteger weight,
                                                                  NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@,%lucm,%lug", isFemale ? @"女":@"男", (unsigned long)height, (unsigned long)weight]];
                });
            }];
            break;
        }
    }
}
- (void)TestGoalWithIndex:(NSUInteger)index{
    __weak TestSDKViewController *weakSelf = self;
    switch (index) {
        case 0:{
            [[AppscommBluetoothSDK sharedInstance] writeStepsGoal:10000 completion:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];
            break;
        }
            
        case 1:{
            [[AppscommBluetoothSDK sharedInstance] writeCaloriesGoal:1000 completion:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];
            break;
        }
            
        case 2:{
            [[AppscommBluetoothSDK sharedInstance] writeDistanceGoal:10 completion:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];
            break;
        }
    }
}
- (void)TestSettingsWithIndex:(NSUInteger)index{
    __weak TestSDKViewController *weakSelf = self;
    switch (index) {
        case 0:{
            [[AppscommBluetoothSDK sharedInstance] resetDevice];
            break;
        }
            
        case 1:{
            [[AppscommBluetoothSDK sharedInstance] writeSystemTime:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];

            break;
        }
            
        case 2:{
            [[AppscommBluetoothSDK sharedInstance] writeTimeFormat:AppscommTimeFormat_12H distanceUnit:AppscommDidstanceUnitMi completion:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];
            break;
        }
        
        case 3:{
            [[AppscommBluetoothSDK sharedInstance] writeAutomaticSleepOpened:YES sleepHour:22 sleepMinute:10 awakeHour:8 awakeMinute:30  completion:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];
            break;
        }
            
        case 4:{
            [[AppscommBluetoothSDK sharedInstance] writeNotificationsWithCallsStatus:YES missedCallsStatus:YES SMSStatus:YES emailStatus:YES socialMediaStatus:YES calendarStatus:YES antiLostStatus:YES completion:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];
            break;
        }
        case 5:{
            [[AppscommBluetoothSDK sharedInstance] readNotificationsStatus:^(BOOL callIsOpened,
                                                                             BOOL missedCallIsOpened,
                                                                             BOOL SMSIsOpened,
                                                                             BOOL emailIsOpened,
                                                                             BOOL socialIsOpened,
                                                                             BOOL calendarIsOpened,
                                                                             BOOL antiLostIsOpened,
                                                                             NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"callIsOpened:%d\nmissedCallIsOpened:%d\nSMSIsOpened:%d\nemailIsOpened:%d\nsocialIsOpened:%d\ncalendarIsOpened:%d\nantiLostIsOpened:%d\n%@", callIsOpened, missedCallIsOpened, SMSIsOpened, emailIsOpened, socialIsOpened, calendarIsOpened, antiLostIsOpened,error]];
                });
            }];
            break;
        }
            
        case 6:{
            [[AppscommBluetoothSDK sharedInstance] writeInactivityAlertStatus:YES
                                                                     internal:30
                                                                    startHour:6
                                                                  startMinute:0
                                                                      endHour:22
                                                                    endMinute:0
                                                                       period:(AppscommPeriodMonday | AppscommPeriodTuesday | AppscommPeriodFriday)
                                                                        steps:100
                                                                   completion:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];
            break;
        }
            
        case 7:{
            [[AppscommBluetoothSDK sharedInstance] readInactivityAlertInfo:^(BOOL isOpen,
                                                                             NSUInteger internal,
                                                                             NSUInteger startHour,
                                                                             NSUInteger startMinute,
                                                                             NSUInteger endHour,
                                                                             NSUInteger endMinute,
                                                                             NSUInteger period,
                                                                             NSUInteger steps,
                                                                             NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"isOpen:%d\n internal:%ld\n startHour:%ld\n startMinute:%ld\n endHour:%ld\n endMinute:%ld\n period:%ld steps:%ld\n error:%@",
                                                   isOpen,
                                                   (unsigned long)internal,
                                                   (unsigned long)startHour,
                                                   (unsigned long)startMinute,
                                                   (unsigned long)endHour,
                                                   (unsigned long)endMinute,
                                                   (unsigned long)period,
                                                   (unsigned long)steps,
                                                   error?error:@"成功"]];
                });
            }];
            break;
        }
            
        case 8:{
            [[AppscommBluetoothSDK sharedInstance] writeScreenLightness:AppscommLightnessLarge completion:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];
            break;
        }
        case 9:{
            [[AppscommBluetoothSDK sharedInstance] readScreenLightness:^(AppscommLightness lightness, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"亮度:%d, %@", (int)lightness,error?error:@"成功"]];
                });
            }];
            break;
        }
            
        case 10:{
            [[AppscommBluetoothSDK sharedInstance] manuallyEnterSleep:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];
            break;
        }
            
        case 11:{
            [[AppscommBluetoothSDK sharedInstance] manuallyQuitSleep:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];
            break;
        }
    }
}
- (void)TestReminderWithIndex:(NSUInteger)index{
    __weak TestSDKViewController *weakSelf = self;
    switch (index) {
        case 0:{
            [[AppscommBluetoothSDK sharedInstance] addReminderWithType:AppscommReminderTypeDrinkWater hour:13 minute:16 period:4 completion:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];
            break;
        }
        
        case 1:{
            [[AppscommBluetoothSDK sharedInstance] readReminders:^( NSArray *reminders,NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.data = [NSString stringWithFormat:@"%@", reminders];
                    [weakSelf performSegueWithIdentifier:@"ShowDetailID" sender:self];
                });
            }];
            
            break;
        }
            
        case 2:{
            [[AppscommBluetoothSDK sharedInstance] deleteReminderWithHour:13 minute:16 completion:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];
            
            break;
        }
    
        case 3:{
            [[AppscommBluetoothSDK sharedInstance] cleanAllReminders:^(NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertWithString:[NSString stringWithFormat:@"%@", error?error:@"成功"]];
                });
            }];
            
            break;
        }
    }
}
@end
