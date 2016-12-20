//
//  ColorToImageViewController.m
//  imageExtension
//
//  Created by 毛毛 on 2016/12/20.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import "ColorToImageViewController.h"
#import "UIImage+MMExtension.h"

@interface ColorToImageViewController ()

@end

@implementation ColorToImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
    imageView.image = [UIImage imageWithColor:[UIColor blueColor] size:CGSizeMake(200, 200)];
    [self.view addSubview:imageView];
}


@end
