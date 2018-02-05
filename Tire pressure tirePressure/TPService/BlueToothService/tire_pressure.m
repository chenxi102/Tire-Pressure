//
// Created by mac on 2017/12/11.
//
#include "tire_pressure.h"
//#include "android_Log.h"

unsigned char sum(packet pack,int dataLen){
    unsigned char ret = 0;
    ret += pack.header.head;
    ret += pack.header.from;
    ret += pack.header.to;
    ret += pack.header.length;
    ret += pack.header.cmd;
    ret += pack.header.childCmd;
    for(int i = 0;i < dataLen;i++){
        ret += *(pack.data + i);
    }
    return ret;
}

packet createPacket(Direction direction,unsigned char cmd,unsigned char child, unsigned char *data , int dataLen){
    packet pack;
    pack.header.head = 0xAA;
    if(direction == sendTo){
        pack.header.from = 0xA1;
        pack.header.to = 0x41;
    }else{
        pack.header.from = 0x41;
        pack.header.to = 0xA1;
    }
    if(data != NULL){
        pack.header.length = LENGTH_WITHOUT_DATA + dataLen;
    }else{
        pack.header.length = LENGTH_WITHOUT_DATA;
    }
    pack.header.cmd = cmd;
    pack.header.childCmd = child;

    if(dataLen != 0){
        pack.data = (unsigned char *)malloc(dataLen);
        memcpy(pack.data,data,dataLen);
    }else{
        pack.data = NULL;
    }
    pack.check = sum(pack,dataLen);
    return pack;
}

unsigned char * parsePacket(packet pack){

    int length = pack.header.length;
    unsigned char* bytes = (unsigned char *)malloc(length);
    bytes[0] = pack.header.head;
    bytes[1] = pack.header.to;
    bytes[2] = pack.header.from;
    bytes[3] = pack.header.length;
    bytes[4] = pack.header.cmd;
    bytes[5] = pack.header.childCmd;
    if(pack.header.length > LENGTH_WITHOUT_DATA) {
        memcpy(bytes + 6, pack.data, length - LENGTH_WITHOUT_DATA);
    }
    bytes[length - 1] = pack.check;
//    for(int i = 0;i < length;i++){
//        LOGI("parsePacket : %02X",bytes[i]);
//    }
//    LOGI("===================================");
    return bytes;
}

int checkCorrect(unsigned char *bytes,int length){
    unsigned char sum = 0;
    if(length >= LENGTH_WITHOUT_DATA) {
        for (int i = 0; i < length - 1; i++) {
            sum += bytes[i];
        }
//        LOGI("check correct : %02X , %02X",sum,bytes[length - 1]);
        if(sum == bytes[length - 1] && bytes[0] == 0xAA
           && bytes[1] == 0xA1
           && bytes[2] == 0x41
           && bytes[3] == length){
            return 0;
        }
    }
    printf("check error ：%02x",sum);
    return -1;
}

Tire getTire(int index){
    switch (index){
        case 0:
            return RightFront;
        case 1:
            return RightBack;
        case 2:
            return LeftFront;
        case 3:
            return LeftBack;
        default:
            return RightFront;
    }
}

TireState getTireState(int index){
    switch (index){
        case 0:
            return Normal;
        case 1:
            return LowPress;
        case 2:
            return HighPress;
        case 4:
            return HighTemp;
        case 5:
            return HighTempLowPress;
        case 6:
            return HighTempHighPress;
        case 7:
            return slowLeakage;
        case 8:
            return fastLeakage;
        case 9:
            return lowElect;
        default:
            return Normal;
    }
}





unsigned short charToShort16(unsigned char hByte,unsigned char lByte){
    unsigned short ret = (((unsigned short)hByte) << 8 | lByte);
    return ret;
}

resPacket* parseBytes(Command command,unsigned char * bytes,int length){
    if(bytes == NULL){
        return NULL;
    }
    resPacket* resPack = (resPacket *)malloc(sizeof(resPacket));
    if(checkCorrect(bytes,length) == 0){
        if(command == none){
            command = (Command)bytes[4];
        }
        switch (command){
            case hand:
                resPack->command = command;
                resPack->result = success;
                break;
            case getTPMS:
                resPack->command = command;
                resPack->result = success;
                resPack->tires[0].tire = getTire(bytes[6]);
                resPack->tires[0].id = charToShort16(bytes[7],bytes[8]);
                printf("id : 0x%x",resPack->tires[0].id);
                resPack->tires[0].press = bytes[9];
                resPack->tires[0].temp = bytes[10];
                resPack->tires[0].tireState = getTireState(bytes[12]);

                resPack->tires[1].tire = getTire(bytes[14]);
                resPack->tires[1].id = charToShort16(bytes[15],bytes[16]);
                resPack->tires[1].tireState = getTireState(bytes[20]);
                resPack->tires[1].press = bytes[17];
                resPack->tires[1].temp = bytes[18];

                resPack->tires[2].tire = getTire(bytes[22]);
                resPack->tires[2].id = charToShort16(bytes[23],bytes[24]);
                resPack->tires[2].tireState = getTireState(bytes[28]);
                resPack->tires[2].press = bytes[25];
                resPack->tires[2].temp = bytes[26];

                resPack->tires[3].tire = getTire(bytes[30]);
                resPack->tires[3].id = charToShort16(bytes[31],bytes[32]);
                resPack->tires[3].tireState = getTireState(bytes[36]);
                resPack->tires[3].press = bytes[33];
                resPack->tires[3].temp = bytes[34];
                break;
            case setAlarm:
                resPack->command = command;
                resPack->result = success;
                break;
            case getAlarm:
                resPack->command = command;
                resPack->result = success;
                resPack->hPress = bytes[6];
                resPack->lPress = bytes[7];
                resPack->hTemp = bytes[8];
                break;
            case startTPMSMatchID:
                resPack->command = command;
                resPack->result = success;
                resPack->tires[0].id = charToShort16(bytes[5],bytes[6]);
                break;
            case endTPMSMatchID:
                resPack->command = command;
                resPack->result = success;
                break;
            case swapTPMSID:
                resPack->command = command;
                resPack->result = success;
                break;
            case callWarning:
                resPack->command = command;
                resPack->result = success;
                break;
            default:
                break;
        }
    }else{
        resPack->result = failure;
    }
    return resPack;


}


unsigned char* handBytes(){
    packet handPacket = createPacket(sendTo,hand,0,NULL,0);
    return parsePacket(handPacket);
}

unsigned char* getTPMSBytes(){
    packet tpmsPacket = createPacket(sendTo,getTPMS,0,NULL,0);
    return parsePacket(tpmsPacket);
}


unsigned char* setAlarmParamBytes(AlarmType alarm, unsigned char value){
    unsigned char * bytes = (unsigned char *)malloc(1);
    bytes[0] = value;
    unsigned char type = -1;
    if(alarm == highPress){
        type = 0;
    }else if(alarm == lowPress){
        type = 1;
    }else if(alarm == temperature){
        type = 2;
    }
    packet alarmPacket = createPacket(sendTo,setAlarm,type,bytes,1);
    return parsePacket(alarmPacket);
}


unsigned char* getAlarmBytes(){
    packet alarmPacket = createPacket(sendTo,getAlarm,0,NULL,0);
    return parsePacket(alarmPacket);

}

unsigned char* startTPMSMatchIDBytes(Tire tire){
    unsigned char * bytes = (unsigned char *)malloc(1);
    bytes[0] = tire;
    packet matchPacket = createPacket(sendTo,startTPMSMatchID,0,bytes,1);
    return  parsePacket(matchPacket);
}

unsigned char* endTPMSMatchIDBytes(){
    packet matchPacket = createPacket(sendTo,endTPMSMatchID,0,NULL,0);
    return parsePacket(matchPacket);
}

unsigned char* swapTPMSIDBytes(Tire tire,Tire tire2){
    unsigned char * bytes = (unsigned char *)malloc(2);
    bytes[0] = tire;
    bytes[1] = tire2;
    packet swapPacket = createPacket(sendTo,swapTPMSID,0,bytes,2);
    return parsePacket(swapPacket);
}




