//
//  TPVersionViewController.m
//  Tire pressure tirePressure
//
//  Created by Seth Chen on 2017/12/17.
//  Copyright © 2017年 JianYiMei. All rights reserved.
//

#import "TPVersionViewController.h"
#import "TPVersionTableCell.h"
#import "TPVersionInformationVC.h"

@interface TPVersionViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation TPVersionViewController

static NSString * dataSource[] = {
    @"TPVersionPageInformation",
    @"TPVersionPage_RestoreDefaultSetting"
};

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self configTable];
    [self languageChanged];
}

- (void)configTable {
    //    self.view.layer
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }else [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"TPVersionTableCell" bundle:nil] forCellReuseIdentifier:@"TPVersionTableCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)languageChanged {
    self.navigationItem.title = L(@"TPMainMenuVersionInfo");
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return sizeof(dataSource)/sizeof(dataSource[0]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TPVersionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TPVersionTableCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentLab.text = L(dataSource[indexPath.row]);
    // UI
    // ==================================================================
   
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    switch (indexPath.row) {
        case 0:
        {
            TPVersionInformationVC * vc = [TPVersionInformationVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
