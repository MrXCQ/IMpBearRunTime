//
//  ViewController.m
//  IMpBearRunTime
//
//  Created by zc on 2018/1/23.
//  Copyright © 2018年 IMpBear GitHub:https://github.com/MrXCQ. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+IMpBearEdgeTouchArea.h"
#import "UIButton+IMpBearReTouch.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom] ;
    button.frame = CGRectMake(0, 0, 100, 100) ;
    button.backgroundColor = [UIColor redColor] ;
    button.center = self.view.center ;
    button.timeDelay = 3.f ;
    //[button setMorelargeEdge:100]; 按钮周围区域 100 仍可响应热区
    //[button setMorelargeEdgeWithTop:0 left:-50 bottom:0 right:0];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)click:(UIButton *)btn{
    NSLog(@"点击了按钮 ---  %f",btn.frame.size.width) ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
