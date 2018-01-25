//
//  UIButton+IMpBearEdgeTouchArea.m
//  IMpBearRunTime
//
//  Created by zc on 2018/1/23.
//  Copyright © 2018年 IMpBear GitHub:https://github.com/MrXCQ. All rights reserved.
//

#import "UIButton+IMpBearEdgeTouchArea.h"
#import <objc/runtime.h>
@implementation UIButton (IMpBearEdgeTouchArea)

static char topNameKey ;
static char rightNameKey ;
static char bottomNameKey ;
static char leftNameKey ;

#pragma mark -- 设置边距 上左下右 边距相等 setter
-(void)setMorelargeEdge:(CGFloat)size{
    // 需要添加关联的对象
    // 添加的唯一标识符
    // 关联的对象
    // 关联的策略 是个枚举
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC) ;
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC) ;
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC) ;
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC) ;
}

#pragma mark -- 设置边距 上左下右  自定义不同边距 setter
-(void)setMorelargeEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC) ;
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC) ;
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC) ;
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC) ;
}


#pragma mark -- 获取新的rect getter
-(CGRect)moreLargeRect{
    // 添加的关联对象
    // 添加的唯一标识符
    NSNumber *topEdge = objc_getAssociatedObject(self, &topNameKey) ;
    NSNumber *leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &bottomNameKey) ;
    NSNumber *rightEdge = objc_getAssociatedObject(self, &rightNameKey) ;
    
    // 是需求而定
    if (topEdge && leftEdge && bottomEdge && rightEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue) ;
    }else return self.bounds ;
}

//- hitTest: withEvent:方法的底层实现
//此底层实现说明了, 一个view的子控件是如何判断是否接收点击事件的.
//此方法返回的View是本次点击事件需要的最佳View

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect rect = [self moreLargeRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event] ;
    }
    return CGRectContainsPoint(rect, point) ? self : nil ;
}

@end
