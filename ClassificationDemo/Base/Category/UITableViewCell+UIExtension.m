//
//  UITableViewCell+S_Extension.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/25.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "UITableViewCell+UIExtension.h"
#import <objc/runtime.h>

static char *kindexPath = "kindexPath";

@implementation UITableViewCell (UIExtension)


#pragma mark - instance Method
/**
instance Method

@param identification 标识
@param tableView
@return cell
*/
+ (instancetype)creatCellWithIdentifier:(NSString *)identifier currentTableView:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        cell.currentTableView = tableView;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

+ (instancetype)creatCellWithCurrentTableView:(UITableView *)tableView {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
//        cell.currentTableView = tableView;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

+ (instancetype)creatCellWithCurrentTableView:(UITableView *)tableView style:(UITableViewCellStyle)style {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[self class] alloc] initWithStyle:style reuseIdentifier:NSStringFromClass([self class])];
        //        cell.currentTableView = tableView;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}



#pragma mark - Class Method
+ (CGFloat)cellWithModelHeight:(id)model {
    return 44.0;
}

#pragma mark - Property
- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, &kindexPath, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSIndexPath *)indexPath {
    return objc_getAssociatedObject(self, kindexPath);
}




@end
