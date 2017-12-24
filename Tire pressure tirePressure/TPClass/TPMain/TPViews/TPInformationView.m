//
//  TPInformationView.m
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/10.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import "TPInformationView.h"

@implementation TPInformationView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.contents = (id)([UIImage imageNamed:@"数据框"].CGImage);
        [self setup];
    }
    return self;
}

- (void)setup {
    @weak(self);
    _electricImgV = [UIImageView new];
    [_electricImgV setImage:[UIImage imageNamed:@"满格"]];
    [self addSubview: _electricImgV];
    [_electricImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(@(CGSizeMake(45, 18)));
        make.top.equalTo(@(20));
        make.right.equalTo(@(-15));
    }];
    
    _tirepressureNumLab = [UILabel new];
    _tirepressureNumLab.text = @"38";
    _tirepressureNumLab.font = [UIFont boldSystemFontOfSize:40];
    _tirepressureNumLab.textColor = [UIColor redColor];
    _tirepressureNumLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tirepressureNumLab];
    [_tirepressureNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strong(self);
        make.centerX.equalTo(@0);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@50);
        make.top.equalTo(self.electricImgV.mas_bottom).offset(8);
    }];
    
    _tirepressureUnitLab = [UILabel new];
    _tirepressureUnitLab.text = @"PSI";
    _tirepressureUnitLab.font = [UIFont boldSystemFontOfSize:15];
    _tirepressureUnitLab.textColor = [UIColor redColor];
    _tirepressureUnitLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_tirepressureUnitLab];
    [_tirepressureUnitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.size.equalTo(@(CGSizeMake(45, 16)));
        make.top.equalTo(@30);
    }];
    
    UILabel * line = [UILabel new];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        @strong(self)
        make.left.equalTo(@18);
        make.right.equalTo(@-18);
        make.height.equalTo(@3);
        make.top.equalTo(self.tirepressureNumLab.mas_bottom).offset(5);
    }];
    
    _tempratureNumLab = [UILabel new];
    _tempratureNumLab.text = @"25";
    _tempratureNumLab.font = [UIFont boldSystemFontOfSize:35];
    _tempratureNumLab.textColor = [UIColor yellowColor];
    _tempratureNumLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tempratureNumLab];
    [_tempratureNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strong(self);
        make.centerX.equalTo(@0).offset(10);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@50);
        make.bottom.equalTo(@-20);
    }];
    
    _tempratureUnitLab = [UILabel new];
    _tempratureUnitLab.text = @"℃";
    _tempratureUnitLab.font = [UIFont boldSystemFontOfSize:15];
    _tempratureUnitLab.textColor = [UIColor yellowColor];
    _tempratureUnitLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_tempratureUnitLab];
    [_tempratureUnitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.size.equalTo(@(CGSizeMake(45, 16)));
        make.top.equalTo(self.tempratureNumLab.mas_top).offset(10);
    }];
    ;
}

@end
