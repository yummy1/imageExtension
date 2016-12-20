//
//  ChangeSizeViewController.m
//  imageExtension
//
//  Created by 毛毛 on 2016/12/20.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import "CutImageViewController.h"
#import "UIImage+MMExtension.h"

@interface CutImageViewController ()

@end

@implementation CutImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    UIImage *image = [UIImage imageNamed:@"animation.jpg"];
    UIImage *newImg = [image cutImageWithRect:CGRectMake(50, 100, 150, 150)];
    imageView.image = newImg;
    [self.view addSubview:imageView];
    
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 220, 100, 100)];
//    UIImage *image1 = [UIImage imageNamed:@"animation.jpg"];
//    UIImage *newImg1 = [image1 circleWithBoardWidth:2.0 boardColor:[UIColor redColor]];
    UIImage *newImg1 = [UIImage circleWithImageName:@"animation.jpg" boardWidth:3.0 boardColor:[UIColor redColor]];
    imageView1.image = newImg1;
    [self.view addSubview:imageView1];
    
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 340, 100, 100)];
//    UIImage *image2 = [UIImage imageNamed:@"animation.jpg"];
//    UIImage *newImg2 = [image2 roundRectWithRadius:5.0];
    UIImage *newImg2 = [UIImage roundRectWithName:@"animation.jpg" radius:15.0];
    imageView2.image = newImg2;
    [self.view addSubview:imageView2];
    
    
    
        
    
}


@end
