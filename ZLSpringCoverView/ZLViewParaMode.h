//
//  ZLViewParaMode.h
//  ZLSpringCoverView
//
//  Created by Mac on 16/3/26.
//  Copyright © 2016年 Mac. All rights reserved.
//  动画的弹性，掉落时间，初始化速度，都在这里设置

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZLViewParaMode : NSObject


/**弹簧弹性 如果不设置 将默认为0.3*/
@property (nonatomic, assign) CGFloat Damping;

/**view出现的初始速度 如果不设置 则默认为0*/
@property (nonatomic, assign) CGFloat initialSpringVelocity;

/**动画用时 默认1sec*/
@property (nonatomic, assign) CGFloat time;

/**view的背景颜色 默认黑色*/
@property (nonatomic, strong) UIColor *backgroundColor;



@end
