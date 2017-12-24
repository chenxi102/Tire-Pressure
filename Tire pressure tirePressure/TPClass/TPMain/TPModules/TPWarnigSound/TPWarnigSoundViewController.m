//
//  TPWarnigSoundViewController.m
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/12.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import "TPWarnigSoundViewController.h"

@interface TPWarnigSoundViewController ()
@property (weak, nonatomic) IBOutlet UIButton *chineseBtn;
@property (weak, nonatomic) IBOutlet UIButton *englishBtn;
@property (weak, nonatomic) IBOutlet UIButton *esBtn;
@property (weak, nonatomic) IBOutlet UIButton *frBtn;
@property (weak, nonatomic) IBOutlet UIButton *spainBtn;
@property (weak, nonatomic) IBOutlet UIButton *alarm1;
@property (weak, nonatomic) IBOutlet UIButton *alarm2;
@property (weak, nonatomic) IBOutlet UIButton *alarm3;
@property (weak, nonatomic) IBOutlet UIButton *alarm4;
@property (weak, nonatomic) IBOutlet UIButton *alarm5;
@property (weak, nonatomic) IBOutlet UIButton *confimBtn;

@end

@implementation TPWarnigSoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.chineseBtn setBackgroundImage:[UIImage creatimageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
    [self.englishBtn setBackgroundImage:[UIImage creatimageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
    [self.esBtn setBackgroundImage:[UIImage creatimageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
    [self.frBtn setBackgroundImage:[UIImage creatimageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
    [self.spainBtn setBackgroundImage:[UIImage creatimageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
    [self.alarm1 setBackgroundImage:[UIImage creatimageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
    [self.alarm2 setBackgroundImage:[UIImage creatimageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
    [self.alarm3 setBackgroundImage:[UIImage creatimageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
    [self.alarm4 setBackgroundImage:[UIImage creatimageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
    [self.alarm5 setBackgroundImage:[UIImage creatimageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
    [self languageChanged];
    [self initLanguage];
}
- (IBAction)chinese:(UIButton *)sender {
    [self setAlldisSelect];
    sender.selected = !sender.selected;
    [[TPLanguageManager sharedInstance] changeLanguage:TPLanguageChinese needFresh:YES];
}
- (IBAction)english:(UIButton *)sender {
    [self setAlldisSelect];
    sender.selected = !sender.selected;
    [[TPLanguageManager sharedInstance] changeLanguage:TPLanguageEnglish needFresh:YES];
}
- (IBAction)russia:(UIButton *)sender {
    [self setAlldisSelect];
    sender.selected = !sender.selected;
    [[TPLanguageManager sharedInstance] changeLanguage:TPLanguageRussia needFresh:YES];
}
- (IBAction)french:(UIButton *)sender {
    [self setAlldisSelect];
    sender.selected = !sender.selected;
    [[TPLanguageManager sharedInstance] changeLanguage:TPLanguageFrench needFresh:YES];
}
- (IBAction)spnish:(UIButton *)sender {
    [self setAlldisSelect];
    sender.selected = !sender.selected;
    [[TPLanguageManager sharedInstance] changeLanguage:TPLanguageSpanish needFresh:YES];
}

- (void)setAlldisSelect {
    self.chineseBtn.selected = NO;
    self.esBtn.selected = NO;
    self.englishBtn.selected = NO;
    self.frBtn.selected = NO;
    self.spainBtn.selected = NO;
}

- (IBAction)alarmChange:(UIButton *)sender {
    
    DeBugLog(@"alarmChange tag is %ld", sender.tag);
    if (sender.tag) {
        
    }
}

- (void)languageChanged {
    [self.chineseBtn setTitle:L(@"TPWarnigPage_Chinese") forState:UIControlStateNormal];
    [self.esBtn setTitle:L(@"TPWarnigPage_Russian") forState:UIControlStateNormal];
    [self.englishBtn setTitle:L(@"TPWarnigPage_English") forState:UIControlStateNormal];
    [self.frBtn setTitle:L(@"TPWarnigPage_French") forState:UIControlStateNormal];
    [self.spainBtn setTitle:L(@"TPWarnigPage_Spanish") forState:UIControlStateNormal];
    [self.confimBtn setTitle:L(@"TPWarnigPage_OK") forState:UIControlStateNormal];
    self.navigationItem.title = L(@"TPMainMenuAlarm");
}

- (void)initLanguage {
    [self setAlldisSelect];
    TPLanguageType type = [[TPLanguageManager sharedInstance] getCurrentLanguage];
    switch (type) {
        case TPLanguageChinese:
            self.chineseBtn.selected = YES;
            break;
        case TPLanguageEnglish:
            self.englishBtn.selected = YES;
            break;
        case TPLanguageSpanish:
            self.spainBtn.selected = YES;
            break;
        case TPLanguageFrench:
            self.frBtn.selected = YES;
            break;
        case TPLanguageRussia:
            self.esBtn.selected = YES;
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
