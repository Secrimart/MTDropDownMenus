//
//  MTMenu1TableViewController.m
//  MTDropDownMenu_Example
//
//  Created by Jason Li on 2018/7/17.
//  Copyright © 2018年 rstx_reg@aliyun.com. All rights reserved.
//

#import "MTMenu1TableViewController.h"

@interface MTMenu1TableViewController ()

@end

@implementation MTMenu1TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: Table View DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MTMenu1TableViewControllerCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MTMenu1TableViewControllerCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@%ld",@"Optional",indexPath.row];
    
    return cell;
}

//MARK: table view Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.resposeBlock) {
        self.resposeBlock([tableView cellForRowAtIndexPath:indexPath].textLabel.text);
    }
    
}

- (CGFloat)showHeight {
    return 8*44.f;
}

@end
