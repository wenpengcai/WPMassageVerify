//  UIBarButtonItem+Extension.m
//
//  吕文苑
//  Created by apple on 2016/11/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

/**
 *  创建一个item
 *
 *  @param target    点击者所属的对象
 *  @param action    点击者所属对象的方法
 *  @param image     图像
 *  @param highImage 高亮图像
 *
 *  @return 返回item
 */
+ (UIBarButtonItem *)itemWithTarget: (id)target action: (SEL)action image: (NSString *)image highImage: (NSString *) highImage{
    
    //设置导航栏按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed: image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    //设置大小
    CGFloat btnW = btn.currentBackgroundImage.size.width;
    CGFloat btnH = btn.currentBackgroundImage.size.height;
    btn.bounds = CGRectMake(0, 0, btnW, btnH);
    [btn addTarget: target action: action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView: btn];
}

@end
