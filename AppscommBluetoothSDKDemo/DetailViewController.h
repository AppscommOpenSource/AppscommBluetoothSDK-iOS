//
//  DetailViewController.h
//  AppscommBluetoothSDKDemo
//
//  Created by zhangwen on 15/5/26.
//  Copyright (c) 2015年 Appscomm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@end
