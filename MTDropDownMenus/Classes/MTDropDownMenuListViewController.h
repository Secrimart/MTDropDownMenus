//
//  MTDropDownMenuListViewController.h
//  MTSegmentedMenus
//
//  Created by Jason Li on 2018/7/17.
//

#import <UIKit/UIKit.h>

#import "MTDropDownMenuProtocol.h"

@interface MTDropDownMenuListViewController : UITableViewController<MTDropDownMenuProtocol>

@property (nonatomic) CGFloat showHeight;

@property (nonatomic) CGFloat showWidth;

@property (nonatomic, copy) MTDropDownMenuResponseBlock menuResponseBlock;

/**
 Second menu level view Controller
 */
@property (nonatomic, strong) UIViewController<MTDropDownMenuProtocol> *secondViewController;

- (void)toShowSecondViewController;

- (void)toCloseSecondViewController;

@end
