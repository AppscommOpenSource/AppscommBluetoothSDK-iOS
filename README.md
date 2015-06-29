# 概述
AppscommBluetoothSDK-iOS 是广东乐源数字技术有限公司对手环蓝牙协议进行封装的库，客户可以基于此SDK进行二次开发。

# 系统要求
iOS 7.0+

# 使用说明
- 添加`CoreBluetooth.framework`
- 在`Build Settings`的`Library Search Paths`分别添加`Debug`和`Release`的目录，即lib所在目录。Debug的lib有蓝牙命令的log输出，便于调试
- 在`Build Settings`的`Other Link Flags`添加`-lAppscommBluetoothSDK`
- lib支持armv7, arm64, i386
- 首先在`didFinishLaunchingWithOptions`调用`[AppscommBluetoothSDK startRunBluetooth]`

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AppscommBluetoothSDK startRunBluetooth];
    return YES;
}
```

- 以后使用`[AppscommBluetoothSDK sharedInstance]`来调用各种方法

```
__weak ScanDevicesTableViewController *weakSelf = self;
[[AppscommBluetoothSDK sharedInstance] scanDevicesWithType:self.deviceType
                                               timeoutInternal:5
                                                    completion:^(NSArray *scanedDevices,NSError *error){
                                                        if (!error) {
                                                            weakSelf.devicesArray = [NSArray arrayWithArray:scanedDevices];
                                                            [weakSelf.tableView reloadData];
                                                        }

}];

```

- 所有回调请回到主线程更新UI

- 如果某个功能是特定手环的，将会在注释里面说明，否则都支持。请根据`deviceType`来操作，有些设备不支持某些操作将报错。

```
/**
 *  通知开关设置
 *  @since 只支持设备:L11, L28T, L28W, L28H
 *
 *  @param callIsOpened       来电
 *  @param missedCallIsOpened 未接来电
 *  @param SMSIsOpened        短信
 *  @param emailIsOpened      邮件
 *  @param socialIsOpened     社交
 *  @param calendarIsOpened   日历
 *  @param antiLostIsOpened   防丢
 */
- (void)writeNotificationsWithCallsStatus:(BOOL)callIsOpened
                        missedCallsStatus:(BOOL)missedCallIsOpened
                                SMSStatus:(BOOL)SMSIsOpened
                              emailStatus:(BOOL)emailIsOpened
                        socialMediaStatus:(BOOL)socialIsOpened
                           calendarStatus:(BOOL)calendarIsOpened
                           antiLostStatus:(BOOL)antiLostIsOpened
                               completion:(AppscommWriteSettingsCallback)completion;
```

#更新历史

##v2.1.2 
- 当蓝牙功能关闭时，调用系统的打开蓝牙提示

##v2.1.1
- 不限制时间格式的类型，因为这个参数在不同产品都不一样

##v2.1
- 增加停止扫描功能
- 增加断开连接设备功能
- 增加超时判断，10秒钟设备无反应将回调NSError

##v2.0
- 采用Block机制重写蓝牙SDK
- 增加不同产品类型的兼容性

