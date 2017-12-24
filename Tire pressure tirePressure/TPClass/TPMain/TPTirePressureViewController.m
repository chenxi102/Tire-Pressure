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

@interface TPTirePressureViewController ()
@property (nonatomic, strong) TPToolView * toolView;
@end

@implementation TPTirePressureViewController


// MARK: lifyCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self normalUiconfig];
    [self toolSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// MARK: UI config
- (void)normalUiconfig {
    self.navigationItem.titleView = [[UIImageView  alloc]initWithImage:[UIImage imageNamed:@"logo"]];
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
                Class cls = NSClassFromString(@"TPVersionViewController");
                TPBaseViewController * vc = [cls new];
//                TPSettingViewController * vc = [TPSettingViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([handleString isEqualToString:@"jinggaoyin"]){
                TPWarnigSoundViewController * vc = [[TPWarnigSoundViewController alloc]initWithNibName:@"TPWarnigSoundViewController" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
            }
        } afterDelay:0];
    };
}

// MARK: function
- (void)languageChanged {
    [self.toolView refreshLanguage];
}

@end
