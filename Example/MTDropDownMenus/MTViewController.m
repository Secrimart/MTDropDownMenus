//
//  MTViewController.m
//  MTDropDownMenus
//
//  Created by rstx_reg@aliyun.com on 07/18/2018.
//  Copyright (c) 2018 rstx_reg@aliyun.com. All rights reserved.
//

#import "MTViewController.h"
#import "MTMenu1TableViewController.h"
#import "MTMenu2TableViewController.h"
#import "MTMenu3TableViewController.h"

@import MTDropDownMenus;
@import Masonry;

@interface MTViewController ()

@property (nonatomic, strong) MTDDMViewController *menu;

@property (nonatomic, strong) UIButton *btnCancel;

@end

@implementation MTViewController

- (void)toToggle {
    [self.menu toSetSelectedMenuTitle:@"selected"];
}

- (void)toResetMenu {
    [self.menu toResetMenuTitle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.btnCancel];
    
    [self.btnCancel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(20.f);
        make.height.mas_equalTo(44.f);
    }];
    
    [self toAddChildViewController:self.menu];
    __weak typeof(self) weakSelf = self;
    [self.menu.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(64.f);
        make.height.mas_equalTo(44.f);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - Action
- (void)toAddChildViewController:(UIViewController *)viewController {
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

//MARK: - Getter And Setter
- (MTDDMViewController *)menu {
    if (_menu) return _menu;
    _menu = [[MTDropDownMenuViewController alloc] initWithTitles:@[@"menu1",@"menu2",@"menu3"] itemFormatterBlock:^(MTMenuItem *item) {
        item.imgIndicator = [UIImage imageNamed:@"arrow"];
        item.imgIndicatorSelected = [UIImage imageNamed:@"arrowselected"];
        
        item.labTitle.font = [UIFont systemFontOfSize:13.f];
        
        item.selectedTitleColor = [UIColor blackColor];
        item.selectedItemColor = [UIColor groupTableViewBackgroundColor];
        
        item.animationEnable = YES;
    }];
    __weak typeof(self) weakSelf = self;
    MTMenu1TableViewController *menu1VC = [[MTMenu1TableViewController alloc] initWithStyle:UITableViewStylePlain];
    menu1VC.resposeBlock = ^(NSString *title) {
        [weakSelf.menu toSetSelectedMenuTitle:title];
    };
    
    MTMenu2TableViewController *menu2VC = [[MTMenu2TableViewController alloc] initWithStyle:UITableViewStylePlain];
    menu2VC.menuResponseBlock = ^(id object) {
        [weakSelf.menu toSetSelectedMenuTitle:object];
    };
    
    MTMenu3TableViewController *menu3VC = [[MTMenu3TableViewController alloc] initWithStyle:UITableViewStylePlain];
    menu3VC.menuResponseBlock = ^(id object) {
        [weakSelf.menu toSetSelectedMenuTitle:object];
    };
    
    _menu.arrayChildViewContollers = @[menu1VC,menu2VC,menu3VC];
    
    return _menu;
}

- (UIButton *)btnCancel {
    if (_btnCancel) return _btnCancel;
    _btnCancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btnCancel setTitle:@"Reset Menu" forState:UIControlStateNormal];
    
    [_btnCancel addTarget:self action:@selector(toResetMenu) forControlEvents:UIControlEventTouchUpInside];
    
    return _btnCancel;
}

@end
