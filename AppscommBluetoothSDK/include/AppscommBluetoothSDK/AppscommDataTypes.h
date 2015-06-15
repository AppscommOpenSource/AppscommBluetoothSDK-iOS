/***************************************************************************************************
 *Copyright (c) 2015 Appscomm Inc. All rights reserved.
 *FileName:  AppscommDataTypes.h
 *Author:  zhangwen
 *Date:  2015/05/22
 *Description: 数据类型定义
 *Others:
 **************************************************************************************************/
#import <Foundation/Foundation.h>

#pragma mark - 枚举

/*
 * 蓝牙设备类型
 */
typedef NS_ENUM(NSUInteger, AppscommDeviceType) {
    AppscommDeviceTypeUnlimited,
    AppscommDeviceTypeL11,
    AppscommDeviceTypeL23,
    AppscommDeviceTypeL28C,
    AppscommDeviceTypeL28S,
    AppscommDeviceTypeL28T,
    AppscommDeviceTypeL28W,
    AppscommDeviceTypeL28H,
    AppscommDeviceTypeL30,
    AppscommDeviceTypeL30B,
    AppscommDeviceTypeL30D,
    AppscommDeviceTypeL38A,
    AppscommDeviceTypeL40
};

/*
 *  时间格式
 */
typedef NS_ENUM(NSUInteger, AppscommTimeFormat) {
    /*
     * 以下两个参数适用全部设备
     */
    AppscommTimeFormat_24H                = 0,
    AppscommTimeFormat_12H                = 1,
    
    /*
     * 以下参数适用L11, L28T, L28W, L28H设备
     */
    AppscommTimeFormat_24H_Battery_MMDDYY = 44,
    AppscommTimeFormat_24H_Battery_DDMMYY = 36,
    AppscommTimeFormat_24H_Battery_YYDDMM = 52,
    
    AppscommTimeFormat_12H_Battery_MMDDYY = 45,
    AppscommTimeFormat_12H_Battery_DDMMYY = 37,
    AppscommTimeFormat_12H_Battery_YYDDMM = 53,
    
    AppscommTimeFormat_24H_MMDDYY         = 12,
    AppscommTimeFormat_24H_DDMMYY         = 4,
    AppscommTimeFormat_24H_YYDDMM         = 20,
    
    AppscommTimeFormat_12H_MMDDYY         = 13,
    AppscommTimeFormat_12H_DDMMYY         = 5,
    AppscommTimeFormat_12H_YYDDMM         = 21,
};

/*
 *  屏幕亮度
 */
typedef NS_ENUM(NSUInteger, AppscommLightness) {
    AppscommLightnessSmall,
    AppscommLightnessMedium,
    AppscommLightnessLarge
};

/*
 *  距离单位
 */
typedef NS_ENUM(NSUInteger, AppscommDidstanceUnit) {
    AppscommDidstanceUnitKm,  //千米单位
    AppscommDidstanceUnitMi   //英里单位
};

/*
 *  设备当前状态
 */
typedef NS_ENUM(NSUInteger, AppscommDeviceStatus) {
    AppscommDeviceUnknown = -1,   //未知
    AppscommDeviceNormal  = 0,    //正常计步状态
    AppscommDeviceInSleep = 1,    //睡眠状态
};

/*
 *  提醒类型，每一种设备只支持6种类型
 */
typedef NS_ENUM(NSUInteger, AppscommReminderType) {
    /*
     *  以下类型全部设备适用
     */
    AppscommReminderTypeEat,        //吃饭
    AppscommReminderTypeMadicine,   //吃药
    AppscommReminderTypeActivity,   //运动
    AppscommReminderTypeSleep,      //睡觉
    
    /*
     *  以下类型适用于L28C, L28S, L28T
     */
    AppscommReminderTypeCustom,     //自定义
    
    /*
     *  以下类型适用于L28C, L28S
     */
    AppscommReminderTypeDrinkWater, //喝水
    
    /*
     *  以下类型适用于L11, L28W, L38A, L28T
     */
    AppscommReminderTypeWakeup,     //清醒(起床)
    
    /*
     *  以下类型适用于L11, L28W, L38A,
     */
    AppscommReminderTypeMeeting,    //会议
    
};

/*
 *  睡眠类型
 */
typedef NS_ENUM(NSUInteger, AppscommSleepType) {
    AppscommSleepTypeStart           = 16,//开始
    AppscommSleepTypeFallSleep       = 3,//入睡(真正开始睡觉)
    AppscommSleepTypelightSleep      = 1,//浅睡
    AppscommSleepTypeDeepSleep       = 0,//深睡
    AppscommSleepTypeWakeup          = 2,//清醒
    AppscommSleepTypeEnd             = 17,//结束
    AppscommSleepTypePresetSleepTime = 18,//预设睡眠时间
};

/*
 *  周期类型
 */
typedef NS_OPTIONS(NSUInteger, AppscommWeekPeriod) {
    AppscommPeriodMonday    = 1 << 0,// 星期一
    AppscommPeriodTuesday   = 1 << 1,// 星期二
    AppscommPeriodWednesday = 1 << 2,// 星期三
    AppscommPeriodThursday  = 1 << 3,// 星期四
    AppscommPeriodFriday    = 1 << 4,// 星期五
    AppscommPeriodSaturday  = 1 << 5,// 星期六
    AppscommPeriodSunday    = 1 << 6,// 星期日
};

#pragma mark - Blocks 定义

/**
 *  扫描设备回调
 */
typedef void(^AppscommScanDevicesCallback)(NSArray *devices, NSError *error);

/**
 *  连接设备, 只有成功与否的结果返回
 */
typedef void(^AppscommConnectDeviceCallback)(NSError *error);

/**
 *  设置参数回调, 只有成功与否的结果返回
 */
typedef void(^AppscommWriteSettingsCallback)(NSError *error);

/**
 * 获取字符串数据
 */
typedef void(^AppscommReadStringValueCallback)(NSString *string, NSError *error);

/**
 * 获取整数回调数据
 */
typedef void(^AppscommReadIntegerValueCallback)(NSUInteger value, NSError *error);

/**
 *  获取用户信息
 *
 *  @param isFemale 性别
 *  @param height   身高
 *  @param weight   体重
 */
typedef void(^AppscommReadUserInfoCallback)(BOOL isFemale,
                                            NSUInteger height,
                                            NSUInteger weight,
                                            NSError *error);


/**
 *  获取今天的运动汇总数据
 *
 *  @param steps    步数
 *  @param calories 卡路里
 */
typedef void(^AppscommReadTodaySportTotalDataCallback)(NSUInteger steps,
                                                       NSUInteger calories,
                                                       NSError *error);

/**
 *  获取运动详细数据
 *
 *  @param sportDatas 数据类型是AppscommSportData
 */
typedef void(^AppscommReadSportDataCallback)(NSArray *sportDatas, NSError *error);

/**
 *  获取睡眠数据
 *
 *  @param sleepDatas 数据类型是AppscommSleepTotalData
 */
typedef void(^AppscommReadSleepDataCallback)(NSArray *sleepDatas, NSError *error);

/**
 *  获取时间格式和距离单位
 *
 *  @param format 时间格式
 *  @param unit   距离单位
 */
typedef void(^AppscommReadTimeFormatAndDistanceUnitCallback)(AppscommTimeFormat format,
                                                             AppscommDidstanceUnit unit,
                                                             NSError *error);
/**
 *  获取预设睡眠时间
 *
 *  @param sleepHour   睡眠小时
 *  @param sleepMinute 睡眠分钟
 *  @param awakeHour   醒来小时
 *  @param awakeMinute 新来分钟
 */
typedef void(^AppscommReadAutomaticSleepTimeCallback)(NSUInteger sleepHour,
                                                      NSUInteger sleepMinute,
                                                      NSUInteger awakeHour,
                                                      NSUInteger awakeMinute,
                                                      NSError *error);
/**
 *  获取通知开关状态
 *
 *  @param callIsOpened       来电
 *  @param missedCallIsOpened 未接来电
 *  @param SMSIsOpened        短信
 *  @param emailIsOpened      电子邮件
 *  @param socialIsOpened     社交
 *  @param calendarIsOpened   日历
 *  @param antiLostIsOpened   防丢
 */
typedef void(^AppscommReadNotificationsStatusCallback)(BOOL callIsOpened,
                                                       BOOL missedCallIsOpened,
                                                       BOOL SMSIsOpened,
                                                       BOOL emailIsOpened,
                                                       BOOL socialIsOpened,
                                                       BOOL calendarIsOpened,
                                                       BOOL antiLostIsOpened,
                                                       NSError *error);
/**
 *  获取久坐提醒信息
 *
 *  @param isOpen      开关状态
 *  @param internal    间隔时间
 *  @param startHour   开始小时
 *  @param startMinute 开始分钟
 *  @param endHour     结束小时
 *  @param endMinute   结束分钟
 *  @param period      周期
 *  @param steps       有效步数
 */
typedef void(^AppscommReadInactivityAlertInfoCallback)(BOOL isOpen,
                                                       NSUInteger internal,
                                                       NSUInteger startHour,
                                                       NSUInteger startMinute,
                                                       NSUInteger endHour,
                                                       NSUInteger endMinute,
                                                       NSUInteger period,
                                                       NSUInteger steps,
                                                       NSError *error);

/**
 *  获取设备状态
 *
 *  @param status 设备状态
 */
typedef void (^AppscommReadDeviceStatusCallback)(AppscommDeviceStatus status, NSError *error);

/**
 *  获取屏幕亮度
 *
 *  @param lightness 屏幕亮度
 */
typedef void (^AppscommReadLightnessCallback)(AppscommLightness lightness, NSError *error);

/**
 *  获取卡路里和距离
 *
 *  @param calories    步数
 *  @param distance 卡路里
 */
typedef void(^AppscommReadCaloriesAndDistanceGoalCallback)(NSUInteger calories,
                                                           NSUInteger distance,
                                                           NSError *error);

/**
 *  获取提醒
 *
 *  @param reminders AppscommReminder类型
 */
typedef void(^AppscommReadRemindersCallback)(NSArray *reminders, NSError *error);

#pragma mark - 数据类型
/**
 *  运动数据类型
 */
@interface AppscommSportData : NSObject

@property (nonatomic, assign) NSUInteger steps;     //步数
@property (nonatomic, assign) NSUInteger calories;  //卡路里
@property (nonatomic, assign) NSUInteger timeStamp; //时间戳

+ (AppscommSportData *)dataWithSteps:(NSUInteger)steps
                                 calories:(NSUInteger)calories
                                timeStamp:(NSUInteger)timeStamp;
@end



/**
 *  睡眠详细数据类型
 */
@interface AppscommSleepDetailData : NSObject

@property (nonatomic, assign) AppscommSleepType sleepType; //睡眠类型
@property (nonatomic, assign) NSUInteger timeStamp; //时间戳

+ (AppscommSleepDetailData *)dataWithType:(AppscommSleepType)sleepType timeStamp:(NSUInteger)timeStamp;

@end

@interface AppscommSleepTotalData : NSObject

@property (nonatomic, strong) NSArray *detailData;      //详细数据,AppscommSleepDetailData类型

@property (nonatomic, assign) NSUInteger quality;       //睡眠质量
@property (nonatomic, assign) NSUInteger sleepDuration; //睡眠时长
@property (nonatomic, assign) NSUInteger awakeDuration; //清醒时长
@property (nonatomic, assign) NSUInteger lightDuration; //浅睡时长
@property (nonatomic, assign) NSUInteger deepDuration;  //深睡时长
@property (nonatomic, assign) NSUInteger totalDuration; //总的时间
@property (nonatomic, assign) NSUInteger awakeCount;    //清醒次数
@property (nonatomic, assign) NSUInteger sleepDate;     //睡眠日期(有预设睡眠的设备需要)

@end

/**
 *  提醒
 */
@interface AppscommReminder : NSObject

+ (AppscommReminder *)reminderWithType:(AppscommReminderType)type
                                  hour:(NSUInteger)hour
                                minute:(NSUInteger)minute
                                period:(NSUInteger)period;

@property (nonatomic, assign) AppscommReminderType type;
@property (nonatomic, assign) NSUInteger period;
@property (nonatomic, assign) NSUInteger hour;
@property (nonatomic, assign) NSUInteger minute;

@end

