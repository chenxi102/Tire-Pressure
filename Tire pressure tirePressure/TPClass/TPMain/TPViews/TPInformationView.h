//
//  TPInformationView.h
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/10.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPTirePressureViewModel.h"
#include "tire_pressure.h"
@interface TPInformationView : UIView

@property (nonatomic, strong) UIImageView * electricImgV;       // 电量图
@property (nonatomic, strong) UILabel * tirepressureNumLab;     // 胎压值
@property (nonatomic, strong) UILabel * tirepressureUnitLab;    // 胎压单位
@property (nonatomic, strong) UILabel * tempratureNumLab;       // 温度值
@property (nonatomic, strong) UILabel * tempratureUnitLab;      // 温度单位

@property (nonatomic, assign) Tire tire;
@property (nonatomic, assign) TireState tireState;
@property (nonatomic, assign) int electric;
@property (nonatomic, assign) int tirepressure;
@property (nonatomic, assign) int temprature;

- (void)refreshStatesWithDisInit:(BOOL)abool;

@end
