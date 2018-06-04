//
//  ViewController.m
//  TestReDianViewLayout
//
//  Created by pxx on 2018/3/16.
//  Copyright © 2018年 平晓行. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()
{
    CGFloat oldHeight;
}
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UILabel *logLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1,利用frame布局
    CGFloat height = self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width;
    oldHeight = height;
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(10, height-40, width-20, 40)];
    self.bottomView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.bottomView];
//    监听状态栏改变的通知 UIApplicationDidChangeStatusBarFrameNotification
    [[ NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutControllerSubViews:) name: UIApplicationDidChangeStatusBarFrameNotification object : nil ];
    
    //2利用mas布局
//    self.bottomView = [UIView new];
//    self.bottomView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.bottomView];
//    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(10);
//        make.right.equalTo(self.view).offset(-10);
//        make.height.mas_equalTo(40);
//        make.bottom.equalTo(self.view.mas_bottom);
//    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(200);
//        }];
//    });
    
//    [UIView animateWithDuration:4 animations:^{
//        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(200);
//        }];
//    }];
    
    
    self.logLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 200)];
    self.logLabel.backgroundColor = [UIColor yellowColor];
    self.logLabel.numberOfLines = 0;
    self.logLabel.text = @"显示self.view.frame信息";
    [self.view addSubview:self.logLabel];
}

- (void)layoutControllerSubViews:(NSNotification *)sender
{
    NSLog(@"%@" , sender.userInfo);
    self.logLabel.text = [NSString stringWithFormat:@"%f"  ,self.view.frame.size.height];
    
    //当状态栏的高度变化后，因为view的高度会变小20，所以要重新获取view的高度刷新子视图的高度
    CGFloat newHeight = self.view.frame.size.height;
    
    CGRect frame = self.bottomView.frame;
    frame.origin.y += newHeight-oldHeight;
    self.bottomView.frame = frame;
    
    oldHeight = newHeight;
}


//3
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    NSLog(@"触发了viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    NSLog(@"触发了viewDidLayoutSubviews");
}


@end
