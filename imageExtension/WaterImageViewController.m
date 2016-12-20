//
//  WaterImageViewController.m
//  imageExtension
//
//  Created by 毛毛 on 2016/12/20.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import "WaterImageViewController.h"
#import "UIImage+MMExtension.h"

@interface WaterImageViewController ()

@end

@implementation WaterImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image1 = [UIImage imageNamed:@"2.png"];
    UIImage *image2 = [UIImage imageNamed:@"animation.jpg"];
    UIImage *image3 = [image2 waterImage:image1 anGWPLogoScale:0.5];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 250)];
    imageView1.image = image3;
    [self.view addSubview:imageView1];
    
    UIImage *image4 = [UIImage imageNamed:@"animation.jpg"];
    UIImage *image5 = [UIImage waterImageWithBackgroundImage:image4 andText:@"你好" andTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter" size:20],NSForegroundColorAttributeName : [UIColor whiteColor]}];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 370, 200, 250)];
    imageView2.image = image5;
    [self.view addSubview:imageView2];
    
}

@end
