//
//  DVLanguageManager.m
//  detuvr
//
//  Created by David on 16/5/31.
//  Copyright © 2016年 detu. All rights reserved.
//

#import "TPLanguageManager.h"


@implementation TPLanguageManager

+ (instancetype) sharedInstance{
    static id obj = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        obj = [[self alloc] init];
    });
    return obj;
}

- (void) config
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *current = [languages objectAtIndex:0];
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults]objectForKey:AppLanguage];
    if (!currentLanguage) {
        NSString *language;
        if ([current isEqualToString:@"zh-Hans-CN"] || [current isEqualToString:@"zh-Hant-CN"] || [current isEqualToString:@"en-CN"]) {
            language = [current substringToIndex:current.length-3];
        } else  if([current isEqualToString:@"zh-Hans"] || [current isEqualToString:@"zh-Hant"] || [current isEqualToString:@"en"]){
            language = current;
        } else if ([current isEqualToString:@"fr"]) {
            language = @"fr";
        }else if ([current isEqualToString:@"es"]||[current isEqualToString:@"es-419"]||[current isEqualToString:@"es-MX"]) {
            language = @"es";
        }else if ([current isEqualToString:@"ru"]) {
            language = @"ru";
        }
        [[NSUserDefaults standardUserDefaults] setObject:language forKey:AppLanguage];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (BOOL)isChinese
{
    NSString *currLang = [self currentLanguage];
    if ([currLang isEqualToString:@"zh-Hans-CN"] ||
        [currLang isEqualToString:@"zh-Hant-CN"]||
        [currLang isEqualToString:@"zh-Hans"] ||
        [currLang isEqualToString:@"zh-Hant"]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)currentLanguage {
    return [[NSUserDefaults standardUserDefaults]objectForKey:AppLanguage];
}

- (void)changeLanguage:(TPLanguageType)lan needFresh:(BOOL)fre {
    NSString *language;
    switch (lan) {
        case TPLanguageChinese:
            language = @"zh-Hans";
            break;
        case TPLanguageEnglish:
            language = @"en";
            break;
        case TPLanguageFrench:
            language = @"fr";
            break;
        case TPLanguageRussia:
            language = @"ru";
            break;
        case TPLanguageSpanish:
            language = @"es";
            break;
        default:
            break;
    }
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:AppLanguage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:AppLanguageChangeNotify object:nil];
}

- (TPLanguageType)getCurrentLanguage {
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage];
    TPLanguageType lan = TPLanguageEnglish;
    if ([language isEqualToString:@"zh-Hans"]) {
        lan = TPLanguageChinese ;
    }
    else if ([language isEqualToString:@"en"]) {
        lan = TPLanguageEnglish;
    }
    else if ([language isEqualToString:@"fr"]) {
        lan = TPLanguageFrench;
    }
    else if ([language isEqualToString:@"ru"]) {
        lan = TPLanguageRussia;
    }
    else if ([language isEqualToString:@"es"]) {
        lan = TPLanguageSpanish;
    }
    return lan;
}

@end
