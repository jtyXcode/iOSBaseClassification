//
//  ViewController.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/25.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+UIExtension.h"
#import "NSObject+UIExtension.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"11111wodddai我爱111111111wo1ai我爱你";
    label.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 20);
    NSArray <NSString *>*arr = [NSObject RegularText:label.text pattern:@"我爱"];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:label.text];
    for (NSString *rangStr in arr) {
        NSRange range = NSRangeFromString(rangStr);
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:27] range:range];
        [att addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    }
    
    label.attributedText = att;
    [self.view addSubview:label];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
