//
//  TPTirePressureViewController.m
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/10.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import "TPTirePressureViewController.h"
#import "TPMatchViewController.h"
#import "TPSettingViewController.h"
#import "TPWarnigSoundViewController.h"
#import "TPToolView.h"
#import "TPInformationView.h"

@interface TPTirePressureViewController ()
@property (nonatomic, strong) TPToolView * toolView;
@property (nonatomic, strong) TPInformationView * leftFrontView;
@property (nonatomic, strong) TPInformationView * rightFrontView;
@property (nonatomic, strong) TPInformationView * leftBackView;
@property (nonatomic, strong) TPInformationView * rightBackView;

@property (nonatomic, strong) NSTimer * DataTimer;
@end

@implementation TPTirePressureViewController

// MARK: lifyCycle
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}
- (void)dealloc {}
- (void)viewWillAppear:(BOOL)animated {[super viewWillAppear:animated];}
- (void)viewDidAppear:(BOOL)animated {[super viewDidAppear:animated];}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self normalUiconfig];
    [self toolSetup];
    @weak(self);
    _DataTimer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        @strong(self);
        [self loadData];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:SettingDataChangeNotify object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        @strong(self);
        [self refreshDisplay:YES];
    }];
}

// MARK: UI config
- (void)normalUiconfig {
    self.navigationItem.titleView = [[UIImageView  alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    UIImageView * imgv = [UIImageView new];
    [imgv setImage:[UIImage imageNamed:@"車子"]];
    [self.view addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.size.equalTo(@(CGSizeMake(110, 200)));
    }];
    __weak typeof(self) wkself = self;
    @weak(imgv);
    _leftFrontView = [TPInformationView new];
    [self.view addSubview:_leftFrontView];
    [_leftFrontView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strong(imgv);
        make.left.equalTo(@15);
        make.right.equalTo(imgv.mas_left).offset(15);
        make.bottom.equalTo(imgv.mas_centerY).offset(-45);
        make.top.equalTo(@119);
    }];
    
    
    _leftBackView = [TPInformationView new];
    [self.view addSubview:_leftBackView];
    [_leftBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(wkself) self = wkself;
        @strong(imgv);
        make.left.equalTo(@15);
        make.width.equalTo(self.leftFrontView.mas_width);
        make.height.equalTo(self.leftFrontView.mas_height);
        make.top.equalTo(imgv.mas_centerY).offset(45);
    }];
    
    _rightFrontView = [TPInformationView new];
    [self.view addSubview:_rightFrontView];
    [_rightFrontView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strong(imgv);
        make.right.equalTo(@-15);
        make.width.equalTo(self.leftFrontView.mas_width);
        make.height.equalTo(self.leftFrontView.mas_height);
        make.bottom.equalTo(imgv.mas_centerY).offset(-45);
    }];
    
    _rightBackView = [TPInformationView new];
    [self.view addSubview:_rightBackView];
    [_rightBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(wkself) self = wkself;
        @strong(imgv);
        make.right.equalTo(@-15);
        make.width.equalTo(self.leftFrontView.mas_width);
        make.height.equalTo(self.leftFrontView.mas_height);
        make.top.equalTo(imgv.mas_centerY).offset(45);
    }];
    [self refreshDisplay:NO];
}

- (void)toolSetup {
    
    self.toolView = [[TPToolView alloc] initWithImages:@[@"ID", @"设置", @"警告音"] titles:@[@"ID", @"TPBaseSettingPage", @"TPMainMenuAlarm"] handleStrs:@[@"peidui", @"sheding", @"jinggaoyin"]];
    [self.view addSubview:self.toolView];
    self.toolView.layer.contents = (id)[UIImage imageNamed:@"菜单背景"].CGImage;
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
        make.height.equalTo(@55);
    }];
    @weak(self)
    self.toolView.toolHandleBlock = ^(NSString *handleString) {
        @strong(self)
        [self performBlock:^{
            if ([handleString isEqualToString:@"peidui"]) {
                //
                TPMatchViewController * vc = [TPMatchViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([handleString isEqualToString:@"sheding"]){
//                Class cls = NSClassFromString(@"TPVersionViewController");
//                TPBaseViewController * vc = [cls new];
                TPSettingViewController * vc = [TPSettingViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([handleString isEqualToString:@"jinggaoyin"]){
                TPWarnigSoundViewController * vc = [[TPWarnigSoundViewController alloc]initWithNibName:@"TPWarnigSoundViewController" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
            }
        } afterDelay:0];
    };
}

// MARK: load Data
- (void)loadData {
    
    // 1.请求接口 2.封装返回数据 3.判断是否需要闪烁或者弹出提示框
    self.leftFrontView.electric = 90;
    self.leftBackView.electric = 10;
    self.rightFrontView.electric = 50;
    self.rightBackView.electric = 2;
    
    self.leftFrontView.tirepressure = arc4random()%300;
    self.leftBackView.tirepressure = arc4random()%300;
    self.rightFrontView.tirepressure = arc4random()%300;
    self.rightBackView.tirepressure = arc4random()%300;
    
    
    self.leftFrontView.temprature = arc4random()%300;
    self.leftBackView.temprature = arc4random()%300;
    self.rightFrontView.temprature = arc4random()%300;
    self.rightBackView.temprature = arc4random()%300;
    [self showAlarm];
    [self refreshDisplay:YES];
}

- (void)refreshDisplay:(BOOL)abool {
    [self.leftFrontView refreshStatesWithDisInit:abool];
    [self.leftBackView refreshStatesWithDisInit:abool];
    [self.rightFrontView refreshStatesWithDisInit:abool];
    [self.rightBackView refreshStatesWithDisInit:abool];
}


// MARK: function
- (void)languageChanged {
    [self.toolView refreshLanguage];
}
- (void)showAlarm {
    
}
@end
