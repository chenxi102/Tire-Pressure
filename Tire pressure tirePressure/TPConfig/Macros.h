//
//  Macros.h
//  DTSethKit
//
//  Created by Seth on 17/3/21.
//  Copyright © 2017年 detu. All rights reserved.
//


// TODO:TODO
// MARK:MARK
// FIXME:FIXME

#ifndef Macros_h
#define Macros_h


/**
 页面控制
 ========================================================================================
 */
// MARK: Test code switch
#define SWITCH    1
// SWITCH 为 0 , debug release 模式下 DeveloperMode 中代码不执行，
// SWITCH 为 1 , debug 模式下  DeveloperMode 中代码执行

#if DEBUG
#define iS_DEBUG   1
#else
#define iS_DEBUG   0
#endif
#define DeveloperMode(Stuff)   if (!iS_DEBUG) { \
\
\
} else { \
if (SWITCH) { Stuff;} \
\
}   \


// MARK:强制横竖屏
#define CameraOrientationPortrait(portrait)\
SEL selector = NSSelectorFromString(@"setOrientation:");\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];\
[invocation setSelector:selector];\
[invocation setTarget:[UIDevice currentDevice]];\
int val = portrait;\
[invocation setArgument:&val atIndex:2];\
[invocation invoke];

// MARK: WeakSelf   StrongSelf
#define weak(...)   autoreleasepool {}__weak typeof(__VA_ARGS__) weakClass = __VA_ARGS__;
#define strong(...)  autoreleasepool {}__strong typeof(__VA_ARGS__)__VA_ARGS__ = weakClass;


/**
 打印
 ========================================================================================
 */
// MARK: Log system
#if DEBUG
// Debug
#define DeBugLog(fmt, ...)    NSLog((@"DeBugLog: %s" fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__)
// Control
#define ControlLog(fmt, ...)    NSLog((@"ControlLog: %s" fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__)
// DataTrack
#define DataTrackLog(fmt, ...)    NSLog((@"DataTrackLog: %s" fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__)
#else
#define DeBugLog(...)
#define ControlLog(...)
#define DataTrackLog(...)
#endif

/**
 UI
 ========================================================================================
 */
// MARK: color
//RGB颜色不透明
#define RGB(r,g,b)               [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
//RGB   a-->颜色透明度
#define RGB_A(r,g,b,a)           [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width //屏幕宽
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height  //屏幕高



/**
 国际化
 ========================================================================================
 */
#define AppLanguage @"appLanguage"

#define CustomLocalizedString(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]

#define L(key) CustomLocalizedString(key, nil)
#define refreshLangugeNotification @"refreshLangugeNotification"

#endif /* Macros_h */
