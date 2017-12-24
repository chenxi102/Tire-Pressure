//
//  TPBaseNavController.m
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/10.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import "TPBaseNavController.h"

@interface TPBaseNavController ()

@end

@implementation TPBaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage creatimageWithColor:[UIColor colorWithRed:90/255. green:90/255. blue:90/255. alpha:.7]] forBarMetrics:UIBarMetricsDefault];
    
    //    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"黑色背景"]];
    self.view.layer.contents = (id)[UIImage imageNamed:@"黑色背景"].CGImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
