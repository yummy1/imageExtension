//
//  UIImage+MMExtension.m
//  imageExtension
//
//  Created by 毛毛 on 2016/12/20.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import "UIImage+MMExtension.h"
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (MMExtension)
#pragma mark 由颜色值生成图片
/**
 *  由颜色值生成图片
 *
 *  @param color 颜色
 *  @param size  图片大小
 *
 *  @return 生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
#pragma mark 将图片压缩到指定大小
/**
 *  将图片压缩到指定大小 filesize
 *
 *  @param image       图片
 *  @param maxFileSize 指定大小
 *
 *  @return 压缩后的图片的二进制文件
 */
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    return imageData;
}
#pragma mark 裁剪图片指定区域
/**
 *  裁剪图片指定区域
 *
 *  @param rect 指定区域
 *
 *  @return 裁剪后的图片
 */
- (instancetype)cutImageWithRect:(CGRect)rect{
    CGRect drawRect = CGRectMake(-rect.origin.x , -rect.origin.y, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    [self drawInRect:drawRect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark 裁剪成圆形图片
/**
 *  裁剪成圆形图片
 *
 *  @param boardWidth     边框宽度
 *  @param boardColor 边框颜色
 *
 *  @return 裁剪后的圆形图片
 */
- (instancetype)circleWithBoardWidth:(CGFloat)boardWidth boardColor:(UIColor *)boardColor{
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width + boardWidth*2, self.size.height + boardWidth*2), NO, 0.0);
    
    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 画大圆(裁剪路径，这个图形是什么样子，裁剪后的图像的边框就是什么样子)
    [boardColor set];
    CGRect outsideCircle = CGRectMake(0, 0, self.size.width + boardWidth*2, self.size.height + boardWidth*2);
    CGContextAddEllipseInRect(ctx, outsideCircle);
    // 输出大圆
    CGContextFillPath(ctx);
    
    // 画圆(裁剪路径，这个图形是什么样子，裁剪后的图像就是什么样子)
    CGRect insideCircle = CGRectMake(boardWidth, boardWidth, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, insideCircle);
    // 裁剪
    CGContextClip(ctx);
    
    // 将原图画上去
    [self drawInRect:insideCircle];
    
    // 获取新图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
#pragma mark 根据文件名裁剪圆形图片
/**
 *  根据文件名裁剪圆形图片
 *
 *  @param name       图片文件名
 *  @param boardWidth 边框宽度
 *  @param boardColor 边框颜色
 *
 *  @return 裁剪后的圆形图片
 */
+ (instancetype)circleWithImageName:(NSString *)name boardWidth:(CGFloat)boardWidth boardColor:(UIColor *)boardColor{
    UIImage *image = [UIImage imageNamed:name];
    return [image circleWithBoardWidth:boardWidth boardColor:boardColor];
}
#pragma mark 裁剪成圆角矩形图片
/**
 *  裁剪成圆角矩形图片
 *
 *  @param radius 圆角半径
 *
 *  @return 裁剪后的圆角矩形图片
 */
- (instancetype)roundRectWithRadius:(CGFloat)radius{
    UIImage *icon = self;
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(icon.size, NO, 0.0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 画裁剪路径
    CGContextAddArc(ctx, radius, radius, radius, -M_PI_2, M_PI, 1);      // 左上角弧线
    CGContextAddLineToPoint(ctx, 0, icon.size.height-radius);           // 左线
    CGContextAddArc(ctx, radius, icon.size.height-radius, radius, M_PI, M_PI_2, 1);       // 左下角弧线
    CGContextAddLineToPoint(ctx, icon.size.width-radius, icon.size.height);                 // 下线
    CGContextAddArc(ctx, icon.size.width-radius, icon.size.height-radius, radius, M_PI_2, 0, 1);    // 右下角弧线
    CGContextAddLineToPoint(ctx, icon.size.width, radius);              // 右线
    CGContextAddArc(ctx, icon.size.width-radius, radius, radius, 0, -M_PI_2, 1);     // 右下角弧线
    CGContextClosePath(ctx);
    
    CGContextClip(ctx);
    
    [icon drawInRect:CGRectMake(0, 0, icon.size.width, icon.size.height)];
    
    UIImage *new = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return new;
    
}
#pragma mark 根据图片名裁剪圆角图片
/**
 *  根据图片名裁剪圆角图片
 *
 *  @param name   图片名
 *  @param radius 圆角半径
 *
 *  @return 裁剪后的圆角矩形图片
 */
+ (instancetype)roundRectWithName:(NSString *)name radius:(CGFloat)radius{
    UIImage *image = [UIImage imageNamed:name];
    return [image roundRectWithRadius:radius];
}
#pragma mark 不改变图片边框的拉伸图片
/**
 *  不改变图片边框的拉伸图片
 *
 *
 *  @return 拉伸后的新图
 */
- (instancetype)resizeableImage{
    UIImage *img = self;
    CGFloat w = img.size.width/2;
    CGFloat h = img.size.height/2;
    return [img stretchableImageWithLeftCapWidth:w topCapHeight:h];
}
#pragma mark 以主色作为背景色，无拉伸增大图片；可以用来给图片加矩形相框
/**
 *  以主色作为背景色，无拉伸增大图片；可以用来给图片加矩形相框
 *
 *  @param bgColor 新图片背景色
 *  @param size    新图片的大小
 *
 *  @return 返回增大处理后的图片
 */
- (instancetype)expansionWithBackground:(UIColor *)bgColor newSize:(CGSize)size{
    UIImage *image = self;
    // 开启图形上下文
    UIGraphicsBeginImageContext(size);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置背景色
    [bgColor set];
    
    // 画出背景矩形
    CGContextAddRect(ctx, CGRectMake(0, 0, size.width, size.height));
    
    // 渲染
    CGContextFillPath(ctx);
    
    // 无拉伸的将图片画上去
    CGFloat imgX = (size.width - image.size.width)/2;
    CGFloat imgY = (size.height - image.size.height)/2;
    [image drawInRect:CGRectMake(imgX, imgY, image.size.width, image.size.height)];
    
    // 取出图形上下文中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    // 返回处理后的图片
    return newImage;
}
#pragma mark 截屏
/**
 *
 *  @param view 需要截取的View
 *
 *  @return 截取获得的的图片
 */
+ (instancetype)captureWithView:(UIView *)view{
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    // 将self.view.layer渲染到上下文中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 取出上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    // 返回
    return image;
}
#pragma mark 加水印（图片）
/**
 *  @param waterImage   背景图片（就是衬在下面的图片）
 *  @param scale     logo图片的缩放比例
 *
 *  @return 加过水印之后的新图片
 */
- (instancetype)waterImage:(UIImage *)waterImage anGWPLogoScale:(CGFloat)scale{
    UIImage *bgImage = self;
    // 获取上下文
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    
    // 画背景大图
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    // 画Logo
    UIImage *logo = waterImage;
    
    CGFloat margin = 5;
    CGFloat logoW = logo.size.width * scale;
    CGFloat logoH = logo.size.height * scale;
    CGFloat logoX = bgImage.size.width - logoW - margin;
    CGFloat logoY = bgImage.size.height - logoH - margin;
    [logo drawInRect:CGRectMake(logoX, logoY, logoW, logoH)];
    
    // 从上下文中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
#pragma mark 加水印（文字）
/**
 *  加水印（文字）
 *
 *  @param bgImage   背景图片（就是衬在下面的图片）
 *  @param text       水印文字
 *  @param attributes 水印文字的属性
 *
 *  @return 加过水印之后的新图片
 *
 *  *****************************  示例代码  ***************************************
 *
 *  NSDictionary *attrs = @{
 *  NSFontAttributeName : [UIFont boldSystemFontOfSize:8],
 *  NSForegroundColorAttributeName : [UIColor whiteColor]
 *  };
 *  UIImage *lastImage = [UIImage waterImageWithBackgroundImage:[UIImage imageNamed:@"scene"] andText:@"大熊出品出品出品出品大熊出品出品出品出品大熊出品出品出品出品" andTextAttributes:attrs];
 
 *  // 输出到屏幕上
 *  _imgView.image = lastImage;
 *  *****************************  示例end  ***************************************
 */
+ (instancetype)waterImageWithBackgroundImage:(UIImage *)bgImage andText:(NSString *)text andTextAttributes:(NSDictionary *)attributes{
    // 获取上下文
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    
    // 画背景大图
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    // 画text
    CGFloat margin = 5;
    // size是允许的最大宽度高度
    CGSize maxSize = CGSizeMake(bgImage.size.width-2*margin, bgImage.size.height-2*margin);
    // attrs是字体属性
    NSDictionary *attrs = attributes;
    // 计算字符串宽度高度的函数
    CGSize textSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    CGFloat textX = bgImage.size.width - textSize.width - margin;
    CGFloat textY = bgImage.size.height - textSize.height - margin;
    CGFloat textW = textSize.width;
    CGFloat textH = textSize.height;
    CGRect textRect = CGRectMake(textX, textY, textW, textH);
    [text drawInRect:textRect withAttributes:attrs];
    
    // 从上下文中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
#pragma mark 截屏
/**
 *  截屏
 *
 *  @return 返回截取的屏幕的图像
 */
+ (UIImage *)hd_screenShot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            CGContextConcatCTM(context, [window transform]);
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark 生成毛玻璃效果的图片
/**
 *  生成毛玻璃效果的图片
 *
 *  @param image      要模糊化的图片
 *  @param blurAmount 模糊化指数
 *
 *  @return 返回模糊化之后的图片
 */
+ (UIImage *)hd_blurredImageWithImage:(UIImage *)image andBlurAmount:(CGFloat)blurAmount
{
    return [image hd_blurredImage:blurAmount];
}
#pragma mark 返回毛玻璃效果的图片
/**
 *  返回毛玻璃效果的图片
 *
 *  @param blurAmount 模糊化指数
 */
- (UIImage*)hd_blurredImage:(CGFloat)blurAmount
{
    if (blurAmount < 0.0 || blurAmount > 2.0) {
        blurAmount = 0.5;
    }
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    int boxSize = blurAmount * 40;
    boxSize = boxSize - (boxSize % 2) + 1;
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (!error)
    {
        //        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}
#pragma mark 图形模糊算法
/**
 *  图形模糊算法
 *
 *  @param blurLevel 模糊的级别
 *
 *  @return 模糊好的图片
 */
- (UIImage *)hd_blearImageWithBlurLevel:(CGFloat)blurLevel
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setDefaults];
    [blurFilter setValue:inputImage forKey:@"inputImage"];
    //设值模糊的级别
    [blurFilter setValue:[NSNumber numberWithFloat:blurLevel] forKey:@"inputRadius"];
    CIImage *outputImage = [blurFilter valueForKey:@"outputImage"];
    CGRect rect = inputImage.extent;    // Create Rect
    //设值一下 减到图片的白边
    rect.origin.x += blurLevel;
    rect.origin.y += blurLevel;
    rect.size.height -= blurLevel * 2.0f;
    rect.size.width -= blurLevel * 2.0f;
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:rect];
    //获取新的图片
    UIImage *newImage = [UIImage imageWithCGImage:cgImage scale:0.5 orientation:self.imageOrientation];
    //释放图片
    CGImageRelease(cgImage);
    
    return newImage;
}
#pragma mark 仿微信红包的模糊效果（最低适配iOS8）
/**
 *  仿微信红包的模糊效果（最低适配iOS8）
 *
 *  @param isBlurry 是否模糊
 *
 */
- (void)hd_Image:(UIImageView *)imageView isBlurry:(BOOL)isBlurry alpha:(NSInteger)alpha
{
    NSArray *subViews = imageView.subviews;
    UIVisualEffectView *effectView = nil;
    for (int i=0; i<subViews.count; i++) {
        if ([subViews[i] isKindOfClass:[UIVisualEffectView class]]) {
            effectView = subViews[i];
            return;
        }
    }
    if (isBlurry) {
        //要模糊
        if (!effectView) {
            UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:beffect];
            effectView.frame = imageView.bounds;
            if (alpha) {
                effectView.alpha = alpha;
            }else{
                effectView.alpha = 1.0;
            }
            [imageView addSubview:effectView];
        }
    }else{
        //不模糊
        if (effectView) {
            [effectView removeFromSuperview];
        }
    }
}
#pragma mark 字符串转图片
/**
 *  字符串转图片
 */
-(UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr
{
    NSData *_decodedImageData   = [[NSData alloc] initWithBase64EncodedString:_encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}

@end
