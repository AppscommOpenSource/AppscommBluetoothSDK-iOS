/***************************************************************************************************
 *Copyright (c) 2015 Appscomm Inc. All rights reserved.
 *FileName:  AppscommBluetoothSDK.h
 *Author:  zhangwen
 *Date:  2015/05/15
 *Description: 蓝牙管理类
 *Others:
 **************************************************************************************************/


#import "AppscommDataTypes.h"

@class AppscommDevice;

@interface AppscommBluetoothSDK : NSObject

//SDK 版本
@property (nonatomic, copy, readonly) NSString *version;

//设备类型
@property (nonatomic, assign, readonly) AppscommDeviceType deviceType;

// 连接的设备
@property (nonatomic, strong, readonly) AppscommDevice *connectedDevice;

//系统蓝牙是否打开
@property (nonatomic, assign, readonly) BOOL bluetoothReady;


/**
 *  程序启动时调用, 最好放在UIApplicationDelegate里面
 */
+ (void)startRunBluetooth;

/**
 *  AppscommBluetoothSDK 单例，所有的方法调用
 *
 */
+ (AppscommBluetoothSDK *)sharedInstance;

/**
 *  扫描设备,根据设备类型来过滤
 *
 *  @param deviceType 设备类型
 *  @param seconds    超时，秒数
 */
- (void)scanDevicesWithType:(AppscommDeviceType)aDeviceType
            timeoutInternal:(NSUInteger)seconds
                 completion:(AppscommScanDevicesCallback)completion;

/**
 *  连接指定设备
 *
 *  @param device      指定设备
 *  @param seconds     超时，秒数
 */
- (void)connectDevice:(AppscommDevice *)device
      timeoutInternal:(NSUInteger)seconds
           completion:(AppscommConnectDeviceCallback)completion;

/**
 *  连接指定watchid的设备
 *
 *  @param aDeviceType 设备类型
 *  @param watchID     设备的WatchID，每个设备都有的唯一值
 *  @param seconds     超时，秒数
 */
- (void)connectDeviceWithType:(AppscommDeviceType)aDeviceType
                      watchID:(NSString *)aWatchID
              timeoutInternal:(NSUInteger)seconds
                   completion:(AppscommConnectDeviceCallback)completion;

/**
 *  以下方法是发送各种蓝牙命令
 *  注意：因为AppscommBluetoothSDK另开了一条线程在跑，请在所有回调中使用主线程刷新界面
 *
 *  dispatch_async(dispatch_get_main_queue(), ^{
 *      //做UI操作
 *  });
 *
 */
#pragma mark - 获取设备信息 -
/**
 *  获取设备的WatchID
 *
 *  @param completion 回调中的NSString为WatchID
 */
- (void)readWatchID:(AppscommReadStringValueCallback)completion;

/**
 *  获取设备的产品类型
 */
- (void)readProductType:(AppscommReadStringValueCallback)completion;

/**
 *  获取固件的版本号
 */
- (void)readFirmwareVersion:(AppscommReadStringValueCallback)completion;

/**
 *  获取设备的固件信息
 */
- (void)readFirmwareInformation:(AppscommReadStringValueCallback)completion;

/**
 *  获取设备的电池电量
 */
- (void)readDeviceBatteryPower:(AppscommReadIntegerValueCallback)completion;

#pragma mark - 获取运动睡眠数据 -


/**
 *  获取当前设备状态
 *  @since 只支持设备:L11, L38A, L28W, L28H
 */
- (void)readDeviceCurrentStatus:(AppscommReadDeviceStatusCallback)completion;

/**
 *  获取今天的运动汇总数据
 */
- (void)readTodaySportTotalData:(AppscommReadTodaySportTotalDataCallback)completion;

/**
 *  获取运动数据
 */
- (void)readSportData:(AppscommReadSportDataCallback)completion;

/**
 *  获取运动详细数据数量
 */
- (void)readSportDetailDataCount:(AppscommReadIntegerValueCallback)competion;

/**
 *  获取睡眠数据
 */
- (void)readSleepData:(AppscommReadSleepDataCallback)completion;

/**
 *  获取睡眠详细数据数量
 */
- (void)readSleepDetailDataCount:(AppscommReadIntegerValueCallback)competion;

#pragma mark - 用户信息 -

/**
 *  初始化设备,身高单位是厘米，体重单位是克
 *
 *  @param isFemale 性别
 *  @param height   身高(cm)
 *  @param weight   体重(g)
 *  @param isCleanData 是否清除数据，绑定的时候要清空数据
 */
- (void)writeUserInfoWithGenderIsFemale:(BOOL)isFemale
                                 height:(NSUInteger)height
                                 weight:(NSUInteger)weight
                          willCleanData:(BOOL)isCleanData
                             completion:(AppscommWriteSettingsCallback)completion;

/**
 *  获取用户信息
 */
- (void)readUserInfo:(AppscommReadUserInfoCallback)completion;

#pragma mark - 目标 -
/**
 *  设置步数目标值
 *
 *  @param stepsGoal   步数目标值
 */
- (void)writeStepsGoal:(NSUInteger)stepsGoal completion:(AppscommWriteSettingsCallback)completion;

/**
 *  设置卡路里目标值
 *
 *  @param caloriesGoal   卡路里目标值
 */
- (void)writeCaloriesGoal:(NSUInteger)caloriesGoal completion:(AppscommWriteSettingsCallback)completion;

/**
 *  设置距离目标值
 *
 *  @param distanceGoal   距离目标值
 */
- (void)writeDistanceGoal:(NSUInteger)distanceGoal completion:(AppscommWriteSettingsCallback)completion;



#pragma mark - 提醒 -


/**
 *  添加提醒(用时间来唯一标识提醒)
 *
 *  @param type   提醒类型
 *  @param hour   小时
 *  @param minute 分钟
 *  @param period 周期
 */
- (void)addReminderWithType:(AppscommReminderType)type
                       hour:(NSUInteger)hour
                     minute:(NSUInteger)minute
                     period:(NSUInteger)period
                 completion:(AppscommWriteSettingsCallback)completion;

/**
 *  删除提醒
 *
 *  @param hour   小时
 *  @param minute 分钟
 */
- (void)deleteReminderWithHour:(Byte)hour
                        minute:(Byte)minute
                    completion:(AppscommWriteSettingsCallback)completion;

/**
 *  清空提醒
 */
- (void)cleanAllReminders:(AppscommWriteSettingsCallback)completion;

/**
 *  获取所有提醒
 */
- (void)readReminders:(AppscommReadRemindersCallback)completion;

#pragma mark - 设备参数 -
/**
 *  恢复出厂设置(此命令发送之后，设备不会响应，所以不需要回调)
 */
- (void)resetDevice;

/**
 *  写入手机时间
 */
- (void)writeSystemTime:(AppscommWriteSettingsCallback)completion;

/**
 *  自定义时间写入
 *
 *  @param year        年
 *  @param month       月
 *  @param day         日
 *  @param hour        时
 *  @param minute      分
 *  @param second      秒
 */
- (void)writeCustomTimeWithYear:(NSUInteger)year
                          month:(NSUInteger)month
                            day:(NSUInteger)day
                           hour:(NSUInteger)hour
                         minute:(NSUInteger)minute
                         second:(NSUInteger)second
                     completion:(AppscommWriteSettingsCallback)completion;

/**
 *  设置时间格式和距离单位
 *
 *  @param format 时间格式
 *  @param unit   距离单位
 *  @since AppscommTimeFormat中'AppscommTimeFormat_24H'和'AppscommTimeFormat_12H'支持所有设备，
           其他只支持设备:L11, L38A, L28W, L28H
 */
- (void)writeTimeFormat:(AppscommTimeFormat)format
           distanceUnit:(AppscommDidstanceUnit)unit
             completion:(AppscommWriteSettingsCallback)completion;

/**
 *  获取时间格式和距离单位
 *
 */
- (void)readTimeFormatAndDistanceUnit:(AppscommReadTimeFormatAndDistanceUnitCallback)completion;

/**
 *  设置预设睡眠时间，设备会自动进入睡眠，自动醒来
 *  @since 只支持设备:L11, L38A, L28W, L28H
 *
 *  @param isOpened    开关状态
 *  @param sleepHour   睡眠小时数
 *  @param sleepMinute 睡眠分钟数
 *  @param awakeHour   醒来小时数
 *  @param awakeMinute 醒来分钟数
 
 */
- (void)writeAutomaticSleepOpened:(BOOL)isOpened
                        sleepHour:(NSUInteger)sleepHour
                      sleepMinute:(NSUInteger)sleepMinute
                        awakeHour:(NSUInteger)awakeHour
                      awakeMinute:(NSUInteger)awakeMinute
                       completion:(AppscommWriteSettingsCallback)completion;

/**
 *  获取预设睡眠参数
 *  @since 只支持设备:L11, L38A, L28W, L28H
 */
- (void)readAutomaticSleepTime:(AppscommReadAutomaticSleepTimeCallback)completion;

/**
 *  手动让设备进入睡眠
 *  @since 只支持设备:L11, L38A, L28W
 */
- (void)manuallyEnterSleep:(AppscommWriteSettingsCallback)completion;

/**
 *  手动让设备退出睡眠
 *  @since 只支持设备:L11, L38A, L28W
 */
- (void)manuallyQuitSleep:(AppscommWriteSettingsCallback)completion;

/**
 *  通知开关设置
 *  @since 只支持设备:L11, L38A, L28T, L28W, L28H
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

/**
 *  获取通知状态
 *  @since 只支持设备:L11, L38A, L28T, L28W, L28H
 */
- (void)readNotificationsStatus:(AppscommReadNotificationsStatusCallback)completion;

/**
 *  设置久坐提醒
 *  @since 只支持设备:L11, L38A, L28W, L28H
 *
 *  @param isOpen      开关
 *  @param internal    间隔
 *  @param startHour   开始小时
 *  @param startMinute 开始分钟
 *  @param endHour     结束小时
 *  @param endMinute   结束分钟
 *  @param period      周期, AppscommWeekPeriod类型组合, 例如周期为每周的星期一和星期二
 *                     NSUInteger period = AppscommPeriodMonday | AppscommPeriodTuesday;
 *  @param steps       有效步数,超过有效步数才算运动
 */
- (void)writeInactivityAlertStatus:(BOOL)isOpen
                          internal:(NSUInteger)internal
                         startHour:(NSUInteger)startHour
                       startMinute:(NSUInteger)startMinute
                           endHour:(NSUInteger)endHour
                         endMinute:(NSUInteger)endMinute
                            period:(NSUInteger)period
                             steps:(NSUInteger)steps
                        completion:(AppscommWriteSettingsCallback)completion;

/**
 *  获取久坐提醒信息
 *  @since 只支持设备:L11, L38A, L28W, L28H
 */
- (void)readInactivityAlertInfo:(AppscommReadInactivityAlertInfoCallback)completion;

/**
 *  设置屏幕亮度
 *  @since 只支持设备:L11, L38A, L28W, L28H
 *
 *  @param lightness 亮度
 */
- (void)writeScreenLightness:(AppscommLightness)lightness completion:(AppscommWriteSettingsCallback)completion;

/**
 *  获取屏幕亮度
 *  @since 只支持设备:L11, L38A, L28W, L28H
 */
- (void)readScreenLightness:(AppscommReadLightnessCallback)completion;

@end