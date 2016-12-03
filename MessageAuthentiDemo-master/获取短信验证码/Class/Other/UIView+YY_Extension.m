//
//  UIView+YY_Extension.m
//  Created by apple on 2016/11/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIView+YY_Extension.h"

@implementation UIView (YY_Extension)
- (CGSize)yy_size
{
    return self.frame.size;
}

- (void)setYy_size:(CGSize)yy_size
{
    CGRect frame = self.frame;
    frame.size = yy_size;
    self.frame = frame;
}

- (CGFloat)yy_width
{
    return self.frame.size.width;
}

- (CGFloat)yy_height
{
    return self.frame.size.height;
}

- (void)setYy_width:(CGFloat)yy_width
{
    CGRect frame = self.frame;
    frame.size.width = yy_width;
    self.frame = frame;
}

- (void)setYy_height:(CGFloat)yy_height
{
    CGRect frame = self.frame;
    frame.size.height = yy_height;
    self.frame = frame;
}

- (CGFloat)yy_x
{
    return self.frame.origin.x;
}

- (void)setYy_x:(CGFloat)yy_x
{
    CGRect frame = self.frame;
    frame.origin.x = yy_x;
    self.frame = frame;
}

- (CGFloat)yy_y
{
    return self.frame.origin.y;
}

- (void)setYy_y:(CGFloat)yy_y
{
    CGRect frame = self.frame;
    frame.origin.y = yy_y;
    self.frame = frame;
}

- (CGFloat)yy_centerX
{
    return self.center.x;
}

- (void)setYy_centerX:(CGFloat)yy_centerX
{
    CGPoint center = self.center;
    center.x = yy_centerX;
    self.center = center;
}

- (CGFloat)yy_centerY
{
    return self.center.y;
}

- (void)setYy_centerY:(CGFloat)yy_centerY
{
    CGPoint center = self.center;
    center.y = yy_centerY;
    self.center = center;
}

- (CGFloat)yy_right
{
    //    return self.yy_x + self.yy_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)yy_bottom
{
    //    return self.yy_y + self.yy_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setYy_right:(CGFloat)yy_right
{
    self.yy_x = yy_right - self.yy_width;
}

- (void)setYy_bottom:(CGFloat)yy_bottom
{
    self.yy_y = yy_bottom - self.yy_height;
}

@end
