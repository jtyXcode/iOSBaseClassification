//
//  UIScrollView+UIExtension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/4.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (UIExtension)

/// 判断UIScrollView是否已经处于顶部（当UIScrollView内容不够多不可滚动时，也认为是在顶部）
@property(nonatomic, assign, readonly) BOOL yt_alreadyAtTop;

/// 判断UIScrollView是否已经处于底部（当UIScrollView内容不够多不可滚动时，也认为是在底部）
@property(nonatomic, assign, readonly) BOOL yt_alreadyAtBottom;

/**
 * 判断当前的scrollView内容是否足够滚动
 * @warning 避免与<i>scrollEnabled</i>混淆
 */
- (BOOL)yt_canScroll;


/**
   立即停止滚动，用于那种手指已经离开屏幕但列表还在滚动的情况。
 */
- (void)yt_stopDeceleratingIfNeeded;

/**
 滚动到最顶部
 */
- (void)yt_scrollToTop;
/**
 滚动到最底部
 */
- (void)yt_scrollToBottom;

@end
