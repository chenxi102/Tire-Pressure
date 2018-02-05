//
//  TPBlueToothManager.h
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/8.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPBlueToothService.h"

@interface TPBlueToothManager : NSObject


+ (instancetype)shareInstance ;
- (void)connectRes:(void(^)(BOOL))res;

// 检测机器状态
- (void)checkMachineWorkStateRes:(void(^)(BOOL))res;

// 获取胎压温度状态等信息
- (void)queryTirePressureDataRes:(void(^)(BOOL))res;

// 报警参数设定
- (void)setAlarmTirePressureRes:(void(^)(BOOL))res;

// 报警参数获取
- (void)getAlarmTirePressureRes:(void(^)(BOOL))res ;

// 报警参数设定
- (void)setAlarmTirePressure:(AlarmType)alarm value:(int)value Res:(void(^)(BOOL))res ;

// 匹配
- (void)startTPMSMatch:(Tire)tire Res:(void(^)(BOOL))res ;

// 调胎
- (void)swapTPMS:(Tire)tire other:(Tire)tire1 Res:(void(^)(BOOL))res ;
@end
