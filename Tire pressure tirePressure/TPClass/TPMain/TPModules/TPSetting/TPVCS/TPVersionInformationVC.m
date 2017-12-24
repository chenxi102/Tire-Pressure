//
//  TPVersionInformationVC.m
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/17.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import "TPVersionInformationVC.h"

@interface TPVersionInformationVC ()

@end

@implementation TPVersionInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self languageChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)languageChanged {
    self.navigationItem.title = L(@"TPMainMenuVersionInfo");
}
@end
