//
//  NSObject+Extension.h
//  detuf4
//
//  Created by Seth on 16/6/12.
//  Copyright © 2016年 detu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay; ///< 延时几秒调用

- (void)asnyExcuteOnGlobalThread:(dispatch_block_t)block afterDelay:(NSTimeInterval)delay ;
@end
