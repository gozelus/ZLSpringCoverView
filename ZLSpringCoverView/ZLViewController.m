//
//  ZLViewController.m
//  ZLSpringCoverView
//
//  Created by Mac on 16/3/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ZLViewController.h"
#import "UIView+Frame.h"
#import "UIViewController+ZLSpringCoverView.h"



@interface ZLViewController ()


@property (nonatomic, strong) UIButton *butn;

@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

@end

@implementation ZLViewController
- (IBAction)defaultSytle {
    
    
    ZLViewParaMode *mode = [[ZLViewParaMode alloc] init];
    mode.backgroundColor = [UIColor blackColor];
    
    self.springCoverView.style = ZLSpringCoverViewStyleDefault;
    self.springCoverView.mode = mode;
    self.springCoverView.loadingTitle = @"StyleDefault";
    
    [self.springCoverView zl_show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.springCoverView zl_remove];
    });

    
}
- (IBAction)bottomSytle:(id)sender {
    
    ZLViewParaMode *mode = [[ZLViewParaMode alloc] init];
    mode.backgroundColor = [UIColor redColor];
    mode.Damping = 0.2;
    mode.initialSpringVelocity = 0;
    self.springCoverView.style = ZLSpringCoverViewStyleBottom;
    self.springCoverView.mode = mode;
    self.springCoverView.loadingTitle = @"StyleBottom";
    [self.springCoverView zl_show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.springCoverView zl_remove];
    });
    

}
- (IBAction)leftSytle:(id)sender {
    
    ZLViewParaMode *mode = [[ZLViewParaMode alloc] init];
    mode.backgroundColor = [UIColor orangeColor];
    mode.Damping = 0.4;
    self.springCoverView.style = ZLSpringCoverViewStyleLeft;
    self.springCoverView.mode = mode;
    self.springCoverView.loadingTitle = @"StyleBottom";
    [self.springCoverView zl_show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.springCoverView zl_remove];
    });

}
- (IBAction)rightSytle:(id)sender {
    
    ZLViewParaMode *mode = [[ZLViewParaMode alloc] init];
    mode.backgroundColor = [UIColor blueColor];
    mode.Damping = 0.5;
    self.springCoverView.style = ZLSpringCoverViewStyleRight;
    self.springCoverView.mode = mode;
    
    self.springCoverView.loadingTitle = @"StyleRight";
    [self.springCoverView zl_show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.springCoverView zl_remove];
    });

}
- (IBAction)fadeSytle:(id)sender {
    
    ZLViewParaMode *mode = [[ZLViewParaMode alloc] init];
    mode.backgroundColor = [UIColor purpleColor];
    self.springCoverView.style = ZLSpringCoverViewStyleFade;
    self.springCoverView.mode = mode;
    
    self.springCoverView.loadingTitle = @"StyleFade";
    [self.springCoverView zl_show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.springCoverView zl_remove];
    });

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.springCoverView = [ZLSpringCoverView zl_progressViewWithLoadingTitle:@"loading.." successTitle:@"success" vc:self style:ZLSpringCoverViewStyleDefault mode:nil];
    [self.springCoverView zl_show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.springCoverView zl_remove];
    });

    
    
}
@end
