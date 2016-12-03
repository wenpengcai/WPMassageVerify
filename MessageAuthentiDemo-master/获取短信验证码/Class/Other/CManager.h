//
//  CManager.h
//
//  Created by apple on 2016/11/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>

@interface CManager : NSObject

@end

///正则表达式检测基本字符串
@interface CManager (CheckText)

//验证邮箱
+ (BOOL)validateEmail:(NSString *)email;

//验证手机
+ (BOOL)validateMobile:(NSString *)mobile;

//验证手机
+ (BOOL)validateCarNo:(NSString *)carNo;

//验证用户名
+ (BOOL)validateUserName:(NSString *)name;

//验证密码
+ (BOOL) validatePassword:(NSString *)passWord;

//验证昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//验证身份证
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
@end
