//
//  UITableViewCell+S_Extension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/25.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableViewCell (UIExtension)

//@property (strong, nonatomic) UITableView *currentTableView;


@property (strong, nonatomic) NSIndexPath *indexPath;


/**
 计算高度
 
 @param model 传入模型
 @return 高度
 */
+ (CGFloat)cellWithModelHeight:(id)model;

/**
 instance Method

 @param identifier 标识
 @param tableView
 @return cell
 */
+ (instancetype)creatCellWithIdentifier:(NSString *)identifier currentTableView:(UITableView *)tableView; 

+ (instancetype)creatCellWithCurrentTableView:(UITableView *)tableView;
+ (instancetype)creatCellWithCurrentTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@end
