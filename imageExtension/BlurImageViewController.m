//
//  BlurImageViewController.m
//  imageExtension
//
//  Created by 毛毛 on 2016/12/20.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import "BlurImageViewController.h"
#import "UIImage+MMExtension.h"

@interface BlurImageViewController ()

@end

@implementation BlurImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"animation.jpg"];
//    UIImage *blurImage = [UIImage hd_blurredImageWithImage:image andBlurAmount:1.0];
    UIImage *blurImage = [image hd_blurredImage:2.0];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 150, 170)];
    imageView.image = blurImage;
    [self.view addSubview:imageView];
    
    
    UIImage *image1 = [UIImage imageNamed:@"animation.jpg"];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 300, 150, 170)];
    imageView1.image = image1;
    [image1 hd_Image:imageView1 isBlurry:YES alpha:0.1];
    [self.view addSubview:imageView1];
}


@end
