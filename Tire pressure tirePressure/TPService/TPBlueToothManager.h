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
- (void)config ;

// 检测机器状态
- (void)checkMachineWorkState ;

- (void)queryTirePressureDataRes:(void(^)(NSData *))res;

@end
