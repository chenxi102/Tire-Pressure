//
//  TPInformationView.h
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/10.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPInformationView : UIView

@property (nonatomic, strong) UIImageView * electricImgV;       // 电量图
@property (nonatomic, strong) UILabel * tirepressureNumLab;     // 胎压值
@property (nonatomic, strong) UILabel * tirepressureUnitLab;    // 胎压单位
@property (nonatomic, strong) UILabel * tempratureNumLab;       // 温度值
@property (nonatomic, strong) UILabel * tempratureUnitLab;      // 温度单位


@end
