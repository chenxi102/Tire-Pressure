//
//  SethSwitch.h
//  IntelligentPacket
//
//  Created by Seth Chen on 16/8/28.
//  Copyright © 2016年 detu. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation(SethSwitch)

/**地球坐标转火星坐标*/
- (CLLocation*)locationMarsFromEarth;
/**火星坐标转地球坐标*/
- (CLLocation *)locationEarthFromMars;
/**火星坐标转百度坐标*/
- (CLLocation*)locationBearPawFromMars;
/**百度坐标转火星坐标*/
- (CLLocation*)locationMarsFromBearPaw;



@end
