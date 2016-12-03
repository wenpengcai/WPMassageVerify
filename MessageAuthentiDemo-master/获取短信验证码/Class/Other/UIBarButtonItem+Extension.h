//
//  UIBarButtonItem+Extension.h
//
//  吕文苑
//  Created by apple on 2016/11/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget: (id)target action: (SEL)action image: (NSString *)image highImage:(NSString*)highImage;
@end
