//
//  UIConfiguration.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/8.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "UIConfiguration.h"

@implementation UIConfiguration
+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static UIConfiguration *sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[UIConfiguration alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initDefaultConfiguration];
    }
    return self;
}

- (void)initDefaultConfiguration {
    
    self.clearColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.whiteColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    self.blackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    self.grayColor = UIColorMake(179, 179, 179);
    self.grayDarkenColor = UIColorMake(163, 163, 163);
    self.grayLightenColor = UIColorMake(198, 198, 198);
    self.redColor = UIColorMake(250, 58, 58);
    self.greenColor = UIColorMake(159, 214, 97);
    self.blueColor = UIColorMake(49, 189, 243);
    self.yellowColor = UIColorMake(255, 207, 71);
    self.orangeColor = [UIColor orangeColor];
    self.semitransparentBlackColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    //统一颜色
//    self.lineBackgroundColor = UIColorMake(229, 229, 229);
    self.lineBackgroundColor = [UIColor yt_colorWithHexString:@"#d8d8d8"];
    self.lightGrayColor = [UIColor yt_colorWithHexString:@"#999999"];
    self.inGreyColor = [UIColor yt_colorWithHexString:@"#666666"];
    self.darkGreyColor = [UIColor yt_colorWithHexString:@"#333333"];
//    self.tableViewBackgroundColor = [UIColor yt_colorWithHexString:@"#efeff6"];
    self.tableViewBackgroundColor = [UIColor yt_colorWithHexString:@"#f5f5f9"];
    
    //首页
    self.hearViewTitleColor = [UIColor yt_colorWithHexString:@"#ff6204"];
    self.homeTitleGrayColor = [UIColor yt_colorWithHexString:@"#d8d8d8"];
    self.homeLableBackgroundYellowColor = [UIColor yt_colorWithHexString:@"#ffb500"];
    self.homeLableBackgroundPinkColor = [UIColor yt_colorWithHexString:@"#ff8779"];
    self.homeLableBackgroundLightBlueColor = [UIColor yt_colorWithHexString:@"#56c1e5"];
    self.homeLableBackgroundLightpurpleColor = [UIColor yt_colorWithHexString:@"#f23ddb"];
    self.marketBackgroundGaryColor = [UIColor yt_colorWithHexString:@"#f5f5f5"];
    self.marketTitleColor = [UIColor yt_colorWithHexString:@"#989898"];
   
    //登陆
    self.textFieldBordGrayColor = [UIColor yt_colorWithHexString:@"#d2d2d2"];
    
    

    self.font9 = UIFontMake(9);
    self.font11 = UIFontMake(11);
    self.font12 = UIFontMake(12);
    self.font13 = UIFontMake(13);
    self.font14 = UIFontMake(14);
    self.font15 = UIFontMake(15);
    self.font16 = UIFontMake(16);
    self.font18 = UIFontMake(18);
    self.font24 = UIFontMake(24);
    self.font65 = UIFontMake(65);

    
}

@end
