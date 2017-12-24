//
//  UIImage+Fit.h
//  PeiLinRopeSkipping
//
//  Created by sam on 15/6/15.
//  Copyright (c) 2015年 Lunarsam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Fit)
#pragma mark 返回拉伸好的图片
+ (UIImage *)resizeImage:(NSString *)imgName;

- (UIImage *)resizeImage;

+ (UIImage *) creatimageWithColor:(UIColor *)color;

+ (UIImage*)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
@end
