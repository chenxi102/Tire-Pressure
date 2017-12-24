//
//  TPTirePressureViewModel.h
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/10.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger){
    TPTemperature_normal ,
    TPTemperature_waring
}TPTemperatureType;

typedef NS_ENUM(NSInteger){
    TPTirePressure_normal ,
    TPTirePressure_waring
}TPTirePressureType;

typedef NS_ENUM(NSInteger){
    TPElectric_normal ,
    TPElectric_waring
}TPElectricType;

@interface TPTirePressureViewModel : NSObject

@end
