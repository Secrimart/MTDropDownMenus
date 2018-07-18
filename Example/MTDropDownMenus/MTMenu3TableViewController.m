//
//  MTMenu3TableViewController.m
//  MTDropDownMenu_Example
//
//  Created by Jason Li on 2018/7/17.
//  Copyright © 2018年 rstx_reg@aliyun.com. All rights reserved.
//

#import "MTMenu3TableViewController.h"
#import "MTMenu3SecondTableViewController.h"

@interface MTMenu3TableViewController ()
@property (nonatomic, strong) MTMenu3SecondTableViewController *secondVC;

@end

@implementation MTMenu3TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.secondViewController = self.secondVC;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMenuResponseBlock:(MTDropDownMenuResponseBlock)menuResponseBlock {
    self.secondVC.menuResponseBlock = menuResponseBlock;
}

- (MTMenu3SecondTableViewController *)secondVC {
    if (_secondVC) return _secondVC;
    _secondVC = [[MTMenu3SecondTableViewController alloc] initWithStyle:UITableViewStylePlain];
//    _secondVC.showWidth = 200;
    
    return _secondVC;
}

//MARK: Table View DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MTMenu2TableViewControllerCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MTMenu2TableViewControllerCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@%ld",@"Menu3 - ",indexPath.row];
    
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
    
    if (indexPath.row == 0) {
        [self toCloseSecondViewController];
        if (self.secondVC.menuResponseBlock) {
            self.secondVC.menuResponseBlock([tableView cellForRowAtIndexPath:indexPath].textLabel.text);
        }
    } else {
        self.secondVC.selectedTitle = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [self.secondVC.tableView reloadData];
        [self toShowSecondViewController];
    }
}

@end
