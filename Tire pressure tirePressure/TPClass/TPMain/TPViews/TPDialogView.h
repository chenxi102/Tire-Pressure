//
//  TPDialogView.h
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/17.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TPDialogView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *confimBtn;


- (void)showToDestinationView:(UIView *)view ;
@end
