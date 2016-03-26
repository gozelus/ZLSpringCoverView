//
//  UIViewController+ZLSpringCoverView.m
//  ZLSpringCoverView
//
//  Created by Mac on 16/3/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "UIViewController+ZLSpringCoverView.h"
#import <objc/runtime.h>

@implementation UIViewController (ZLSpringCoverView)


static const char* springCoverViewKey = "springCoverViewKey";


- (ZLSpringCoverView *)springCoverView{
    
    
    return objc_getAssociatedObject(self, springCoverViewKey);
    
    
}
- (void)setSpringCoverView:(ZLSpringCoverView *)springCoverView{
    
    
    objc_setAssociatedObject(self, springCoverViewKey, springCoverView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
}

@end
