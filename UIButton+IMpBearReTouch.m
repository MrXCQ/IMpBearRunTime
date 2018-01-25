//
//  UIButton+IMpBearReTouch.m
//  IMpBearRunTime
//
//  Created by zc on 2018/1/23.
//  Copyright © 2018年 IMpBear GitHub:https://github.com/MrXCQ. All rights reserved.
//

#import "UIButton+IMpBearReTouch.h"
#import <objc/runtime.h>
#define DEFAULTTIMEDELAY 2 //防止重复点击的默认时间

@interface UIButton ()

@property(nonatomic,assign)BOOL isIgnoreEvent ;

@end
@implementation UIButton (IMpBearReTouch)


// 方法交换
+(void)load{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        Method method1 = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:)) ;
        Method method2 = class_getInstanceMethod([self class], @selector(customSendAction:to:forEvent:)) ;
        method_exchangeImplementations(method1, method2) ;
    }) ;
}

-(NSTimeInterval)timeDelay{
    return [objc_getAssociatedObject(self, _cmd) doubleValue] ;
}

-(void)setTimeDelay:(NSTimeInterval)timeDelay{
    objc_setAssociatedObject(self, @selector(timeDelay), @(timeDelay), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)customSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    // 设置为YES 执行系统的初始方法
    if (self.isIgnore) {
        [self customSendAction:action to:target forEvent:event];
        return ;
    }
    
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        self.timeDelay = self.timeDelay == 0 ? DEFAULTTIMEDELAY:self.timeDelay ;
        // 是否忽略此件事件
        if (self.isIgnoreEvent) {
            return ;
        }else if (self.timeDelay > 0 ){
            [self performSelector:@selector(resetState) withObject:nil afterDelay:self.timeDelay];
        }
        self.isIgnoreEvent = YES ;
        [self customSendAction:action to:target forEvent:event];
    }
}

// 重置
-(void)resetState{
    self.isIgnoreEvent = NO ;
}

#pragma mark -- 动态的添加属性
-(void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isIgnoreEvent{
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setIsIgnore:(BOOL)isIgnore{
    objc_setAssociatedObject(self, @selector(isIgnore), @(isIgnore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isIgnore{
    return  [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
