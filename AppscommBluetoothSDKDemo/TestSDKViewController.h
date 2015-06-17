//
//  TestSDKViewController.h
//  AppscommBluetoothSDKDemo
//
//  Created by zhangwen on 15/5/15.
//  Copyright (c) 2015年 Appscomm. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ASYNC_MAIN_QUEUE_START \
dispatch_async(dispatch_get_main_queue(), ^(){ \
if (error) { \
    [self showAlertWithString:[NSString stringWithFormat:@"%@", error]]; \
}else{

#define ASYNC_MAIN_QUEUE_END \
    } \
});
@interface TestSDKViewController : UITableViewController


@end

