//
//  VBBlueToothManager.h
//
//  Created by Seth on 16/5/5.
//  Copyright © 2016年 detu. All rights reserved.
//

#define takePhotoCMD     @"0500"
#define startRecordCMD   @"060101"
#define stopRecordCMD    @"060100"
#define setMode_photoCMD @"040101"
#define setMode_videoCMD @"040100"
#define setH_Resolution @"080257604320"
#define setL_Resolution @"080238402160"

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>




@interface VBBlueToothManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (strong, nonatomic) CBCentralManager *manager;
@property (strong, nonatomic) CBPeripheral *peripheral;
@property (copy, nonatomic) void(^blueToothRes)(NSData *data);
@property (copy, nonatomic) void(^connectRes)(BOOL success);

@property CBService *Service;
@property CBCharacteristic *boardValueCharacteristic;
@property CBCharacteristic *boardStateCharacteristic;
@property CBCharacteristic *characteristic;

#pragma mark - Methods for controlling the joofunn Dartboard

+ (instancetype)shareInstance ;
- (VBBlueToothManager *) start;
- (void) writeData:(NSData *)data res:(void(^)(NSData *data))res;
@end
