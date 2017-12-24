//
//  CALayer+Ex.h
//  IntelligentPacket
//
//  Created by Seth Chen on 16/7/2.
//  Copyright © 2016年 detu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Ex)
/**
 *  在SB中设置keypath就可以改变boredercolor的颜色
 */
@property(nonatomic, strong) UIColor *borderColorFromUIColor;
//- (void)setBorderColorFromUIColor:(UIColor *)color;

@end
