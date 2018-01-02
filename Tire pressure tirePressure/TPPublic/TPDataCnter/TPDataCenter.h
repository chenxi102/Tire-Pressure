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


@interface TPDataCenter : NSObject


@property (nonatomic, assign) NSInteger leftFrontelectric;
@property (nonatomic, assign) NSInteger leftBackelectric;
@property (nonatomic, assign) NSInteger rightFrontelectric;
@property (nonatomic, assign) NSInteger rightBackelectric;
@property (nonatomic, assign) NSInteger warningElectric;


@property (nonatomic, assign) NSInteger leftFronttirepressure;
@property (nonatomic, assign) NSInteger leftBacktirepressure;
@property (nonatomic, assign) NSInteger rightFronttirepressure;
@property (nonatomic, assign) NSInteger rightBacktirepressure;
@property (nonatomic, assign) NSInteger warningTopTirepressure;
@property (nonatomic, assign) NSInteger warningDownTirepressure;

@property (nonatomic, assign) NSInteger leftFronttemprature;
@property (nonatomic, assign) NSInteger leftBacktemprature;
@property (nonatomic, assign) NSInteger rightFronttemprature;
@property (nonatomic, assign) NSInteger rightBacktemprature;
@property (nonatomic, assign) NSInteger warningTemprature;


@property (nonatomic, assign) TPTirePressureDataType tirePressureDataType;
@property (nonatomic, assign) TPTemPeratureDataType temPeratureDataType;


+ (instancetype)shareInstance ;

- (float)convertEletric:(float)data;
- (float)convertTirePressure:(float)data  outPutType:(TPTirePressureDataType)type;
- (float)convertTemprature:(float)data  outPutType:(TPTemPeratureDataType)type;

@end
