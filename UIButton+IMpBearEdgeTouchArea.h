//
//  UIButton+IMpBearEdgeTouchArea.h
//  IMpBearRunTime
//
//  Created by zc on 2018/1/23.
//  Copyright © 2018年 IMpBear GitHub:https://github.com/MrXCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

// runtime 增加按钮的响应区域
@interface UIButton (IMpBearEdgeTouchArea)
/**
 *  设置响应边距
 */
-(void)setMorelargeEdge:(CGFloat)size ;


/**
 *  按钮热区边距
 *  top
 *  left
 *  bottom
 *  right
 */

-(void)setMorelargeEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;




@end
