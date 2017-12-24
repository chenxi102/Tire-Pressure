//
//  DVLanguageManager.h
//  detuvr
//
//  Created by David on 16/5/31.
//  Copyright © 2016年 detu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TPLanguageType) {
    TPLanguageChinese ,
    TPLanguageEnglish ,
    TPLanguageFrench  ,
    TPLanguageRussia  ,
    TPLanguageSpanish ,
    
    TPLanguageMax
};

//语言选择
@interface TPLanguageManager : NSObject

+ (instancetype)sharedInstance;

- (void) config;

- (NSString *)currentLanguage;

- (BOOL)isChinese;//是否为中文

- (void)changeLanguage:(TPLanguageType)lan needFresh:(BOOL)fre ;
- (TPLanguageType)getCurrentLanguage;
@end
