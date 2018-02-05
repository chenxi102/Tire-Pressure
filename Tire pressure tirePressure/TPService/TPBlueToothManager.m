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
    [[TPBlueToothService shareInstance] start].connectRes = ^(BOOL success){
        if (success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self checkMachineWorkState];
            });
        }
    };
}

- (void)checkMachineWorkState  {
    Byte body[] = {0xAA, 0x41,0xA1, 0x07, 0x11, 0x00, 0xA4};
    NSMutableData * mutData = [NSMutableData dataWithBytes:body length:sizeof(body)];
    [[TPBlueToothService shareInstance] writeData:mutData res:^(NSData *data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"<" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@">" withString:@""];
        if ([str.uppercaseString isEqualToString:@"AAA141071100A4"]) {
            [TPDataCenter shareInstance].tPMachineState = TPMachineState_normal;
        }
    }];
}

- (void)queryTirePressureDataRes:(void(^)(NSData *))res {
    
}

@end
