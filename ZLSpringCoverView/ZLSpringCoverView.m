//
//  ZLSpringCoverView.m
//  ZLSpringCoverView
//
//  Created by Mac on 16/3/26.
//  Copyright © 2016年 Mac. All rights reserved.
//
#define ZLKeyScreenSize [UIScreen mainScreen].bounds.size
#define ZLProgressMagrin 5//高亮部分宽度
#define ZLScreenCenterPoint CGPointMake(ZLKeyScreenSize.width / 2.0, ZLKeyScreenSize.height/ 2.0)

#define ZLTitileFont [UIFont systemFontOfSize:30]



#import "ZLSpringCoverView.h"
#import "UIView+Frame.h"
#import <objc/runtime.h>


@interface ZLSpringCoverView()



/**vc表示当前需要调用蒙版的控制器，不许外部再次更改*/
@property (nonatomic, weak) UIViewController *vc;

// 定时器
@property (nonatomic, weak) NSTimer *timer;

// 使文字产生动态光效的蒙板
@property (nonatomic, strong) UIView *coverView;



// 加载中label
@property (nonatomic, strong) UILabel *loadingTitleLabel;
// 加载成功后label
@property (nonatomic, strong) UILabel *successTitleLabel;



@end


@implementation ZLSpringCoverView



#pragma mark - 重写的set/get方法 这些会被重用


static const char* modeKey = "modeKey";

/**重写mode的get方法，在这里截获默认的mode*/
- (ZLViewParaMode *)mode{
    
    if (!objc_getAssociatedObject(self, modeKey)) {
        ZLViewParaMode *mode = [[ZLViewParaMode alloc] init];
        objc_setAssociatedObject(self, modeKey, mode, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return mode;
    }else{
        
        return objc_getAssociatedObject(self, modeKey);

    }
}

- (void)setMode:(ZLViewParaMode *)mode{
    
    objc_setAssociatedObject(self, modeKey, mode, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    for (UIView *view in self.coverView.subviews) {
        view.backgroundColor = mode.backgroundColor;
    }
}

/**在这里创建label 并显示字样 默认隐藏*/
- (void)setLoadingTitle:(NSString *)loadingTitle{
    _loadingTitle = loadingTitle;

    if (!_loadingTitleLabel) {  //第一次设置才生成
        
        UILabel *titleLael =  [[UILabel alloc] init];
        titleLael.text = loadingTitle;
        titleLael.textColor = [UIColor whiteColor];
        titleLael.font = ZLTitileFont;
        [titleLael sizeToFit];
        titleLael.center = ZLScreenCenterPoint;
        
        self.loadingTitleLabel = titleLael;
        self.loadingTitleLabel.alpha = 0;
        [self addSubview:self.loadingTitleLabel];
        
        UIView *coverView =  [self setUpCoverView];//添加蒙版
        self.coverView = coverView;
        
    }else{
        self.loadingTitleLabel.text = loadingTitle;
        [self.loadingTitleLabel sizeToFit];
        self.loadingTitleLabel.center = ZLScreenCenterPoint;
        
        self.coverView.center = CGPointMake(self.loadingTitleLabel.x - 3, ZLKeyScreenSize.height / 2.0);

    }
    
}

/**在这里将view加到vc的view上，并隐藏*/
- (void)setVc:(UIViewController *)vc{
    
    _vc = vc;
    [vc.view addSubview:self];
    
    CGFloat height = ZLKeyScreenSize.height;
    self.width = ZLKeyScreenSize.width;
    self.height = height;
    
    self.alpha = 0;
    
}

/**每次在外部重新设置style时都要重新调整自身的位置*/
- (void)setStyle:(ZLSpringCoverViewStyle)style{
    _style = style;
    
    if (self.vc) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    [self setUpFrameWithStyle];
}



#pragma mark - 抽离出来的内部设置控件方法

// 设置使文字有光效的蒙板，尺寸根据当前loadingTitle计算。默认是隐藏的，会在show方法中设置可见,颜色根据mode里的颜色设置
- (UIView *)setUpCoverView{
    
    CGFloat subViewWidth = (self.vc.view.width - ZLProgressMagrin) * 0.5;
    UIView *coverView =  [[UIView alloc] init];
    coverView.width = self.vc.view.width;
    coverView.height = self.loadingTitleLabel.height;
    coverView.center = CGPointMake(self.loadingTitleLabel.x - 3, ZLKeyScreenSize.height / 2.0);

    UIView *subCover1 = [[UIView alloc] init];
    subCover1.x = 0;
    subCover1.y = 0;
    subCover1.width = subViewWidth;
    subCover1.height = self.loadingTitleLabel.height;
    subCover1.backgroundColor = self.mode.backgroundColor;
    subCover1.alpha = 0.7;
    [coverView addSubview:subCover1];
    
    UIView *subCover2 = [[UIView alloc] initWithFrame:subCover1.frame];
    subCover2.x = CGRectGetMaxX(subCover1.frame) + ZLProgressMagrin ;
    subCover2.backgroundColor = self.mode.backgroundColor;
    subCover2.alpha = 0.7;
    [coverView addSubview:subCover2];
    
    coverView.backgroundColor = [UIColor clearColor];
    coverView.hidden =YES;
    return coverView;
    
}

//  设置加载成功后的label 默认透明度为0 并在loading的下方
- (UILabel *)setUpSuccessLabelWithSuccessTitle:(NSString *)title{
    
    UILabel *successLabel = [[UILabel alloc] init];
    successLabel.text = title;
    successLabel.textColor = [UIColor whiteColor];
    successLabel.font = ZLTitileFont;
    [successLabel sizeToFit];
    
    // 根据loadtitlelabel的位置设置自身位置，并位于loading的下方
    successLabel.x = (ZLKeyScreenSize.width - successLabel.width)/ 2.0;
    successLabel.y = self.loadingTitleLabel.y + self.loadingTitleLabel.height;
    
    return successLabel;
}

// 根据自身的style计算出位置，这个方法会在-(void)setStyleWith:(ZLSpringCoverViewStyle:)中被再次调用
- (void)setUpFrameWithStyle{
    
    
    
    CGFloat height = ZLKeyScreenSize.height;
    switch (self.style) {
        case ZLSpringCoverViewStyleDefault:{
            CGFloat y = - height;
            self.y = y;
            self.x = 0;
        }
            break;
        case ZLSpringCoverViewStyleLeft:{
            CGFloat y = 0;
            self.y = y;
            self.x = -self.width;
        }
            break;
        case ZLSpringCoverViewStyleBottom:{
            CGFloat y = height;
            self.y = y;
            self.x = 0;
        }
            break;
        case ZLSpringCoverViewStyleRight:{
            CGFloat y = 0;
            self.y = y;
            self.x = self.width;
        }
            break;
        case ZLSpringCoverViewStyleFade:{
            self.y = 0;
            self.x = 0;
        }
            break;
    }
    
}

// 定时器定时移动小蒙版
-(void)changeTextColor{
    
    if (self.coverView.center.x > self.vc.view.width * 0.5) {// 左移
        [UIView animateWithDuration:1 animations:^{
            self.coverView.center = CGPointMake(self.loadingTitleLabel.x - 3, ZLKeyScreenSize.height / 2.0);
        }];
    }else{
        // 右移
        [UIView animateWithDuration:1 animations:^{
            CGFloat x = CGRectGetMaxX(self.loadingTitleLabel.frame);
            self.coverView.center = CGPointMake(x + 5, self.coverView.center.y);
            
            
        }];
    }
    
}


// 重新调整loadtitle及蒙板的位置
- (void)initSelf{
    
    
    
    self.loadingTitleLabel.center = ZLScreenCenterPoint;
    
    self.coverView.center = CGPointMake(self.loadingTitleLabel.x - 3, ZLKeyScreenSize.height / 2.0);
    
}



#pragma mark - 公开给外部使用的方法
// 构造方法
+ (instancetype)zl_progressViewWithLoadingTitle:(NSString *)loadingTitle successTitle:(NSString *)successTitle  vc:(UIViewController *)vc style:(ZLSpringCoverViewStyle)style mode:(ZLViewParaMode *)mode{
    ZLSpringCoverView *pView = [[ZLSpringCoverView alloc] init];
    
    
    pView.style = style;
    pView.mode = mode;
    pView.vc = vc;
    pView.loadingTitle = loadingTitle;
    pView.successTitle = successTitle;
    pView.backgroundColor = pView.mode.backgroundColor;

    return pView;
    
    
}


// 展示方法
- (void)zl_show{
    
    self.alpha = 0;
    self.backgroundColor = self.mode.backgroundColor;
    if (self.superview) {
        self.hidden = NO;

        [UIView animateWithDuration:1
                              delay:0
             usingSpringWithDamping:self.mode.Damping
              initialSpringVelocity:self.mode.initialSpringVelocity
                            options:UIViewAnimationOptionCurveEaseOut animations:^{
                                
                                self.y = 0;
                                self.x = 0;
                                self.alpha = 0.9;
                                self.loadingTitleLabel.alpha = 1;
                                
                                
                            } completion:^(BOOL finished) {
                                
                                self.coverView.hidden = NO;
                                [self addSubview:self.coverView];
                                [UIView animateWithDuration:0.7 animations:^{
                                    // 右移蒙版
                                    CGFloat x = CGRectGetMaxX(self.loadingTitleLabel.frame);
                                    self.coverView.center = CGPointMake(x + 5, self.coverView.center.y);
                                    

                                    
                                } completion:^(BOOL finished) {
                                    
                                    NSTimer *timer =  [NSTimer timerWithTimeInterval:1.1 target:self selector:@selector(changeTextColor) userInfo:nil repeats:YES];
                                    self.timer = timer;
                                    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
                                    
                                    
                                }];
                            }];
        
    }
    
}

- (void)zl_remove{
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });

    // 将原来的titleY保存起来
    CGFloat oY = self.loadingTitleLabel.y;
    // 设置成功标题label,默认隐藏,且在loadingtitle下面
    self.successTitleLabel = [self setUpSuccessLabelWithSuccessTitle:self.successTitle];
    [self addSubview:self.successTitleLabel];
    
    UIView *coverView =  [[UIView alloc] init];
    coverView.size = self.loadingTitleLabel.size;
    coverView.x = self.loadingTitleLabel.x;
    coverView.y = self.loadingTitleLabel.y - self.loadingTitleLabel.size.height;
    coverView.backgroundColor = self.mode.backgroundColor;
    [self addSubview:coverView];
    
    [UIView animateWithDuration:self.mode.time
                          delay:0
         usingSpringWithDamping:self.mode.Damping
          initialSpringVelocity:self.mode.initialSpringVelocity
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         self.loadingTitleLabel.y = coverView.y;
                         self.loadingTitleLabel.alpha = 0;
                         self.successTitleLabel.y = oY;
                         self.successTitleLabel.alpha = 1;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:self.mode.time
                                               delay:0.8
                              usingSpringWithDamping:self.mode.Damping
                               initialSpringVelocity:self.mode.initialSpringVelocity
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              self.alpha = 0;
                                              [self setUpFrameWithStyle];
                                              
                                          } completion:^(BOOL finished) {
                                              [self.timer invalidate];
                                              self.timer = nil;
                                              self.successTitleLabel.alpha = 0;
                                              // 移除成功标题
                                              [self.successTitleLabel removeFromSuperview];
                                              
                                              // 移除蒙版
                                              [coverView removeFromSuperview];
                                              [self.coverView removeFromSuperview];
                                              
                                              // 重新调整loadtitle及蒙板的位置
                                              [self initSelf];
                                              
                                          }];
                     }];
    
}


@end
