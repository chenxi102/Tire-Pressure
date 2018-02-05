//
//  TPConfigInformationManager.h
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/16.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TPConfigInfo : NSObject
@property (nonatomic, assign) TPMachineState tPMachineState;
@end


@interface TPConfigInformationManager : NSObject
@property (nonatomic, strong) TPConfigInfo *machineInfo ;
@end
