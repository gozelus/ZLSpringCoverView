//
//  ZLViewParaMode.m
//  ZLSpringCoverView
//
//  Created by Mac on 16/3/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ZLViewParaMode.h"

@implementation ZLViewParaMode


- (CGFloat)Damping{
    if (!_Damping) {
        _Damping = 0.3;
    }
    return _Damping;
}
-(CGFloat)initialSpringVelocity{
    if (!_initialSpringVelocity) {
        _initialSpringVelocity =0;
    }
    return _initialSpringVelocity;
}
- (CGFloat)time{
    if (!_time) {
        _time = 1;
    }
    return _time;
}

// 默认黑色
- (UIColor *)backgroundColor{
    if (!_backgroundColor) {
        _backgroundColor = [UIColor blackColor];
    }
    return _backgroundColor;
}





@end
