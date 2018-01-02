//
//  TPTirePressureViewModel.h
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/10.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger){
    TPTemperature_deInit ,
    TPTemperature_normal ,
    TPTemperature_waring
}TPTemperatureType;

typedef NS_ENUM(NSInteger){
    TPTirePressure_deInit ,
    TPTirePressure_normal ,
    TPTirePressure_waring
}TPTirePressureType;

typedef NS_ENUM(NSInteger){
    TPElectric_deInit ,
    TPElectric_normal ,
    TPElectric_waring
}TPElectricType;

// 1bar=1kgf/cm2=100kpa=14.5psi
@interface TPTirePressureViewModel : NSObject

@end
