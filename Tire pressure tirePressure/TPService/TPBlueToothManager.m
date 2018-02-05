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

- (void)connectRes:(void(^)(BOOL))res
{
    [[TPBlueToothService shareInstance] start].connectRes = ^(BOOL success){
        if (success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self checkMachineWorkStateRes:res];
            });
            NSLog(@"机器连接成功");
        }else {
            [TPDataCenter shareInstance].tPMachineState = TPMachineState_destroy;
            if (res)  res(NO);
        }
    };
}

- (void)checkMachineWorkStateRes:(void(^)(BOOL))res  {
    Byte body[] = {0xAA, 0x41,0xA1, 0x07, 0x11, 0x00, 0xA4};
    NSMutableData * mutData = [NSMutableData dataWithBytes:body length:sizeof(body)];
    [[TPBlueToothService shareInstance] writeData:mutData res:^(NSData *data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"<" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@">" withString:@""];
        if ([str.uppercaseString isEqualToString:@"AAA141071100A4"]) {
            [TPDataCenter shareInstance].tPMachineState = TPMachineState_normal;
            NSLog(@"机器握手成功");
            if (res) res(YES);
        }
        else {
            if (res) res(NO);
            [TPDataCenter shareInstance].tPMachineState = TPMachineState_destroy;
        }
    }];
}

- (void)queryTirePressureDataRes:(void(^)(BOOL))res
{
    unsigned char* dataBytes = getTPMSBytes();
//    Byte body[] = {0xAA, 0x41,0xA1, 0x07, 0x61, 0x00, 0xF4};
    NSMutableData * mutData = [NSMutableData dataWithBytes:dataBytes length:sizeof(dataBytes)-1];
    [[TPBlueToothService shareInstance] writeData:mutData res:^(NSData *data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"<" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@">" withString:@""];
        
        NSData * __data = [NSData dataWithHexString:str];
        const void * _dataBytes = [__data bytes];
        resPacket * packet = parseBytes(getTPMS, (unsigned char * )_dataBytes, (int)__data.length);
        if (NULL != packet && packet->result == success) {
            for (int i =0; i< 4; i++) {
                if (packet->tires[i].tire == RightFront) {
                    [TPDataCenter shareInstance].rightFronttirepressure = packet->tires[i].press;
                    [TPDataCenter shareInstance].rightFronttemprature = packet->tires[i].temp;
                    [TPDataCenter shareInstance].rightFrontTireState = packet->tires[i].tireState;
                }else if (packet->tires[i].tire == RightBack) {
                    [TPDataCenter shareInstance].rightBacktirepressure = packet->tires[i].press;
                    [TPDataCenter shareInstance].rightBacktemprature = packet->tires[i].temp;
                    [TPDataCenter shareInstance].rightBackTireState = packet->tires[i].tireState;
                }else if (packet->tires[i].tire == LeftFront) {
                    [TPDataCenter shareInstance].leftFronttirepressure = packet->tires[i].press;
                    [TPDataCenter shareInstance].leftFronttemprature = packet->tires[i].temp;
                    [TPDataCenter shareInstance].leftFrontTireState = packet->tires[i].tireState;
                }else if (packet->tires[i].tire == LeftBack) {
                    [TPDataCenter shareInstance].leftBacktirepressure = packet->tires[i].press;
                    [TPDataCenter shareInstance].leftBacktemprature = packet->tires[i].temp;
                    [TPDataCenter shareInstance].leftBackTireState = packet->tires[i].tireState;
                }
            }
            if(res)res(YES);
        }else if(res)res(NO);
    }];
}

// 报警参数设定
- (void)setAlarmTirePressure:(AlarmType)alarm value:(int)value Res:(void(^)(BOOL))res {
    
    unsigned char* dataBytes = setAlarmParamBytes(alarm, value);
    NSMutableData * mutData = [NSMutableData dataWithBytes:dataBytes length:sizeof(dataBytes)-1];
    [[TPBlueToothService shareInstance] writeData:mutData res:^(NSData *data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"<" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@">" withString:@""];
        
        NSData * __data = [NSData dataWithHexString:str];
        const void * _dataBytes = [__data bytes];
        resPacket * packet = parseBytes(setAlarm, (unsigned char * )_dataBytes, (int)__data.length);
        
        if ([str.uppercaseString isEqualToString:@"AAA141071100A4"]) {
            [TPDataCenter shareInstance].tPMachineState = TPMachineState_normal;
            NSLog(@"机器握手成功");
            if (res) res(YES);
        }
        else {
            if (res) res(NO);
            [TPDataCenter shareInstance].tPMachineState = TPMachineState_destroy;
        }
    }];
}

// 报警参数获取
- (void)getAlarmTirePressureRes:(void(^)(BOOL))res {
    
    unsigned char* dataBytes = getAlarmBytes();
    //    Byte body[] = {0xAA, 0x41,0xA1, 0x07, 0x11, 0x00, 0xA4};
    NSMutableData * mutData = [NSMutableData dataWithBytes:dataBytes length:sizeof(dataBytes)-1];
    [[TPBlueToothService shareInstance] writeData:mutData res:^(NSData *data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"<" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@">" withString:@""];
        
        NSData * __data = [NSData dataWithHexString:str];
        const void * _dataBytes = [__data bytes];
        resPacket * packet = parseBytes(getAlarm, (unsigned char * )_dataBytes, (int)__data.length);
        if (NULL != packet && packet->result == success) {
            
            [[TPDataCenter shareInstance] setWarningTemprature:packet->hTemp];
            [[TPDataCenter shareInstance] setWarningTopTirepressure:packet->hPress];
            [[TPDataCenter shareInstance] setWarningDownTirepressure:packet->lPress];
            if (res) res(YES);
        }else
            if (res) res(NO);
    }];
}


// 匹配
- (void)startTPMSMatch:(Tire)tire Res:(void(^)(BOOL))res {
    
    unsigned char* dataBytes = startTPMSMatchIDBytes(tire);
    NSMutableData * mutData = [NSMutableData dataWithBytes:dataBytes length:sizeof(dataBytes)-1];
    [[TPBlueToothService shareInstance] writeData:mutData res:^(NSData *data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"<" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@">" withString:@""];
        
        NSData * __data = [NSData dataWithHexString:str];
        const void * _dataBytes = [__data bytes];
        resPacket * packet = parseBytes(getAlarm, (unsigned char * )_dataBytes, (int)__data.length);
        if (NULL != packet && packet->result == success) {
            
            [[TPDataCenter shareInstance] setWarningTemprature:packet->hTemp];
            [[TPDataCenter shareInstance] setWarningTopTirepressure:packet->hPress];
            [[TPDataCenter shareInstance] setWarningDownTirepressure:packet->lPress];
            if (res) res(YES);
        }else
            if (res) res(NO);
    }];
}

// 调胎
- (void)swapTPMS:(Tire)tire other:(Tire)tire1 Res:(void(^)(BOOL))res {
    unsigned char* dataBytes = startTPMSMatchIDBytes(tire);
    NSMutableData * mutData = [NSMutableData dataWithBytes:dataBytes length:sizeof(dataBytes)-1];
    [[TPBlueToothService shareInstance] writeData:mutData res:^(NSData *data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"<" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@">" withString:@""];
        
        NSData * __data = [NSData dataWithHexString:str];
        const void * _dataBytes = [__data bytes];
        resPacket * packet = parseBytes(getAlarm, (unsigned char * )_dataBytes, (int)__data.length);
        if (NULL != packet && packet->result == success) {
            
            [[TPDataCenter shareInstance] setWarningTemprature:packet->hTemp];
            [[TPDataCenter shareInstance] setWarningTopTirepressure:packet->hPress];
            [[TPDataCenter shareInstance] setWarningDownTirepressure:packet->lPress];
            if (res) res(YES);
        }else
            if (res) res(NO);
    }];
}

@end
