//
//  MTDropDownMenuProtocol.h
//  MTDropDownMenu
//
//  Created by Jason Li on 2018/6/12.
//

#import <Foundation/Foundation.h>

typedef void (^MTDropDownMenuResponseBlock)(id object);

@protocol MTDropDownMenuProtocol <NSObject>

/**
 
 */
@required
@property (nonatomic) CGFloat showHeight;

@optional
/**
 <#Desc#>
 */
@property (nonatomic) CGFloat showWidth;


@end
