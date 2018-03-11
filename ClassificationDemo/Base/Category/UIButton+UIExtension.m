//
//  UIButton+S_Extension.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/25.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "UIButton+UIExtension.h"


@implementation UIButton (UIExtension)


- (void)setDefaultImage:(UIImage * __nullable)image{
    [self setImage:image forState:UIControlStateNormal];
}

- (void)setDefaultText:(NSString * __nullable)text{
    [self setTitle:text forState:UIControlStateNormal];
}
- (void)setDefaultTextColor:(UIColor * __nullable)textColor{
    [self setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)setDefaultText:(NSString * __nullable )text TextColor:(UIColor * __nullable)textColor {
    [self setDefaultText:text];
    [self setDefaultTextColor:textColor];
}

@end


static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";
@implementation UIButton (FixMultiClick)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplaceMethod([self class], @selector(sendAction:to:forEvent:), @selector(yt_sendAction:to:forEvent:));
        
    });
}

- (NSTimeInterval)yt_acceptEventInterval {
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setYt_acceptEventInterval:(NSTimeInterval)yt_acceptEventInterval {
    objc_setAssociatedObject(self, &UIControl_acceptEventInterval, @(yt_acceptEventInterval), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)yt_acceptEventTime {
    return [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setYt_acceptEventTime:(NSTimeInterval)yt_acceptEventTime {
    objc_setAssociatedObject(self, &UIControl_acceptEventTime, @(yt_acceptEventTime), OBJC_ASSOCIATION_ASSIGN);
}

- (void)yt_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([NSDate date].timeIntervalSince1970 - self.yt_acceptEventTime < self.yt_acceptEventInterval) {
        return;
    }
    
    if (self.yt_acceptEventInterval > 0) {
        self.yt_acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    
    [self yt_sendAction:action to:target forEvent:event];
}



@end

