//
//  UIImage+UIExtension.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/30.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "UIImage+UIExtension.h"
#import "UIColor+UIExtension.h"
#import <ImageIO/ImageIO.h>

CG_INLINE CGSize
CGSizeFlatSpecificScale(CGSize size, float scale) {
    return CGSizeMake(flatSpecificScale(size.width, scale), flatSpecificScale(size.height, scale));
}


@implementation UIImage (UIExtension)
- (UIImage *)yt_imageWithAlpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextInspectContext(context);
    CGRect drawRect = CGRectMake(0, 0, self.size.width, self.size.height);
    [self drawInRect:drawRect blendMode:kCGBlendModeNormal alpha:alpha];
    UIImage *imageOut =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}

- (BOOL)yt_opaque {
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
    BOOL opaque = alphaInfo == kCGImageAlphaNoneSkipLast
                  || alphaInfo == kCGImageAlphaNoneSkipFirst
                  || alphaInfo == kCGImageAlphaNone;
    return opaque;
}

- (UIImage *)yt_imageWithTintColor:(UIColor *)tintColor {
    UIImage *imageIn = self;
    CGRect rect = CGRectMake(0, 0, imageIn.size.width, imageIn.size.height);
    UIGraphicsBeginImageContextWithOptions(imageIn.size, self.yt_opaque, imageIn.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextInspectContext(context);
    CGContextTranslateCTM(context, 0, imageIn.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextClipToMask(context, rect, imageIn.CGImage);
    CGContextSetFillColorWithColor(context, tintColor.CGColor);
    CGContextFillRect(context, rect);
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}

- (UIImage *)yt_imageWithClippedRect:(CGRect)rect {
    CGContextInspectSize(rect.size);
    CGRect imageRect = CGRectMakeWithSize(rect.size);
    if (CGRectContainsRect(rect, imageRect)) {
        //裁剪区域比自身大,所以返回不用直接裁剪
        return self;
    }
    // 由于CGImage是以pixel为单位来计算的，而UIImage是以point为单位，所以这里需要将传进来的point转换为pixel
    CGRect scaledRect = CGRectApplyScale(rect, self.scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, scaledRect);
    UIImage *imageOut = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return imageOut;
}

- (UIImage *)yt_imageWithOrientation:(UIImageOrientation)orientation {
    if(orientation == UIImageOrientationUp) {
        return self;
    }
    
    CGSize contextSize = self.size;
    if (orientation == UIImageOrientationLeft || orientation == UIImageOrientationRight) {
        contextSize = CGSizeMake(contextSize.height, contextSize.width);
    }

    contextSize = CGSizeFlatSpecificScale(contextSize, self.scale);
    UIGraphicsBeginImageContextWithOptions(contextSize, self.yt_opaque, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextInspectContext(context);
    contextSize = CGSizeFlatSpecificScale(contextSize, self.scale);
    //画布原点在做商家 旋转之后有些会偏出画布 需要做处理
    switch (orientation) {
        case UIImageOrientationUp:
            
            break;
        case UIImageOrientationDown:
            CGContextTranslateCTM(context, contextSize.width, contextSize.height);
            CGContextRotateCTM(context, AngleWithDegrees(180));
            break;
        case UIImageOrientationLeft:
            CGContextTranslateCTM(context, 0, contextSize.height);
            CGContextRotateCTM(context, AngleWithDegrees(180));
            break;
        case UIImageOrientationRight:
            CGContextTranslateCTM(context, contextSize.width, 0);
            CGContextRotateCTM(context, AngleWithDegrees(180));
            break;
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            // 向上、向下翻转是一样的
            CGContextTranslateCTM(context, 0, contextSize.height);
            CGContextScaleCTM(context, 1, -1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            // 向左、向右翻转是一样的
            CGContextTranslateCTM(context, contextSize.width, 0);
            CGContextScaleCTM(context, -1, 1);
            break;

    }
    [self drawInRect:CGRectMakeWithSize(self.size)];
    
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}

- (UIImage *)yt_imageWithBorderColor:(UIColor *)borderColor path:(UIBezierPath *)path{
    if (!borderColor) {
        return self;
    }
    
    UIImage *oldImage = self;
    UIImage *resultImage;
    CGRect rect = CGRectMakeWithSize(oldImage.size);
    UIGraphicsBeginImageContextWithOptions(oldImage.size, self.yt_opaque, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextInspectContext(context);
    [oldImage drawInRect:rect];
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    [path stroke];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
    
}

- (UIImage *)yt_imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius dashedLengths:(const CGFloat *)dashedLengths {
    if (!borderColor || !borderWidth) {
        return self;
    }
    
    UIBezierPath *path;
    CGRect rect = CGRectInset(CGRectMakeWithSize(self.size), borderWidth / 2, borderWidth / 2);
    if (cornerRadius > 0) {
        path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    }else {
        path = [UIBezierPath bezierPathWithRect:rect];
    }
    
    path.lineWidth = borderWidth;
    if (dashedLengths) {
        [path setLineDash:dashedLengths count:2 phase:0];
    }
    return [self yt_imageWithBorderColor:borderColor path:path];
}

- (UIImage *)yt_imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius{
  return [self yt_imageWithBorderColor:borderColor borderWidth:borderWidth cornerRadius:cornerRadius dashedLengths:0];
}

- (UIImage *)yt_imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth borderPosition:(YTUIImageBorderPosition)borderPosition{
    if (borderPosition == YTUIImageBorderPositionAll) {
        return [self yt_imageWithBorderColor:borderColor borderWidth:borderWidth cornerRadius:0];
    }else {
        
         UIBezierPath* path = [UIBezierPath bezierPath];
        if ((YTUIImageBorderPositionTop & borderPosition) == YTUIImageBorderPositionTop) {
            [path moveToPoint:CGPointMake(0, borderWidth / 2)];
            [path addLineToPoint:CGPointMake(self.size.width, borderWidth / 2)];
        }
        if ((YTUIImageBorderPositionBottom & borderPosition) == YTUIImageBorderPositionBottom) {
            [path moveToPoint:CGPointMake(0, self.size.height - borderWidth / 2)];
            [path addLineToPoint:CGPointMake(self.size.width, self.size.height - borderWidth / 2)];
        }
        if ((YTUIImageBorderPositionLeft & borderPosition) == YTUIImageBorderPositionLeft) {
            [path moveToPoint:CGPointMake(borderWidth / 2, 0)];
            [path addLineToPoint:CGPointMake(borderWidth / 2, self.size.height)];
        }
        if ((YTUIImageBorderPositionRight & borderPosition) == YTUIImageBorderPositionRight) {
            [path moveToPoint:CGPointMake(self.size.width - borderWidth / 2, 0)];
            [path addLineToPoint:CGPointMake(self.size.width - borderWidth / 2, self.size.height)];
        }
        [path setLineWidth:borderWidth];
        [path closePath];
        return [self yt_imageWithBorderColor:borderColor path:path];
    }
    return self;
}

+ (UIImage *)yt_imageWithColor:(UIColor *)color {
    return [UIImage yt_imageWithColor:color size:CGSizeMake(1, 1) cornerRadius:0];
}

+ (UIImage *)yt_imageStartColor:(UIColor *)startColor endColor:(UIColor *)endColor rect:(CGRect)rect isLineer:(BOOL)isLineer{
    if (!endColor || !startColor || CGSizeIsEmpty(rect.size)) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, ScreenScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextInspectContext(context);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y);
    CGPathAddLineToPoint(path, NULL, rect.size.width, rect.origin.y);
    CGPathAddLineToPoint(path, NULL, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.size.height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0,1.0};
    NSArray *colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect),CGRectGetMinY(pathRect));
//    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect),CGRectGetMaxY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect),isLineer ? CGRectGetMinY(pathRect) : CGRectGetMaxY(pathRect));
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);

    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGPathRelease(path);
    
    UIImage *outImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outImage;
}



+ (UIImage *)yt_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    size = CGSizeFlatted(size);
    CGContextInspectSize(size);
    UIImage *resultImage = nil;
    color = color ? color : [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    BOOL opaque = (cornerRadius == 0.0 && [color yt_alpha] == 1.0);
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    if (cornerRadius > 0) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMakeWithSize(size) cornerRadius:cornerRadius];
        [path addClip];
        [path fill];
    }else {
        CGContextFillRect(context, CGRectMakeWithSize(size));
    }
    
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}


+ (UIImage *)yt_imageWithShape:(YTUIImageShape)shape size:(CGSize)size lineWidth:(CGFloat)lineWidth tintColor:(UIColor *)tintColor {
    size = CGSizeFlatted(size);
    CGContextInspectSize(size);
    
    UIImage *resultImage = nil;
    tintColor = tintColor ? : [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextInspectContext(context);
    UIBezierPath *path = nil;
    BOOL drawByStroke = NO;
    CGFloat drawOffset = lineWidth / 2;
    switch (shape) {
        case YTUIImageShapeOval: {
            path = [UIBezierPath bezierPathWithOvalInRect:CGRectMakeWithSize(size)];
        }
            break;
        case YTUIImageShapeTriangle: {
            path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, size.height)];
            [path addLineToPoint:CGPointMake(size.width / 2, 0)];
            [path addLineToPoint:CGPointMake(size.width, size.height)];
            [path closePath];
        }
            break;
        case YTUIImageShapeNavBack: {
            drawByStroke = YES;
            path = [UIBezierPath bezierPath];
            path.lineWidth = lineWidth;
            [path moveToPoint:CGPointMake(size.width - drawOffset, drawOffset)];
            [path addLineToPoint:CGPointMake(0 + drawOffset, size.height / 2.0)];
            [path addLineToPoint:CGPointMake(size.width - drawOffset, size.height - drawOffset)];
        }
            break;
        case YTUIImageShapeDisclosureIndicator: {
            drawByStroke = YES;
            path = [UIBezierPath bezierPath];
            path.lineWidth = lineWidth;
            [path moveToPoint:CGPointMake(drawOffset, drawOffset)];
            [path addLineToPoint:CGPointMake(size.width - drawOffset, size.height / 2)];
            [path addLineToPoint:CGPointMake(drawOffset, size.height - drawOffset)];
        }
            break;
        case YTUIImageShapeCheckmark: {
            CGFloat lineAngle = M_PI_4;
            path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, size.height / 2)];
            [path addLineToPoint:CGPointMake(size.width / 3, size.height)];
            [path addLineToPoint:CGPointMake(size.width, lineWidth * sin(lineAngle))];
            [path addLineToPoint:CGPointMake(size.width - lineWidth * cos(lineAngle), 0)];
            [path addLineToPoint:CGPointMake(size.width / 3, size.height - lineWidth / sin(lineAngle))];
            [path addLineToPoint:CGPointMake(lineWidth * sin(lineAngle), size.height / 2 - lineWidth * sin(lineAngle))];
            [path closePath];
        }
            break;
        case YTUIImageShapeDetailButtonImage: {
            drawByStroke = YES;
            path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectMakeWithSize(size), drawOffset, drawOffset)];
            path.lineWidth = lineWidth;
        }
            break;
        case YTUIImageShapeNavClose: {
            drawByStroke = YES;
            path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(size.width, size.height)];
            [path closePath];
            [path moveToPoint:CGPointMake(size.width, 0)];
            [path addLineToPoint:CGPointMake(0, size.height)];
            [path closePath];
            path.lineWidth = lineWidth;
            path.lineCapStyle = kCGLineCapRound;
        }
            break;
        default:
            break;
    }
    
    if (drawByStroke) {
        CGContextSetStrokeColorWithColor(context, tintColor.CGColor);
        [path stroke];
    } else {
        CGContextSetFillColorWithColor(context, tintColor.CGColor);
        [path fill];
    }
    
    if (shape == YTUIImageShapeDetailButtonImage) {
        CGFloat fontPointSize = flat(size.height * 0.8);
        UIFont *font = [UIFont fontWithName:@"Georgia" size:fontPointSize];
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"i" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: tintColor}];
        CGSize stringSize = [string boundingRectWithSize:size options:NSStringDrawingUsesFontLeading context:nil].size;
        [string drawAtPoint:CGPointMake(CGFloatGetCenter(size.width, stringSize.width), CGFloatGetCenter(size.height, stringSize.height))];
    }
    
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

+ (UIImage *)yt_imageWithShape:(YTUIImageShape)shape size:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat lineWidth = 0;
    switch (shape) {
        case YTUIImageShapeNavBack:
            lineWidth = 2.0f;
            break;
        case YTUIImageShapeDisclosureIndicator:
            lineWidth = 1.5f;
            break;
        case YTUIImageShapeCheckmark:
            lineWidth = 1.5f;
            break;
        case YTUIImageShapeDetailButtonImage:
            lineWidth = 1.0f;
            break;
        case YTUIImageShapeNavClose:
            lineWidth = 1.2f;   // 取消icon默认的lineWidth
            break;
        default:
            break;
    }
    return [UIImage yt_imageWithShape:shape size:size lineWidth:lineWidth tintColor:tintColor];
}

+ (UIImage *)yt_imageWithView:(UIView *)view {
    CGContextInspectSize(view.bounds.size);
    UIImage *resultImage = nil;
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextInspectContext(context);
    [view.layer renderInContext:context];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)imageWithRenderOriginalName:(NSString *)name
{
    UIImage *image=[UIImage imageNamed:name];
    //返回一张不被渲染的图片
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end


@implementation UIImage (gif)

static NSTimeInterval CGImageSourceGetGIFFrameDelayAtIndex(CGImageSourceRef source, size_t index) {
    NSTimeInterval delay = 0;
    CFDictionaryRef dic = CGImageSourceCopyPropertiesAtIndex(source, index, NULL);
    if (dic) {
        CFDictionaryRef dicGIF = CFDictionaryGetValue(dic, kCGImagePropertyGIFDictionary);
        if (dicGIF) {
            NSNumber *num = CFDictionaryGetValue(dicGIF, kCGImagePropertyGIFUnclampedDelayTime);
            if (num.doubleValue <= __FLT_EPSILON__) {
                num = CFDictionaryGetValue(dicGIF, kCGImagePropertyGIFDelayTime);
            }
            delay = num.doubleValue;
        }
        CFRelease(dic);
    }
    

    if (delay < 0.02) delay = 0.1;
    return delay;
}



+ (nullable UIImage *)imageWithSmallCIFData:(NSData *)data scale:(CGFloat)scale {
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFTypeRef)data, NULL);
    if (!source) {
        return nil;
    }
    
    size_t count = CGImageSourceGetCount(source);
    if (count <= 1) {
        CFRelease(source);
        return [[self class] imageWithSmallCIFData:data scale:scale];
    }
    
    NSUInteger frames[count];
    double oneFrameTime = 1 / 50;
    NSTimeInterval totalTime = 0;
    NSUInteger totalFrame = 0;
    NSUInteger gcdFrame = 0;
    for (size_t i = 0; i < count; i ++) {
        NSTimeInterval delay  = CGImageSourceGetGIFFrameDelayAtIndex(source, i);
        totalTime += delay;
        NSInteger frame = lrint(delay / oneFrameTime);
        if (frame < 1) frame = 1;
        frames[i] = frame;
        totalFrame += frames[i];
        if (i == 0) gcdFrame = frames[i];
        else {
            NSUInteger frame = frames[i], tmp;
            if (frame < gcdFrame) {
                tmp = frame; frame = gcdFrame; gcdFrame = tmp;
            }
            while (true) {
                tmp = frame % gcdFrame;
                if (tmp == 0) break;
                frame = gcdFrame;
                gcdFrame = tmp;
            }
        }
    }
    
    NSMutableArray *array = [NSMutableArray new];
    for (size_t i = 0; i < count; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (!imageRef) {
            CFRelease(source);
            return nil;
        }
        
        size_t width = CGImageGetWidth(imageRef);
        size_t height = CGImageGetHeight(imageRef);
        
        if (CGSizeIsEmpty(CGSizeMake(width, height))) {
            CFRelease(source);
            CFRelease(imageRef);
             return nil;
        }
        
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef) & kCGBitmapAlphaInfoMask;
        BOOL hasAlpha = NO;
        if (alphaInfo == kCGImageAlphaPremultipliedLast ||
            alphaInfo == kCGImageAlphaPremultipliedFirst ||
            alphaInfo == kCGImageAlphaLast ||
            alphaInfo == kCGImageAlphaFirst) {
            hasAlpha = YES;
        }
        
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
        bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
        CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, space, bitmapInfo);
        CGColorSpaceRelease(space);
        
        if (!context) {
            CFRelease(source);
            CFRelease(imageRef);
            return nil;
        }
        
        CGContextDrawImage(context, CGRectMakeWithSize(CGSizeMake(width, height)), imageRef); // decode
        CGImageRef decoded = CGBitmapContextCreateImage(context);
        CFRelease(context);
        if (!decoded) {
            CFRelease(source);
            CFRelease(imageRef);
            return nil;
        }
        
        UIImage *image = [UIImage imageWithCGImage:decoded scale:scale orientation:UIImageOrientationUp];
        CGImageRelease(imageRef);
        CGImageRelease(decoded);
        if (!image) {
            CFRelease(source);
            return nil;
        }
        
        for (size_t j = 0, max = frames[i] / gcdFrame; j < max; j++) {
            [array addObject:image];
        }
    }
    
    CFRelease(source);
    UIImage *outImage = [[self class] animatedImageWithImages:array duration:totalTime];
    return outImage;
}


+ (UIImage *)yt_imageSizeWithScreenImage:(UIImage *)image {
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if (imageWidth <= screenWidth && imageHeight <= screenHeight) {
        return image;
    }
    
    CGFloat max = MAX(imageWidth, imageHeight);
    CGFloat scale = max / (screenHeight * 2.0);
    
    CGSize size = CGSizeMake(imageWidth / scale, imageHeight / scale);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *outImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outImage;
}

@end

