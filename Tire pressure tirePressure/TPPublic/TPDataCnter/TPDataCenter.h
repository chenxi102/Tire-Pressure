//
//  TPDataCenter.h
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/27.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import <Foundation/Foundation.h>
#define WARNING_TIREPRESSURE     28     // bar
#define WARNING_TEMPERATE        26     // 摄氏度

typedef NS_ENUM(NSInteger){
    TPTemperatureData_Centigrade ,  //摄氏度
    TPTemperatureData_Fahrenheit    //华氏度
}TPTemPeratureDataType;


typedef NS_ENUM(NSInteger){
    TPTirePressureData_Bar ,
    TPTirePressureData_Kg  ,
    TPTirePressureData_Kpa ,
    TPTirePressureData_Psi
}TPTirePressureDataType;

typedef NS_ENUM(NSInteger){
    TPMachineState_offline ,  //未获取
    TPMachineState_normal ,   //正常态
    TPMachineState_destroy    //宕机中
}TPMachineState;

@interface TPDataCenter : NSObject

// 机器状态
@property (nonatomic, assign) TPMachineState tPMachineState;


// 机器数据
@property (nonatomic, assign) NSInteger leftFrontelectric;
@property (nonatomic, assign) NSInteger leftBackelectric;
@property (nonatomic, assign) NSInteger rightFrontelectric;
@property (nonatomic, assign) NSInteger rightBackelectric;

@property (nonatomic, assign) NSInteger leftFronttirepressure;
@property (nonatomic, assign) NSInteger leftBacktirepressure;
@property (nonatomic, assign) NSInteger rightFronttirepressure;
@property (nonatomic, assign) NSInteger rightBacktirepressure;

@property (nonatomic, assign) NSInteger leftFronttemprature;
@property (nonatomic, assign) NSInteger leftBacktemprature;
@property (nonatomic, assign) NSInteger rightFronttemprature;
@property (nonatomic, assign) NSInteger rightBacktemprature;


// 设置的缓存数据
@property (nonatomic, assign) NSInteger warningElectric;
@property (nonatomic, assign) NSInteger warningTopTirepressure;
@property (nonatomic, assign) NSInteger warningDownTirepressure;
@property (nonatomic, assign) NSInteger warningTemprature;

@property (nonatomic, assign) TPTirePressureDataType tirePressureDataType;
@property (nonatomic, assign) TPTemPeratureDataType temPeratureDataType;

@property (nonatomic, assign) BOOL dataLock;


+ (instancetype)shareInstance ;

- (float)convertEletric:(float)data;
- (float)convertTirePressure:(float)data inPutType:(TPTirePressureDataType)inPutType outPutType:(TPTirePressureDataType)type;
- (float)convertTemprature:(float)data inPutType:(TPTemPeratureDataType)inPutType outPutType:(TPTemPeratureDataType)type;
- (NSString *)tempString;
- (NSString *)tirePressureString;
@end
