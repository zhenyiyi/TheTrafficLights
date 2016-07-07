//
//  ViewController.m
//  TheTrafficLights
//
//  Created by fenglin on 16/7/7.
//  Copyright © 2016年 fenglin. All rights reserved.
//

#import "ViewController.h"
#import "TransitionKit.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*          红绿灯    */
    
    // 1. 初始化状态机
    TKStateMachine * stateMachine = [[TKStateMachine alloc] init];
 
    // 2. 初始化 状态.  一个信号灯只有 ”红“，“绿”，”黄“ 三种状态。
        // 红灯
    TKState * green = [TKState stateWithName:@"green"];
        // 黄灯
    TKState * yellow = [TKState stateWithName:@"yellow"];
        // 红灯
    TKState * red = [TKState stateWithName:@"red"];
    
    // 3.添加状态到状态机。
    [stateMachine addStates:@[green,
                              yellow,
                              red]];
    // 设置默认的状态。
    stateMachine.initialState = green;
    
    
    // 4.初始化 事件。
    
   /*    绿灯 ---> 黄灯
    *    黄灯 ---> 红灯
    *    红灯 ----> 黄灯
    *    黄灯 ----> 绿灯
    */
        //警告
    TKEvent *warn = [TKEvent eventWithName:@"warn" transitioningFromStates:@[green] toState:yellow];
        //停止
    TKEvent *stop = [TKEvent eventWithName:@"stop" transitioningFromStates:@[yellow] toState:red];
        //准备
    TKEvent *ready = [TKEvent eventWithName:@"ready" transitioningFromStates:@[red] toState:yellow];
        //前进
    TKEvent *go = [TKEvent eventWithName:@"go" transitioningFromStates:@[yellow] toState:green];
    
     // 5.添加事件到状态机。
    [stateMachine addEvents:@[warn ,
                              stop ,
                              ready,
                              go]];
    
    // 6.启动状态机。
    [stateMachine activate];
    
    // 检测能否触发这个事件, 目前是 ”green“ 状态。
    if ([stateMachine canFireEvent:stop]) {
        //to do
    };
    
    
    // 将要出发这个事件
    [warn setWillFireEventBlock:^(TKEvent *event, TKTransition *transition) {
        //do something
        NSLog(@"will fire 'warn' event ");
    }];
    
    [warn setDidFireEventBlock:^(TKEvent *event, TKTransition *transition) {
         NSLog(@"did fire 'warn' event ");
    }];
    
    
    [stop setDidFireEventBlock:^(TKEvent *event, TKTransition *transition) {
        //do something
    }];
  
    [ready setDidFireEventBlock:^(TKEvent *event, TKTransition *transition) {
        //do something
    }];
    
    
    [go setDidFireEventBlock:^(TKEvent *event, TKTransition *transition) {
        //do something
    }];
    
    
    
    //“绿灯” 倒计时结束  ----->(告诉状态机)  将要触发这个事件：  “warn”
    
    [stateMachine fireEvent:warn userInfo:nil error:nil];
}

@end
