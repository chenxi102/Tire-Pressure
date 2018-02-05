//
//  TPInformationView.m
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/10.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import "TPInformationView.h"


@implementation TPInformationView
{
    NSTimer * _timer;
    BOOL _timerGoing;
    BOOL flashFlag ;
}

- (void)refreshStatesWithDisInit:(BOOL)abool{
    
    if (!abool) {
        _timerGoing = NO;
        [self startOrStopFlashTimer:NO];
        self.electricImgV.image = [UIImage imageNamed:@""];
        self.tempratureNumLab.text = @"---";
        self.tirepressureNumLab.text = @"---";
        self.electricImgV.hidden = YES;
        self.tempratureNumLab.hidden = self.tempratureUnitLab.hidden = self.tirepressureNumLab.hidden = self.tirepressureUnitLab.hidden = NO;
        self.tirepressureNumLab.textColor = [UIColor whiteColor];
        self.tirepressureUnitLab.textColor = [UIColor lightGrayColor];
        self.tempratureNumLab.textColor = [UIColor yellowColor];
        self.tempratureUnitLab.textColor = [UIColor yellowColor];
        return;
    }else {
        if (!_timerGoing) {
            _timerGoing = YES;
            [self startOrStopFlashTimer:YES];
            self.electricImgV.image = [UIImage imageNamed:@""];
            self.tempratureNumLab.text = @"---";
            self.tirepressureNumLab.text = @"---";
            self.electricImgV.hidden = NO;
            self.tempratureNumLab.hidden = self.tempratureUnitLab.hidden = self.tirepressureNumLab.hidden = self.tirepressureUnitLab.hidden = NO;
        }
    }
    
    if (self.electric> 95) {
        self.electricImgV.image = [UIImage imageNamed:@"满格"];
    }
    else if (self.electric> 72.5  && self.electric <= 95){
        self.electricImgV.image = [UIImage imageNamed:@"四格电"];
    }
    else if (self.electric> 50  && self.electric <= 72.5) {
        self.electricImgV.image = [UIImage imageNamed:@"三格电"];
    }
    else if (self.electric> 27.5  && self.electric <= 50) {
        self.electricImgV.image = [UIImage imageNamed:@"两格电"];
    }
    else if (self.electric> 5  && self.electric <= 27.5) {
        self.electricImgV.image = [UIImage imageNamed:@"一格电"];
    }else {
        self.electricImgV.image = [UIImage imageNamed:@"低电"];
    }
    
    if ([[TPDataCenter shareInstance] temPeratureDataType] == TPTemperatureData_Centigrade) {
        self.tempratureUnitLab.text = @"℃";
        self.tempratureNumLab.text = [NSString stringWithFormat:@"%d",self.temprature];
    } else {
        int temp = [[TPDataCenter shareInstance] convertTemprature:self.temprature inPutType:TPTemperatureData_Centigrade outPutType:TPTemperatureData_Fahrenheit];
        self.tempratureUnitLab.text = @"℉";
        self.tempratureNumLab.text = [NSString stringWithFormat:@"%d", temp];
    }
    
    if ([[TPDataCenter shareInstance] tirePressureDataType] == TPTirePressureData_Bar) {
        self.tirepressureUnitLab.text = @"Bar";
        self.tirepressureNumLab.text = [NSString stringWithFormat:@"%d", self.tirepressure];
    } else if ([[TPDataCenter shareInstance] tirePressureDataType] == TPTirePressureData_Kg) {
        self.tirepressureUnitLab.text = @"Kg/cm²";
        self.tirepressureNumLab.text = [NSString stringWithFormat:@"%d", self.tirepressure];
    }
    else if ([[TPDataCenter shareInstance] tirePressureDataType] == TPTirePressureData_Psi) {
        int temp = [[TPDataCenter shareInstance] convertTirePressure:self.tirepressure inPutType:TPTirePressureData_Bar outPutType:TPTirePressureData_Psi];
        self.tirepressureUnitLab.text = @"PSI";
        self.tirepressureNumLab.text = [NSString stringWithFormat:@"%d", temp];
    }else {
        int temp = [[TPDataCenter shareInstance] convertTirePressure:self.tirepressure inPutType:TPTirePressureData_Bar outPutType:TPTirePressureData_Kpa];
        self.tirepressureUnitLab.text = @"kPa";
        self.tirepressureNumLab.text = [NSString stringWithFormat:@"%d", temp];
    }
}

- (void)startOrStopFlashTimer:(BOOL)abool {
    if (_timer&&[_timer isValid]) {
        if (abool) {
            [_timer setFireDate:[NSDate distantPast]];
        }else{
            [_timer setFireDate:[NSDate distantFuture]];
        }
    } else {
        _timer = nil;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(flash:) userInfo:nil repeats:YES];
        if (abool) {
            [_timer setFireDate:[NSDate distantPast]];
        }else{
            [_timer setFireDate:[NSDate distantFuture]];
        }
    }
}


- (void)flash:(NSTimer *)timer {
    
    flashFlag = !flashFlag;
    
    // 胎压超过上限的闪烁
    if (self.tirepressure>=[[TPDataCenter shareInstance] warningTopTirepressure]) {
        self.tirepressureNumLab.hidden = !flashFlag;
        self.tirepressureUnitLab.hidden = !flashFlag;
        self.tirepressureUnitLab.textColor = [UIColor redColor];
        self.tirepressureNumLab.textColor = [UIColor redColor];
    }
    // 胎压小于下限的闪烁
    else if(self.tirepressure<=[[TPDataCenter shareInstance] warningDownTirepressure]) {
        self.tirepressureNumLab.hidden = !flashFlag;
        self.tirepressureUnitLab.hidden = !flashFlag;
        self.tirepressureUnitLab.textColor = [UIColor redColor];
        self.tirepressureNumLab.textColor = [UIColor redColor];
    }
    // 胎压正常
    else {
        self.tirepressureNumLab.hidden = self.tirepressureUnitLab.hidden = NO;
        self.tirepressureNumLab.textColor = [UIColor whiteColor];
        self.tirepressureUnitLab.textColor = [UIColor lightGrayColor];
    }
    
    // 高温闪烁
    if (self.temprature>[[TPDataCenter shareInstance] warningTemprature]) {
        self.tempratureNumLab.hidden = !flashFlag;
        self.tempratureUnitLab.hidden = !flashFlag;
        self.tempratureNumLab.textColor = [UIColor redColor];
        self.tempratureUnitLab.textColor = [UIColor redColor];
    }else {
        self.tempratureNumLab.hidden = self.tempratureUnitLab.hidden = NO;
        self.tempratureNumLab.textColor = [UIColor yellowColor];
        self.tempratureUnitLab.textColor = [UIColor yellowColor];
    }
    
    // 低电闪烁
    if (self.electric < 10) {
        self.electricImgV.hidden = !flashFlag;
    } else {
        self.electricImgV.hidden = NO;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.contents = (id)([UIImage imageNamed:@"数据框"].CGImage);
        self.electric = 100 ;
        self.temprature = 0 ;
        self.tirepressure = 0 ;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(flash:) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantFuture]];
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
    _tirepressureNumLab.text = @"---";
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
        make.size.equalTo(@(CGSizeMake(60, 16)));
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
    _tempratureNumLab.text = @"---";
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
    [self refreshStatesWithDisInit:NO];
}

@end
