//
//  TPBlueToothManager.m
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/8.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import "TPBlueToothManager.h"
#import "TPBlueToothService.h"

@implementation TPBlueToothManager


+ (instancetype)shareInstance {
    
    static TPBlueToothManager *sigle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sigle = [TPBlueToothManager new];
    });
    return sigle;
}

- (void)config
{
    [[TPBlueToothService shareInstance] start];
}

@end
