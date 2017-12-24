//
//  CALayer+Ex.m
//  IntelligentPacket
//
//  Created by Seth Chen on 16/7/2.
//  Copyright © 2016年 detu. All rights reserved.
//

#import "CALayer+Ex.h"
#import <objc/runtime.h>

@implementation CALayer (Ex)

- (UIColor *)borderColorFromUIColor {
    
    return objc_getAssociatedObject(self, @selector(borderColorFromUIColor));
}
-(void)setBorderColorFromUIColor:(UIColor *)color
{
    objc_setAssociatedObject(self, @selector(borderColorFromUIColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setBorderColorFromUI:color];
}
- (void)setBorderColorFromUI:(UIColor *)color
{
    self.borderColor = color.CGColor;
    
}

@end
