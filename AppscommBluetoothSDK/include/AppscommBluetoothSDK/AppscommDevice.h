/***************************************************************************************************
 *Copyright (c) 2015 Appscomm Inc. All rights reserved.
 *FileName:  AppscommDevice.h
 *Author:  zhangwen
 *Date:  2015/05/19
 *Description: 设备类
 *Others:
 **************************************************************************************************/
#import <Foundation/Foundation.h>

@class CBPeripheral;

typedef NS_ENUM(NSInteger, AppscommDeviceConnectState) {
    AppscommDeviceDisconnected = 0,
    AppscommDeviceConnecting,
    AppscommDeviceConnected,
};

@interface AppscommDevice : NSObject

/**
 *  设备名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  广播名称
 */
@property (nonatomic, copy) NSString *localName;

/**
 *  UUID，唯一标识符
 */
@property (nonatomic, copy) NSString *uuid;

/**
 *  蓝牙信号强度
 */
@property (nonatomic, assign) NSInteger rssi;

/**
 *  连接状态
 */
@property (nonatomic, assign) AppscommDeviceConnectState  state;

@property (nonatomic, strong) CBPeripheral *peripheral;

+ (AppscommDevice *)deviceWithCBPeripheral:(CBPeripheral *)peripheral;
+ (AppscommDevice *)deviceWithCBPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData;
- (void)updateWithCBPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData;
@end
