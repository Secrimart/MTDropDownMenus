//
//  MTMenu3SecondTableViewController.m
//  MTDropDownMenu_Example
//
//  Created by Jason Li on 2018/7/17.
//  Copyright © 2018年 rstx_reg@aliyun.com. All rights reserved.
//

#import "MTMenu3SecondTableViewController.h"

@interface MTMenu3SecondTableViewController ()

@end

@implementation MTMenu3SecondTableViewController

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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MTMenu3SecondTableViewControllerCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MTMenu3SecondTableViewControllerCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %ld",self.selectedTitle,indexPath.row];
    
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
    
    if (self.menuResponseBlock) {
        self.menuResponseBlock([tableView cellForRowAtIndexPath:indexPath].textLabel.text);
    }
    
}

@end
