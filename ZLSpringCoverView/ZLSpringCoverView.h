//
//  ZLSpringCoverView.h
//  ZLSpringCoverView
//
//  Created by Mac on 16/3/26.
//  Copyright © 2016年 Mac. All rights reserved.
//  弹性蒙版展示动画，只需一行代码即可随时展示蒙板，去掉蒙板。

#import <UIKit/UIKit.h>
#import "ZLViewParaMode.h"

typedef NS_ENUM(NSUInteger,ZLSpringCoverViewStyle){
    
    /**默认竖直下降*/
    ZLSpringCoverViewStyleDefault = 1,
    /**从左侧滑出*/
    ZLSpringCoverViewStyleLeft,
    /**从右侧侧滑出*/
    ZLSpringCoverViewStyleRight,
    /**从底部滑出*/
    ZLSpringCoverViewStyleBottom,
    /**直接淡入淡出*/
    ZLSpringCoverViewStyleFade,
    
};


@interface ZLSpringCoverView : UIView


/**设置滑出风格 默认竖直下降*/
@property (nonatomic, assign) ZLSpringCoverViewStyle style;

/**这个属性决定加载数据时蒙版的标题*/
@property (nonatomic, copy) NSString *loadingTitle;

/**这个属性决定加载数据成功蒙版的标题*/
@property (nonatomic, copy) NSString *successTitle;

/**动画的参数模型*/
@property (nonatomic, strong) ZLViewParaMode *mode;




/**建议直接使用这个类方法生成ZlSpringCoverView。mode,style均可以不设置，会自动初始值*/
+ (instancetype)zl_progressViewWithLoadingTitle:(NSString *)loadingTitle successTitle:(NSString *)successTitle vc:(UIViewController *)vc style:(ZLSpringCoverViewStyle)style mode:(ZLViewParaMode *)mode;


/**调用此方法 蒙版将出现*/
- (void)zl_show;

/**数据回来时 调用此方法 蒙版消失*/
- (void)zl_remove;



@end
