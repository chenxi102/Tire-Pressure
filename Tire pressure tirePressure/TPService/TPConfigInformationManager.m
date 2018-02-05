
//
//  TPConfigInformationManager.m
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/16.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import "TPConfigInformationManager.h"

@implementation TPConfigInformationManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static TPConfigInformationManager * single;
    dispatch_once(&onceToken, ^{
        single = [TPConfigInformationManager new];
    });
    return single;
}

@end


@implementation TPConfigInfo


@end
