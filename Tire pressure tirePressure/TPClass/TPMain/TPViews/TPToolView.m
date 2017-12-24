//
//  TPToolView.m
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/10.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import "TPToolView.h"

#define TapLeft   30
#define TapRight   30


#define Item_width   30
#define Item_height   27

#define Tap   (SCREEN_WIDTH-Item_width*3-TapLeft-TapRight)/2
@interface TPToolView()
@property (nonatomic, copy) NSArray <NSString *>* images;       // icons
@property (nonatomic, copy) NSArray <NSString *>* titles;       // titles
@property (nonatomic, copy) NSArray <NSString *>* handleStrs;   // titles

@property (nonatomic, strong) NSMutableArray <UILabel *>* labels;        // titles
@end

@implementation TPToolView

- (instancetype)initWithImages:(NSArray<NSString *>*)imgs titles:(NSArray<NSString *>*)tles handleStrs:(NSArray <NSString *>*)handleStrs
{
    self = [super init];
    if (self) {
        self.labels = [NSMutableArray arrayWithCapacity:0];
        self.images = imgs;
        self.titles = tles;
        self.handleStrs = handleStrs;
        [self setup];
    }
    return self;
}

- (void)setup {
    for (int _  = 0; _< self.images.count; _++) {
        [self creatToolButtonWithImage:self.images[_] title:self.titles[_] handleStr:self.handleStrs[_] index:_];
    }
}

- (void)creatToolButtonWithImage:(NSString*)img title:(NSString *)tle  handleStr:(NSString *)handleStr index:(NSInteger)index
{
    
    UIImageView * imageV = [UIImageView new];
    [self addSubview:imageV];
    [imageV setImage:[UIImage imageNamed:img]];
    __block long int idx = index;
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@((TapLeft+ Tap*idx + Item_width*idx)));
        make.top.equalTo(@(5));
        make.width.equalTo(@(Item_width));
        make.height.equalTo(@(Item_height));
    }];
    
    UILabel * lab = [UILabel new];
    [self addSubview:lab];
    [self.labels addObject:lab];
    lab.text = L(tle);
    lab.font = [UIFont systemFontOfSize:14];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    @weak(imageV);
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strong(imageV);
        make.top.equalTo(imageV.mas_bottom).offset(3);
        make.centerX.equalTo(imageV.mas_centerX);
    }];
    
    TPButton * toolBtn = [TPButton new];
    [self addSubview:toolBtn];
    [toolBtn setBackgroundImage:[UIImage creatimageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [toolBtn setBackgroundImage:[UIImage creatimageWithColor:RGB_A(33, 33, 33, .5)] forState:UIControlStateHighlighted];
    toolBtn.handleStr = handleStr;
    [toolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strong(imageV);
        make.top.bottom.equalTo(@0);
        make.width.equalTo(@(Item_width+60));
        make.centerX.equalTo(imageV.mas_centerX);
    }];
    [toolBtn addTarget:self action:@selector(toolAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toolAction:(TPButton *)sender {
    DeBugLog(@"按下按钮, indertifier 是：%@", sender.handleStr);
    if (self.toolHandleBlock) {
        self.toolHandleBlock(sender.handleStr);
    }
}

- (void)refreshLanguage
{
    for (int _  = 0; _< _labels.count; _++) {
        UILabel * lab = _labels[_];
        lab.text = L(_titles[_]);
    }
}

@end
