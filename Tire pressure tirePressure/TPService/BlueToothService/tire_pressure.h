//
// Created by mac on 2017/12/11.
//


#ifndef TAIYA_TIRE_PRESSURE_H
#define TAIYA_TIRE_PRESSURE_H

#ifdef __cplusplus
extern "C" {
#endif
#include <stdio.h>
#include <stdlib.h>
#define LENGTH_WITHOUT_DATA 7


typedef struct Head{
    unsigned char head;//=0xAA;
    unsigned char from;
    unsigned char to;
    unsigned char length;
    unsigned char cmd;
    unsigned char childCmd;
} Head;

typedef struct packet {
    struct Head header;
    unsigned char *data;
    unsigned char check;
}packet;


typedef enum Direction{
    sendTo, receive
}Direction;

    
typedef enum AlarmType {
    highPress = 0,lowPress,temperature
}AlarmType;

typedef enum Tire {
    RightFront = 0,RightBack,LeftFront,LeftBack
}Tire;

typedef enum TireState{
    Normal = 0,
    LowPress = 1,
    HighPress = 2,
    HighTemp = 4,HighTempLowPress,HighTempHighPress,slowLeakage,fastLeakage,lowElect
}TireState;

typedef enum Command{
    none = 0,
    hand = 0x11,
    getTPMS = 0x61,
    setAlarm = 0x62,
    getAlarm = 0x63,
    startTPMSMatchID = 0x6B,
    endTPMSMatchID = 0x6E,
    swapTPMSID = 0x6D,
    callWarning = 0x12,
}Command;

typedef enum Result{
    success,failure,
}Result;

typedef struct TireInfo{
    Tire tire;
    TireState tireState;
    unsigned short id;
    unsigned char press;
    unsigned char temp;
}TireInfo;

typedef struct resPacket{
    Command command;// = none;
    Result result;// = failure;
    unsigned char hPress; //= -1;
    unsigned char lPress;// = -1;
    unsigned char hTemp;// = -1;
    TireInfo tires[4];
}resPacket;

unsigned char* handBytes(void);
unsigned char* getTPMSBytes(void);
unsigned char* setAlarmParamBytes(AlarmType alarm, unsigned char value);
unsigned char* getAlarmBytes(void);
unsigned char* startTPMSMatchIDBytes(Tire tire);
unsigned char* endTPMSMatchIDBytes(void);
unsigned char* swapTPMSIDBytes(Tire tire,Tire tire2);

resPacket* parseBytes(Command command,unsigned char * bytes,int length);
unsigned char * sendBytes(unsigned char * bytes);
#ifdef __cplusplus
}
#endif

#endif //TAIYA_TIRE_PRESSURE_H
