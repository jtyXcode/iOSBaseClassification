//
//  UITableView+UIExtension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/30.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (UIExtension)

- (NSIndexPath *)yt_indexPathForRowAtView:(UIView *)view;

- (BOOL)yt_cellVisibleAtIndexPath:(NSIndexPath *)indexPath;

/**
 更新tableView

 @param block
 */
- (void)yt_updateWithBlock:(void (^)(UITableView * tableView))block;
@end
