//
//  MTDropDownMenuListViewController.m
//  MTSegmentedMenus
//
//  Created by Jason Li on 2018/7/17.
//

#import "MTDropDownMenuListViewController.h"

@interface MTDropDownMenuListViewController ()

@end

@implementation MTDropDownMenuListViewController

- (void)toShowSecondViewController {
    [self.secondViewController.view setFrame:[self initalPositionWithSecondViewController]];
    
    CGRect rect = self.secondViewController.view.frame;
    rect.origin.x = CGRectGetMaxX(self.view.frame) - CGRectGetWidth(rect);
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        [weakSelf.secondViewController.view setFrame:rect];
    }];
}

- (void)toCloseSecondViewController {
    CGRect rect = [self initalPositionWithSecondViewController];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        [weakSelf.secondViewController.view setFrame:rect];
    }];
}

- (CGRect)initalPositionWithSecondViewController {
    CGRect oRect = self.view.bounds;
    oRect.origin.x = CGRectGetMaxX(oRect);
    oRect.size.height = self.showHeight;
    oRect.size.width = self.secondViewController.showWidth;
    
    return oRect;
}

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

- (void)setSecondViewController:(UIViewController<MTDropDownMenuProtocol> *)secondViewController {
    _secondViewController = secondViewController;
    
    [self addChildViewController:secondViewController];
    [self.view addSubview:secondViewController.view];
    [secondViewController didMoveToParentViewController:self];
    
    [self.secondViewController.view setFrame:[self initalPositionWithSecondViewController]];
}

//MARK: Table View DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)showHeight {
    CGFloat height = CGFLOAT_MIN;
    for (NSInteger section = 0 ; section < [self numberOfSectionsInTableView:self.tableView]; section ++) {
        for (NSInteger row = 0; row < [self tableView:self.tableView numberOfRowsInSection:section]; row++) {
            height += [self tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
        }
    }
    
    return height;
}

- (CGFloat)showWidth {
    if (_showWidth > 0) {
        return _showWidth;
    }
    
    return (CGRectGetWidth([UIScreen mainScreen].bounds)/2.f);
}

@end
