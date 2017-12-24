//
//  NSObject+Extension.m
//  detuf4
//
//  Created by Seth on 16/6/12.
//  Copyright © 2016年 detu. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)


- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

- (void)asnyExcuteOnGlobalThread:(dispatch_block_t)block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_global_queue(0, 0), block);
}

@end
