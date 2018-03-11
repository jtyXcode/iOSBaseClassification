//
//  UIConfiguration.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/8.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UIConfiguration : NSObject

NS_ASSUME_NONNULL_BEGIN

#pragma mark - base Color
@property(nonatomic, strong) UIColor            *clearColor;
@property(nonatomic, strong) UIColor            *whiteColor;
@property(nonatomic, strong) UIColor            *blackColor;
@property(nonatomic, strong) UIColor            *grayColor;
@property(nonatomic, strong) UIColor            *grayDarkenColor;
@property(nonatomic, strong) UIColor            *grayLightenColor;
@property(nonatomic, strong) UIColor            *redColor;
@property(nonatomic, strong) UIColor            *greenColor;
@property(nonatomic, strong) UIColor            *blueColor;
@property(nonatomic, strong) UIColor            *yellowColor;
@property(nonatomic, strong) UIColor            *orangeColor;

#pragma mark - 统一颜色
@property(nonatomic, strong) UIColor            *lineBackgroundColor;

//统一灰色
/** 浅灰       999999 */
@property(nonatomic, strong) UIColor            *lightGrayColor;
/** 中度灰     666666 */
@property(nonatomic, strong) UIColor            *inGreyColor;
/** 深灰      333333 */
@property(nonatomic, strong) UIColor            *darkGreyColor;
/** tableView 背景灰色 */
@property(nonatomic, strong) UIColor            *tableViewBackgroundColor;


#pragma mark - 首页颜色
/** 首页字体颜色 橙色 */
@property(nonatomic, strong) UIColor            *hearViewTitleColor;
/** 首页字体 旗舰列表字体颜色 淡灰色 */
@property(nonatomic, strong) UIColor            *homeTitleGrayColor;
/** 黄色 label 背景 */
@property(nonatomic, strong) UIColor            *homeLableBackgroundYellowColor;
/** 淡红色 label 背景 */
@property(nonatomic, strong) UIColor            *homeLableBackgroundPinkColor;
/** 淡蓝 label 背景 */
@property(nonatomic, strong) UIColor            *homeLableBackgroundLightBlueColor;
/** 淡紫 label 背景  */
@property(nonatomic, strong) UIColor            *homeLableBackgroundLightpurpleColor;
/** 逛市场滚动视图背景颜色 */
@property(nonatomic, strong) UIColor            *marketBackgroundGaryColor;
/** 逛市场字体颜色 */
@property(nonatomic, strong) UIColor            *marketTitleColor;

/** r 0 g 0 b 0 alpha0.5 半透明黑色 */
@property(nonatomic, strong) UIColor            *semitransparentBlackColor;

#pragma mark - 登录
/** 输入框边框颜色 灰色 */
@property(nonatomic, strong) UIColor            *textFieldBordGrayColor;



#pragma mark - Font

//font 后面接大小
@property(nonatomic, strong) UIFont             *font65;
@property(nonatomic, strong) UIFont             *font24;
@property(nonatomic, strong) UIFont             *font18;
@property(nonatomic, strong) UIFont             *font16;
@property(nonatomic, strong) UIFont             *font15;
@property(nonatomic, strong) UIFont             *font14;
@property(nonatomic, strong) UIFont             *font13;
@property(nonatomic, strong) UIFont             *font12;
@property(nonatomic, strong) UIFont             *font11;
@property(nonatomic, strong) UIFont             *font9;


NS_ASSUME_NONNULL_END

+ (instancetype _Nullable )sharedInstance;
@end
