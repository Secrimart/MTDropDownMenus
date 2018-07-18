//
//  MTDropDownMenuViewController.h
//  MTDropDownMenu
//
//  Created by Jason Li on 2018/6/12.
//

#import <UIKit/UIKit.h>
#import "MTDropDownMenuProtocol.h"

@import MTSegmentedMenus;

typedef void (^MTDDMSelectedChangeBlock)(NSInteger index, NSString *title);

@interface MTDropDownMenuViewController : UIViewController

/**
 arrayTitles
 */
@property (nonatomic, strong) NSArray *arrayTitles;

/**
 itemFormatterBlock
 */
@property (nonatomic, copy) MTMenuItemFormatterBlock itemFormatterBlock;

/**
 SegmentMenu
 */
@property (nonatomic, strong) MTSegmentedMenus *segmentedMenu;

/**
 isOpen
 Default NO
 */
@property (nonatomic) BOOL isOpen;

/**
 selected index
 Default -1(MTSegmentedMenuViewControllerNoSegment)
 */
@property (nonatomic) NSInteger selectedIndex;

/**
 menu height
 Default 44.f
 */
@property (nonatomic) CGFloat menuHeight;

/**
 reserve height
 Default 44.f
 */
@property (nonatomic) CGFloat reserveHeight;

/**
 arrayChildViewControllers
 */
@property (nonatomic, strong) NSArray<UIViewController<MTDropDownMenuProtocol> *> *arrayChildViewContollers;


- (instancetype)initWithTitles:(NSArray<NSString *> *)titles itemFormatterBlock:(MTMenuItemFormatterBlock) itemFormatter;

- (void)toCancel;

- (void)toSetSelectedMenuTitle:(NSString *)title;
- (void)toResetMenuTitle;

@end


typedef MTDropDownMenuViewController MTDDMViewController;
