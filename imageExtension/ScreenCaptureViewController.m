//
//  ScreenCaptureViewController.m
//  imageExtension
//
//  Created by 毛毛 on 2016/12/20.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import "ScreenCaptureViewController.h"
#import "UIImage+MMExtension.h"

@interface ScreenCaptureViewController ()

@end

@implementation ScreenCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *yellow = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    yellow.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellow];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 220, [UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*0.5)];
    imageView.layer.borderColor = [UIColor blackColor].CGColor;
    imageView.layer.borderWidth = 1.0;
    UIImage *image = [UIImage captureWithView:self.view];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    
}


@end
