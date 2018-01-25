//
//  UIButton+IMpBearReTouch.h
//  IMpBearRunTime
//
//  Created by zc on 2018/1/23.
//  Copyright © 2018年 IMpBear GitHub:https://github.com/MrXCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (IMpBearReTouch)
/**
 *  按钮防止重复点击 间隔设置三秒钟
 */
@property(nonatomic,assign) NSTimeInterval timeDelay ;
/**
 *  YES：不可重复点击，默认为可重复点击
 */
@property(nonatomic, assign)BOOL isIgnore;


@end
