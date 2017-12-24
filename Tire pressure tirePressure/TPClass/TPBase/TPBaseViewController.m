//
//  TPBaseViewController.m
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/10.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import "TPBaseViewController.h"

@interface TPBaseViewController ()

@end

@implementation TPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged) name:AppLanguageChangeNotify object:nil];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.0],NSFontAttributeName,nil]];
}

- (void)languageChanged {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
