//
//  UIScrollView+UIExtension.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/4.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "UIScrollView+UIExtension.h"



@implementation UIScrollView (UIExtension)


- (BOOL)yt_alreadyAtTop {
    if (!self.yt_canScroll) {
        return YES;
    }
    
    if (self.contentOffset.y == -self.contentInset.top) {
        return YES;
    }
    return NO;
}

- (BOOL)yt_alreadyAtBottom {
    if (!self.yt_canScroll) {
        return YES;
    }
    
    if (self.contentOffset.y == self.contentSize.height + self.contentInset.bottom - CGRectGetHeight(self.bounds)) {
        return YES;
    }
    return NO;
}

-(BOOL)yt_canScroll {
    
    if (CGSizeIsEmpty(self.bounds.size)) {
        return NO;
    }
    BOOL canVerticalScroll = self.contentSize.height + UIEdgeInsetsGetVerticalValue(self.contentInset) > CGRectGetHeight(self.bounds);
    BOOL canHorizontalScoll = self.contentSize.width + UIEdgeInsetsGetHorizontalValue(self.contentInset) > CGRectGetWidth(self.bounds);
    return canVerticalScroll || canHorizontalScoll;
}

- (void)yt_stopDeceleratingIfNeeded {
    if (self.decelerating) {
        [self setContentOffset:self.contentOffset animated:NO];
    }
}


/**
 滚动到最顶部
 */
- (void)yt_scrollToTop {
    [self setContentOffset:CGPointMake(0, 0) animated:NO];
}
/**
 滚动到最底部
 */
- (void)yt_scrollToBottom {
    [self setContentOffset:CGPointMake(0, self.contentSize.height - self.height) animated:NO];
}


@end
