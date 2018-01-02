//
//  TPSettingViewController.m
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/11.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import "TPSettingViewController.h"

@interface TPSettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pressureUnitLab;
@property (weak, nonatomic) IBOutlet UIButton *psi;
@property (weak, nonatomic) IBOutlet UIButton *bar;
@property (weak, nonatomic) IBOutlet UIButton *kgcm;
@property (weak, nonatomic) IBOutlet UIButton *kPa;

@property (weak, nonatomic) IBOutlet UILabel *topWarningLabTip;
@property (weak, nonatomic) IBOutlet UILabel *topWarningNumLab;
@property (weak, nonatomic) IBOutlet UISlider *topWarningSlider;

@property (weak, nonatomic) IBOutlet UILabel *bottomWarningLabTip;
@property (weak, nonatomic) IBOutlet UILabel *bottomWarningNumLab;
@property (weak, nonatomic) IBOutlet UISlider *bottomWarningSlider;

@property (weak, nonatomic) IBOutlet UILabel *teperatureUnitLab;
@property (weak, nonatomic) IBOutlet UIButton *sheshidu;
@property (weak, nonatomic) IBOutlet UIButton *huashidu;

@property (weak, nonatomic) IBOutlet UILabel *teperatureWarningLabTip;
@property (weak, nonatomic) IBOutlet UILabel *teperatureNumLab;
@property (weak, nonatomic) IBOutlet UISlider *teperatureSlider;


@property (weak, nonatomic) IBOutlet UIButton *tire;
@property (weak, nonatomic) IBOutlet UIButton *version;

@end

@implementation TPSettingViewController
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blackColor];
    self.view.layer.contents = (id)[UIImage imageNamed:@"设定背景"].CGImage;
    [self initData];
    [self languageChanged];
}

- (void)initData
{
    switch ([[TPDataCenter shareInstance] tirePressureDataType]) {
        case TPTirePressureData_Bar:
        {
            self.bar.selected = YES;
            self.kgcm.selected = self.psi.selected = self.kPa.selected = NO;
            self.topWarningSlider.value = [[TPDataCenter shareInstance] warningTopTirepressure];
            self.bottomWarningSlider.value = [[TPDataCenter shareInstance] warningDownTirepressure];
            self.topWarningNumLab.text = [NSString stringWithFormat:@"%d bar", (int)self.topWarningSlider.value];
            self.bottomWarningNumLab.text = [NSString stringWithFormat:@"%d bar", (int)self.bottomWarningSlider.value];
        }
            break;
        case TPTirePressureData_Kg:
        {
            self.kgcm.selected = YES;
            self.bar.selected = self.psi.selected = self.kPa.selected = NO;
            self.topWarningSlider.value = [[TPDataCenter shareInstance] warningTopTirepressure];
            self.bottomWarningSlider.value = [[TPDataCenter shareInstance] warningDownTirepressure];
            self.topWarningNumLab.text = [NSString stringWithFormat:@"%d kg/cm²", (int)self.topWarningSlider.value];
            self.bottomWarningNumLab.text = [NSString stringWithFormat:@"%d kg/cm²", (int)self.bottomWarningSlider.value];
        }
            break;
        case TPTirePressureData_Kpa:
        {
            self.kPa.selected = YES;
            self.bar.selected = self.psi.selected = self.kgcm.selected = NO;
            self.topWarningSlider.value = [[TPDataCenter shareInstance] convertTirePressure:[[TPDataCenter shareInstance] warningTopTirepressure] outPutType:TPTirePressureData_Kpa];
            self.bottomWarningSlider.value = [[TPDataCenter shareInstance] convertTirePressure:[[TPDataCenter shareInstance] warningDownTirepressure] outPutType:TPTirePressureData_Kpa];
            self.topWarningNumLab.text = [NSString stringWithFormat:@"%d kPa", (int)self.topWarningSlider.value];
            self.bottomWarningNumLab.text = [NSString stringWithFormat:@"%d kPa", (int)self.bottomWarningSlider.value];
        }
            break;
        case TPTirePressureData_Psi:
        {
            self.psi.selected = YES;
            self.bar.selected = self.kPa.selected = self.kgcm.selected = NO;
            self.topWarningSlider.value = [[TPDataCenter shareInstance] convertTirePressure:[[TPDataCenter shareInstance] warningTopTirepressure] outPutType:TPTirePressureData_Psi];
            self.bottomWarningSlider.value = [[TPDataCenter shareInstance] convertTirePressure:[[TPDataCenter shareInstance] warningDownTirepressure] outPutType:TPTirePressureData_Psi];
            self.topWarningNumLab.text = [NSString stringWithFormat:@"%d psi", (int)self.topWarningSlider.value];
            self.bottomWarningNumLab.text = [NSString stringWithFormat:@"%d psi", (int)self.bottomWarningSlider.value];
        }
            break;
        default:
            break;
    }
    
    switch ([[TPDataCenter shareInstance] temPeratureDataType]) {
        case TPTemperatureData_Centigrade:
        {
            self.sheshidu.selected = YES;
            self.huashidu.selected = NO;
            self.teperatureSlider.value = [[TPDataCenter shareInstance] convertTemprature:[[TPDataCenter shareInstance] warningTemprature] outPutType:TPTemperatureData_Centigrade];
            self.teperatureNumLab.text = [NSString stringWithFormat:@"%d ℃", (int)self.teperatureSlider.value];
        }
            break;
        case TPTemperatureData_Fahrenheit:
        {
            self.sheshidu.selected = NO;
            self.huashidu.selected = YES;
            self.teperatureSlider.value = [[TPDataCenter shareInstance] convertTemprature:[[TPDataCenter shareInstance] warningTemprature] outPutType:TPTemperatureData_Fahrenheit];
            self.teperatureNumLab.text = [NSString stringWithFormat:@"%d ℉", (int)self.teperatureSlider.value];
        }
            break;
        default:
            break;
    }
    
    
    
}

- (void)languageChanged {
    self.navigationItem.title = L(@"TPMainMenuBaseSetting");
    self.pressureUnitLab.text = L(@"TPBaseSettingPage_PressureUnit");
    self.teperatureUnitLab.text = L(@"TPBaseSettingPage_TemperatureUnit");
    self.topWarningLabTip.text = L(@"TPBaseSettingPage_UpperLimitValueSetting");
    self.bottomWarningLabTip.text = L(@"TPBaseSettingPage_LowerrLimitValueSetting");
    self.teperatureWarningLabTip.text = L(@"TPBaseSettingPage_UpperLimitValueSetting");
    
    [self.version setTitle:L(@"TPMainMenuVersionInfo") forState:UIControlStateNormal];
    [self.tire setTitle:L(@"TPTireMatchPage_TireSetting") forState:UIControlStateNormal];
}
///
- (IBAction)psi:(id)sender {
    [[TPDataCenter shareInstance] setTirePressureDataType:TPTirePressureData_Psi];
    [self initData];
}
- (IBAction)abr:(id)sender {
    [[TPDataCenter shareInstance] setTirePressureDataType:TPTirePressureData_Bar];
    [self initData];
}
- (IBAction)kg:(id)sender {
    [[TPDataCenter shareInstance] setTirePressureDataType:TPTirePressureData_Kg];
    [self initData];
}
- (IBAction)kpa:(id)sender {
    [[TPDataCenter shareInstance] setTirePressureDataType:TPTirePressureData_Kpa];
    [self initData];
}

///
- (IBAction)uplimit:(id)sender {
    UISlider * slider = (UISlider *)sender;
    [[TPDataCenter shareInstance] setWarningTopTirepressure:slider.value];
    self.topWarningNumLab.text = [NSString stringWithFormat:@"%d", (int)self.topWarningSlider.value];
}
- (IBAction)dowmlimit:(id)sender {
    UISlider * slider = (UISlider *)sender;
    [[TPDataCenter shareInstance] setWarningDownTirepressure:slider.value];
    self.bottomWarningNumLab.text = [NSString stringWithFormat:@"%d", (int)self.bottomWarningSlider.value];
}

///
- (IBAction)sheshidu:(id)sender {
    [[TPDataCenter shareInstance] setTemPeratureDataType:(TPTemperatureData_Centigrade)];
    [self initData];
}
- (IBAction)huashidu:(id)sender {
    [[TPDataCenter shareInstance] setTemPeratureDataType:(TPTemperatureData_Fahrenheit)];
    [self initData];
}

///
- (IBAction)temperature:(id)sender {
}

///
- (IBAction)tireAction:(id)sender {
    
}

- (IBAction)pushVersion:(id)sender {
    Class cls = NSClassFromString(@"TPVersionViewController");
    TPBaseViewController * vc = [cls new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
