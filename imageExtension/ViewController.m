//
//  ViewController.m
//  imageExtension
//
//  Created by 毛毛 on 2016/12/20.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import "ViewController.h"
#import "ColorToImageViewController.h"
#import "CutImageViewController.h"
#import "ScreenCaptureViewController.h"
#import "WaterImageViewController.h"
#import "BlurImageViewController.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *dataArr;
@end

@implementation ViewController

- (NSArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = @[@"颜色生成图片", @"裁剪图片", @"截屏", @"水印文字、图片", @"生成模糊图片"];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - UITableViewDataSource  Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            ColorToImageViewController *vc1 = [[ColorToImageViewController alloc] init];
            [self.navigationController pushViewController:vc1 animated:YES];
        }
            break;
        case 1:
        {
            CutImageViewController *vc2 = [[CutImageViewController alloc] init];
            [self.navigationController pushViewController:vc2 animated:YES];
        }
            break;
        case 2:
        {
            ScreenCaptureViewController *vc3 = [[ScreenCaptureViewController alloc] init];
            [self.navigationController pushViewController:vc3 animated:YES];
        }
            break;
        case 3:
        {
            WaterImageViewController *vc4 = [[WaterImageViewController alloc] init];
            [self.navigationController pushViewController:vc4 animated:YES];
        }
            break;
        case 4:
        {
            BlurImageViewController *vc4 = [[BlurImageViewController alloc] init];
            [self.navigationController pushViewController:vc4 animated:YES];
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
        default:
            break;
    }
}
@end
