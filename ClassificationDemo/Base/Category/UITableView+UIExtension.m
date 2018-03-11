//
//  UITableView+UIExtension.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/30.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "UITableView+UIExtension.h"

@implementation UITableView (UIExtension)
- (NSIndexPath *)yt_indexPathForRowAtView:(UIView *)view{
    if (view && [view isKindOfClass:[UIView class]]) {
        CGPoint origin = [self convertPoint:view.frame.origin fromView:view.superview];
        return [self indexPathForRowAtPoint:origin];
    }
    return nil;
}

- (BOOL)yt_cellVisibleAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *visibleIndexPaths = self.indexPathsForVisibleRows;
    for (NSIndexPath *visibleIndexPath in visibleIndexPaths) {
        if ([visibleIndexPath isEqual:indexPath]) {
            return YES;
        }
    }
    return NO;
}

- (void)yt_updateWithBlock:(void (^)(UITableView *tableView))block {
    [self beginUpdates];
    block(self);
    [self endUpdates];
}

@end
