//
//  UIImage+Extension.h
//  Xdpx
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum  {
    topToBottom = 0,//从上到下
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
}GradientType;
@interface UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (instancetype)imageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType size:(CGSize)size;

// 指定尺寸 进行图片压缩
+ (NSData *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (NSMutableArray *)gifToArray:(NSData *)data;

/**
 生成二维码
 
 @param dataStr url
 @param logImg log图片或者 本地url
 */
+ (instancetype)qrCodeImage:(NSString *)dataStr
                    logoImg:(id)logImg;
/// 头像变灰
+ (UIImage *)unableImage:(UIImage*)originImage;

/**检测图片中是否有二维码*/
- (void)checkImageHasQrcode:(void (^)(BOOL hasQrcode,NSString *qrText))callback;
@end
