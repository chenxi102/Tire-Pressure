//
//  TPToolView.h
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/10.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPToolView : UIView

@property (nonatomic, strong) void (^toolHandleBlock)(NSString * handleString);

- (instancetype)initWithImages:(NSArray<NSString *>*)imgs titles:(NSArray<NSString *>*)tles handleStrs:(NSArray <NSString *>*)handleStrs;
- (void)refreshLanguage;
@end
