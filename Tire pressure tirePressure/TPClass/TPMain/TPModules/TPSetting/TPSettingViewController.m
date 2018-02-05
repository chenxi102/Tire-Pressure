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
@property (weak, nonatomic) IBOutlet UIButton *lockBtn;

@end

@implementation TPSettingViewController
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [TPBlueToothManager shareInstance] setAlarmTirePressure:<#(AlarmType)#> value:<#(int)#> Res:<#^(BOOL)res#>
    
    [self dataChangeNotice];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blackColor];
    self.view.layer.contents = (id)[UIImage imageNamed:@"设定背景"].CGImage;
    [self initData];
    [self languageChanged];
}

- (void)dataChangeNotice {
    [[NSNotificationCenter defaultCenter] postNotificationName:SettingDataChangeNotify object:nil];
}

- (void)initData
{
    NSInteger  warningTopTirepressure  = [[TPDataCenter shareInstance] warningTopTirepressure];
    NSInteger  warningDownTirepressure  = [[TPDataCenter shareInstance] warningDownTirepressure];
    
    switch ([[TPDataCenter shareInstance] tirePressureDataType]) {
        case TPTirePressureData_Bar:
        {
            self.bar.selected = YES;
            self.kgcm.selected = self.psi.selected = self.kPa.selected = NO;
            NSInteger  __warningTopTirepressure  =  [[TPDataCenter shareInstance] convertTirePressure:warningTopTirepressure inPutType:TPTirePressureData_Bar outPutType:TPTirePressureData_Bar];
            NSInteger  __warningDownTirepressure  = [[TPDataCenter shareInstance] convertTirePressure:warningDownTirepressure inPutType:TPTirePressureData_Bar outPutType:TPTirePressureData_Bar];
            self.topWarningSlider.value = __warningTopTirepressure;
            self.bottomWarningSlider.value = __warningDownTirepressure;
            self.topWarningNumLab.text = [NSString stringWithFormat:@"%d bar", (int)__warningTopTirepressure];
            self.bottomWarningNumLab.text = [NSString stringWithFormat:@"%d bar", (int)__warningDownTirepressure];
        }
            break;
        case TPTirePressureData_Kg:
        {
            self.kgcm.selected = YES;
            self.bar.selected = self.psi.selected = self.kPa.selected = NO;
            NSInteger  __warningTopTirepressure  =  [[TPDataCenter shareInstance] convertTirePressure:warningTopTirepressure inPutType:TPTirePressureData_Bar outPutType:TPTirePressureData_Kg];
            NSInteger  __warningDownTirepressure  = [[TPDataCenter shareInstance] convertTirePressure:warningDownTirepressure inPutType:TPTirePressureData_Bar outPutType:TPTirePressureData_Kg];
            self.topWarningSlider.value = __warningTopTirepressure;
            self.bottomWarningSlider.value = __warningDownTirepressure;
            self.topWarningNumLab.text = [NSString stringWithFormat:@"%d kg/cm²", (int)__warningTopTirepressure];
            self.bottomWarningNumLab.text = [NSString stringWithFormat:@"%d kg/cm²", (int)__warningDownTirepressure];
        }
            break;
        case TPTirePressureData_Kpa:
        {
            self.kPa.selected = YES;
            self.bar.selected = self.psi.selected = self.kgcm.selected = NO;
            NSInteger  __warningTopTirepressure = [[TPDataCenter shareInstance] convertTirePressure:warningTopTirepressure inPutType:TPTirePressureData_Bar outPutType:TPTirePressureData_Kpa];
            NSInteger  __warningDownTirepressure = [[TPDataCenter shareInstance] convertTirePressure:warningDownTirepressure inPutType:TPTirePressureData_Bar outPutType:TPTirePressureData_Kpa];
            self.topWarningSlider.value = __warningTopTirepressure;
            self.bottomWarningSlider.value = __warningDownTirepressure;
            self.topWarningNumLab.text = [NSString stringWithFormat:@"%d kPa", (int)__warningTopTirepressure];
            self.bottomWarningNumLab.text = [NSString stringWithFormat:@"%d kPa", (int)__warningDownTirepressure];
        }
            break;
        case TPTirePressureData_Psi:
        {
            self.psi.selected = YES;
            self.bar.selected = self.kPa.selected = self.kgcm.selected = NO;
            NSInteger  __warningTopTirepressure = [[TPDataCenter shareInstance] convertTirePressure:warningTopTirepressure inPutType:TPTirePressureData_Bar outPutType:TPTirePressureData_Psi];
            NSInteger  __warningDownTirepressure = [[TPDataCenter shareInstance] convertTirePressure:warningDownTirepressure inPutType:TPTirePressureData_Bar outPutType:TPTirePressureData_Psi];
            self.topWarningSlider.value = __warningTopTirepressure;
            self.bottomWarningSlider.value = __warningDownTirepressure;
            self.topWarningNumLab.text = [NSString stringWithFormat:@"%d psi", (int)__warningTopTirepressure];
            self.bottomWarningNumLab.text = [NSString stringWithFormat:@"%d psi", (int)__warningDownTirepressure];
        }
            break;
        default:
            break;
    }
    
    NSInteger  warningTemprature = [[TPDataCenter shareInstance] warningTemprature];
    switch ([[TPDataCenter shareInstance] temPeratureDataType]) {
        case TPTemperatureData_Centigrade:
        {
            self.sheshidu.selected = YES;
            self.huashidu.selected = NO;
            NSInteger  __warningTemprature = [[TPDataCenter shareInstance] convertTemprature:warningTemprature inPutType:TPTemperatureData_Centigrade outPutType:TPTemperatureData_Centigrade];
            self.teperatureSlider.value = __warningTemprature ;
            self.teperatureNumLab.text = [NSString stringWithFormat:@"%d ℃", (int)__warningTemprature];
        }
            break;
        case TPTemperatureData_Fahrenheit:
        {
            self.sheshidu.selected = NO;
            self.huashidu.selected = YES;
            NSInteger  __warningTemprature = [[TPDataCenter shareInstance] convertTemprature:warningTemprature inPutType:TPTemperatureData_Centigrade outPutType:TPTemperatureData_Fahrenheit];
            self.teperatureSlider.value = __warningTemprature ;
            self.teperatureNumLab.text = [NSString stringWithFormat:@"%d ℉", (int)__warningTemprature];
        }
            break;
        default:
            break;
    }
    
    self.lockBtn.selected = [[TPDataCenter shareInstance] dataLock];
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
    if ([[TPDataCenter shareInstance] dataLock]) {
        return;
    }
    [[TPDataCenter shareInstance] setTirePressureDataType:TPTirePressureData_Psi];
    [self initData];
}
- (IBAction)abr:(id)sender {
    if ([[TPDataCenter shareInstance] dataLock]) {
        return;
    }
    [[TPDataCenter shareInstance] setTirePressureDataType:TPTirePressureData_Bar];
    [self initData];
}
- (IBAction)kg:(id)sender {
    if ([[TPDataCenter shareInstance] dataLock]) {
        return;
    }
    [[TPDataCenter shareInstance] setTirePressureDataType:TPTirePressureData_Kg];
    [self initData];
}
- (IBAction)kpa:(id)sender {
    if ([[TPDataCenter shareInstance] dataLock]) {
        return;
    }
    [[TPDataCenter shareInstance] setTirePressureDataType:TPTirePressureData_Kpa];
    [self initData];
}

///
- (IBAction)uplimit:(id)sender {
    if ([[TPDataCenter shareInstance] dataLock]) {
        [self initData];
        return;
    }
    UISlider * slider = (UISlider *)sender;
    [[TPDataCenter shareInstance] setWarningTopTirepressure:slider.value];
    self.topWarningNumLab.text = [NSString stringWithFormat:@"%d %@", (int)self.topWarningSlider.value, [[TPDataCenter shareInstance] tirePressureString]];
}
- (IBAction)dowmlimit:(id)sender {
    if ([[TPDataCenter shareInstance] dataLock]) {
        [self initData];
        return;
    }
    UISlider * slider = (UISlider *)sender;
    [[TPDataCenter shareInstance] setWarningDownTirepressure:slider.value];
    self.bottomWarningNumLab.text = [NSString stringWithFormat:@"%d %@", (int)self.bottomWarningSlider.value, [[TPDataCenter shareInstance] tirePressureString]];
}

///
- (IBAction)sheshidu:(id)sender {
    if ([[TPDataCenter shareInstance] dataLock]) {
        return;
    }
    [[TPDataCenter shareInstance] setTemPeratureDataType:(TPTemperatureData_Centigrade)];
    [self initData];
}
- (IBAction)huashidu:(id)sender {
    if ([[TPDataCenter shareInstance] dataLock]) {
        return;
    }
    [[TPDataCenter shareInstance] setTemPeratureDataType:(TPTemperatureData_Fahrenheit)];
    [self initData];
}

///
- (IBAction)temperature:(id)sender {
    if ([[TPDataCenter shareInstance] dataLock]) {
        [self initData];
        return;
    }
    UISlider * slider = (UISlider *)sender;
    [[TPDataCenter shareInstance] setWarningTemprature:slider.value];
    self.teperatureNumLab.text = [NSString stringWithFormat:@"%d %@", (int)self.teperatureSlider.value, [[TPDataCenter shareInstance] tempString]];
}

///
- (IBAction)tireAction:(id)sender {
    
}

- (IBAction)pushVersion:(id)sender {
    Class cls = NSClassFromString(@"TPVersionViewController");
    TPBaseViewController * vc = [cls new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)lockAction:(id)sender {
    UIButton * btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    [[TPDataCenter shareInstance] setDataLock:btn.selected];
}

- (void)showAlertWithMessage {
    
}


@end
