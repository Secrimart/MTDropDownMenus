//
//  MTDropDownMenuViewController.m
//  MTDropDownMenu
//
//  Created by Jason Li on 2018/6/12.
//

#import "MTDropDownMenuViewController.h"

@import Masonry;

@interface MTDropDownMenuViewController ()

/**
 originalHeight
 */
@property (nonatomic) CGFloat originalHeight;

/**
 mark control
 */
@property (nonatomic, strong) UIControl *markControl;

@end

@implementation MTDropDownMenuViewController

//MARK: - Action
- (void)toAddChildViewController:(UIViewController *)viewController {
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

- (void)toCancel {
    [self toShowMenuAtIndex:MTSegmentedMenuViewControllerNoSegment
          hiddenMenuAtIndex:self.selectedIndex];
    [self.segmentedMenu toCancelSelected];
}

- (void)toSetSelectedMenuTitle:(NSString *)title {
    [self.segmentedMenu toResetItemTitle:title atItemIndex:self.selectedIndex];
    [self toCancel];
}

- (void)toResetMenuTitle {
    if (self.isOpen) {
        [self toCancel];
    }
    
    for (int index = 0; index < self.arrayTitles.count; index++) {
        [self.segmentedMenu toResetItemTitle:self.arrayTitles[index] atItemIndex:index];
    }
}

/**
 根据菜单内容控制器序号，控制菜单内容的隐藏和展开

 @param showIndex 展开的控制器序号
 @param hiddenIndex 隐藏的控制器序号
 */
- (void)toShowMenuAtIndex:(NSInteger)showIndex hiddenMenuAtIndex:(NSInteger)hiddenIndex {
    /**
     * 展开下拉列表菜单
     * 当隐藏的菜单为 -1 且 打开的菜单不是 -1 时, 表示当前下拉列表控件需要展开菜单内容
     * 设置控件状态展开
     **/
    if (hiddenIndex == MTSegmentedMenuViewControllerNoSegment &&
        showIndex != MTSegmentedMenuViewControllerNoSegment) {
        self.isOpen = YES;
    }
    
    /**
     * 关闭下拉列表菜单
     * 当展开的菜单不是 -1 且 隐藏的菜单为 -1 时, 表示当前下拉列表控件需要关闭菜单内容
     * 设置控件状态为关闭
     **/
    if (hiddenIndex != MTSegmentedMenuViewControllerNoSegment &&
        showIndex == MTSegmentedMenuViewControllerNoSegment) {
        self.selectedIndex = showIndex;
        self.isOpen = NO;
    }
    
    /**
     * 隐藏hiddenIndex所指定的菜单内容
     * 在菜单内容视图控制器数组范围内，隐藏菜单内容视图控制器
     **/
    if (hiddenIndex >= 0 &&
        hiddenIndex <= self.arrayChildViewContollers.count - 1) {
        [self toHiddenMenuViewController:[self.arrayChildViewContollers objectAtIndex:hiddenIndex]];
    }
    
    /**
     * 展示showIndex所指定的菜单内容
     * 在菜单内容视图控制器数组范围内，展示菜单内容视图控制器
     **/
    if (showIndex >= 0 &&
        showIndex <= self.arrayChildViewContollers.count - 1) {
        self.selectedIndex = showIndex;
        [self toShowMenuViewController:[self.arrayChildViewContollers objectAtIndex:showIndex]];
    }
}

/**
 展开菜单内容视图控制器

 @param viewController 需要展开的菜单内容视图控制器
 */
- (void)toShowMenuViewController:(UIViewController<MTDropDownMenuProtocol> *)viewController {
    // 修正菜单内容视图控制的Frame
    [self toResetFrameWithMenuViewController:viewController];
    
    [viewController.view setHidden:NO];
    [self.view bringSubviewToFront:viewController.view];
    [self.view bringSubviewToFront:self.segmentedMenu.view];
    
    CGRect rect = viewController.view.frame;
    rect.origin.y = self.menuHeight;
    rect.size.height = viewController.showHeight;
    
    [UIView animateWithDuration:0.3f animations:^{
        [viewController.view setFrame:rect];
    }];
    
}

/**
 隐藏菜单内容视图控制器
 
 @param viewController 需要隐藏的菜单内容视图控制器
 */
- (void)toHiddenMenuViewController:(UIViewController<MTDropDownMenuProtocol> *)viewController {
    CGRect rect = self.view.frame;
    rect.origin.y = self.menuHeight - viewController.showHeight;
    rect.size.height= viewController.showHeight;
    
    [UIView animateWithDuration:0.3f animations:^{
        [viewController.view setFrame:rect];
        [viewController.view setHidden:YES];
    }];
}

/**
 修正菜单内容视图控制器Frame

 @param viewController 菜单内容视图控制器
 */
- (void)toResetFrameWithMenuViewController:(UIViewController<MTDropDownMenuProtocol> *)viewController {
    // 修正菜单内容视图控制的Frame
    if (CGRectGetHeight(viewController.view.frame) != viewController.showHeight) {
        CGRect rect = self.view.frame;
        // 计算菜单内容最大的内容高度
        CGFloat maxContentHeight = CGRectGetHeight(rect) - self.menuHeight - self.reserveHeight;
        
        // 设置菜单内容控制器的高度
        if (viewController.showHeight <= maxContentHeight) {
            rect.size.height = viewController.showHeight;
        } else {
            rect.size.height = maxContentHeight;
            // 修正内容VC高度
            viewController.showHeight = maxContentHeight;
        }
        rect.origin.y = self.menuHeight - viewController.showHeight;
        [viewController.view setFrame:rect];
    }
}

//MARK: - Life Cycle
- (instancetype)initWithTitles:(NSArray<NSString *> *)titles itemFormatterBlock:(MTMenuItemFormatterBlock)itemFormatter {
    self = [super init];
    if (self) {
        self.menuHeight = 44.f;
        self.reserveHeight = 44.f;
        
        self.arrayTitles = titles;
        self.itemFormatterBlock = itemFormatter;
        
        self.selectedIndex = MTSegmentedMenuViewControllerNoSegment;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.clipsToBounds = YES;
    
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.markControl];
    
    [self toAddChildViewController:self.segmentedMenu];
    [self.segmentedMenu.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(weakSelf.menuHeight);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - Getter And Setter
- (MTSegmentedMenus *)segmentedMenu {
    if (_segmentedMenu) return _segmentedMenu;
    __weak typeof(self) weakSelf = self;
    _segmentedMenu = [[MTSegmentedMenuViewController alloc] initWithTitles:self.arrayTitles itemFormatterBlock:self.itemFormatterBlock changedItemBlock:^(NSInteger cancelIndex, NSInteger selectIndex) {
        // 根据选择的 index 对菜单列表进行展现和隐藏
        [weakSelf toShowMenuAtIndex:selectIndex hiddenMenuAtIndex:cancelIndex];
        
    }];
    
    return _segmentedMenu;
}

- (UIControl *)markControl {
    if (_markControl) return _markControl;
    _markControl = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _markControl.backgroundColor = [UIColor clearColor];
    [_markControl addTarget:self action:@selector(toCancel) forControlEvents:UIControlEventTouchUpInside];
    
    return _markControl;
}

- (void)setIsOpen:(BOOL)isOpen {
    _isOpen = isOpen;
    
    __weak typeof(self) weakSelf = self;
    CGRect rect = self.view.frame;
    if (isOpen) {
        rect.size.height = CGRectGetMaxY([UIScreen mainScreen].bounds) - CGRectGetMinY(rect);
        [UIView animateWithDuration:0.3f animations:^{
            [weakSelf.view setFrame:rect];
            weakSelf.view.backgroundColor = [UIColor colorWithWhite:0.4f alpha:0.3f];
        }];
    } else {
        rect.size.height = self.menuHeight;
        [UIView animateWithDuration:0.3f animations:^{
            [weakSelf.view setFrame:rect];
            weakSelf.view.backgroundColor = [UIColor clearColor];
        }];
    }
}

- (void)setArrayChildViewContollers:(NSArray *)arrayChildViewContollers {
    _arrayChildViewContollers = arrayChildViewContollers;
    
    for (UIViewController<MTDropDownMenuProtocol> *controller in arrayChildViewContollers) {
        [controller.view setHidden:YES];
        
        [self toAddChildViewController:controller];
        [self toResetFrameWithMenuViewController:controller];
    }
    
}
@end
