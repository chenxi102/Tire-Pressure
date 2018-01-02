//
//  TPDataCenter.m
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/27.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import "TPDataCenter.h"

@implementation TPDataCenter

+ (instancetype)shareInstance {
    static TPDataCenter * center ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!center) {
            center = [TPDataCenter new];
            center.tirePressureDataType = TPTirePressureData_Bar;
            center.temPeratureDataType = TPTemperatureData_Centigrade;
        }
    });
    return center;
}

- (void)setTemPeratureDataType:(TPTemPeratureDataType)temPeratureDataType {
    [[NSUserDefaults standardUserDefaults] setInteger:temPeratureDataType forKey:TPTemperatureTypeKey];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}

- (void)setTirePressureDataType:(TPTirePressureDataType)tirePressureDataType {
    [[NSUserDefaults standardUserDefaults] setInteger:tirePressureDataType forKey:TPTirePressureTypeKey];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}

- (void)setWarningElectric:(NSInteger)warningElectric {
    [[NSUserDefaults standardUserDefaults] setInteger:warningElectric forKey:TPWarningElectricKey];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}

- (void)setWarningTemprature:(NSInteger)warningTemprature {
    NSInteger temp  = [self convertTemprature:warningTemprature outPutType:TPTemperatureData_Centigrade];
    [[NSUserDefaults standardUserDefaults] setInteger:temp forKey:TPWarningTempratureKey];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}

- (void)setWarningTopTirepressure:(NSInteger)warningTopTirepressure {
    NSInteger temp  = [self convertTirePressure:warningTopTirepressure outPutType:TPTirePressureData_Bar];
    [[NSUserDefaults standardUserDefaults] setInteger:temp forKey:TPWarningTopTirepressureKey];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}

- (void)setWarningDownTirepressure:(NSInteger)warningDownTirepressure {
    NSInteger temp  = [self convertTirePressure:warningDownTirepressure outPutType:TPTirePressureData_Bar];
    [[NSUserDefaults standardUserDefaults] setInteger:temp forKey:TPWarningDownTirepressureKey];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}

- (TPTemPeratureDataType)temPeratureDataType {
    NSInteger interger = [[NSUserDefaults standardUserDefaults] integerForKey:TPTemperatureTypeKey];
    return interger;
}

- (TPTirePressureDataType)tirePressureDataType {
    NSInteger interger = [[NSUserDefaults standardUserDefaults] integerForKey:TPTirePressureTypeKey];
    return interger;
}

- (NSInteger)warningElectric {
    NSInteger interger = [[NSUserDefaults standardUserDefaults] integerForKey:TPWarningElectricKey];
    return interger;
}

- (NSInteger)warningTemprature {
    NSInteger interger = [[NSUserDefaults standardUserDefaults] integerForKey:TPWarningTempratureKey];
    return interger;
}

- (NSInteger)warningTopTirepressure {
    NSInteger interger = [[NSUserDefaults standardUserDefaults] integerForKey:TPWarningTopTirepressureKey];
    return interger;
}

- (NSInteger)warningDownTirepressure {
    NSInteger interger = [[NSUserDefaults standardUserDefaults] integerForKey:TPWarningDownTirepressureKey];
    return interger;
}

- (float)convertEletric:(float)data   {
    return data;
}

- (float)convertTirePressure:(float)data  outPutType:(TPTirePressureDataType)type;{
    float TirePressure ;
    switch (self.tirePressureDataType) {
        case TPTirePressureData_Bar:
        {
            if (type == TPTirePressureData_Bar || type == TPTirePressureData_Kg) {
                TirePressure = data;
            }else if (type == TPTirePressureData_Kpa) {
                TirePressure = 100*data;
            }else if (type == TPTirePressureData_Psi) {
                TirePressure = 14.5*data;
            }else {
                TirePressure = -1;
            }
        }
            break;
        case TPTirePressureData_Kg:
        {
            if (type == TPTirePressureData_Bar || type == TPTirePressureData_Kg) {
                TirePressure = data;
            }else if (type == TPTirePressureData_Kpa) {
                TirePressure = 100*data;
            }else if (type == TPTirePressureData_Psi) {
                TirePressure = 14.5*data;
            }else {
                TirePressure = -1;
            }
        }
            break;
        case TPTirePressureData_Kpa:
        {
            if (type == TPTirePressureData_Bar || type == TPTirePressureData_Kg) {
                TirePressure = data/100.0;
            }else if (type == TPTirePressureData_Kpa) {
                TirePressure = data;
            }else if (type == TPTirePressureData_Psi) {
                TirePressure = data/100.0 *14.5;
            }else {
                TirePressure = -1;
            }
        }
            break;
        case TPTirePressureData_Psi:
        {
            if (type == TPTirePressureData_Bar || type == TPTirePressureData_Kg) {
                TirePressure = data/14.5;
            }else if (type == TPTirePressureData_Kpa) {
                TirePressure = data/14.5*100;
            }else if (type == TPTirePressureData_Psi) {
                TirePressure = data;
            }else {
                TirePressure = -1;
            }
        }
            break;
        default:
            break;
    }
    
    return TirePressure;
}

- (float)convertTemprature:(float)data outPutType:(TPTemPeratureDataType)type {
    float Temprature ;
    switch (self.temPeratureDataType) {
        case TPTemperatureData_Centigrade:
        {
            if (type == TPTemperatureData_Centigrade) {
                Temprature = data;
            }else {
                Temprature = data*1.8+32;
            }
        }
            break;
        case TPTemperatureData_Fahrenheit:
        {
            if (type == TPTemperatureData_Centigrade) {
                Temprature = (data-32)/1.8;
            }else {
                Temprature = data ;
            }
        }
            break;
        default:
            break;
    }
    return Temprature;
}


@end
