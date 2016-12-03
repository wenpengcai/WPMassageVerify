//
//  ViewController.m
//  获取短信验证码
//
//  吕文苑
//  Created by apple on 2016/11/30.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import "ViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "AFHTTPSessionManager.h"
#import "CManager.h"
#import "UIView+YY_Extension.h"
#import "MBProgressHUD+MJ.h"

/*** 颜色 ***/
#define YYColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define YYColor(r, g, b) YYColorA((r), (g), (b), 255)
#define YYRandomColor YYColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define myRedColor [UIColor colorWithRed:209/255.0 green:0 blue:15/255.0 alpha:1]

#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController()
@property(nonatomic, strong) UITextField *phoneTextField;
@property(nonatomic, strong) UITextField *validateNumTextFiled;
@property(nonatomic, strong) UIButton *getValidateBtn;
@property(nonatomic, copy) NSString *validateString;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置背景颜色
    self.view.backgroundColor = YYColor(237, 237, 237);
    
    //加载视图
    [self setupContentView];
}

/**
 *  触摸屏幕退出编辑状态
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

/**
 *  加载所有视图
 */
- (void)setupContentView{
    
    //电话号码
    CGFloat margin = 20;
    CGFloat height = 44;
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, margin, screenWidth, 44)];
    phoneView.backgroundColor = [UIColor whiteColor];
    
    UITextField *phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(margin, 0, screenWidth - 2 * margin, height)];
    phoneTextField.backgroundColor = [UIColor whiteColor];
    phoneTextField.placeholder = @"请输入手机号码";
    phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.phoneTextField = phoneTextField;
    [phoneView addSubview:phoneTextField];
    
    //验证码
    CGFloat validateViewY = CGRectGetMaxY(phoneView.frame) + margin;
    UIView *validateView = [[UIView alloc] initWithFrame:CGRectMake(0, validateViewY, screenWidth, height)];
    validateView.backgroundColor = [UIColor whiteColor];
    
    UITextField *validateNumTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(margin, 0, (screenWidth - 2 * margin) * 0.7, height)];
    validateNumTextFiled.backgroundColor = [UIColor whiteColor];
    validateNumTextFiled.placeholder = @"请输入验证码";
    validateNumTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    validateNumTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.validateNumTextFiled = validateNumTextFiled;
    [validateView addSubview:validateNumTextFiled];
    
    //倒计时按钮
    CGFloat btnX = CGRectGetMaxX(validateNumTextFiled.frame);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(btnX, 0, (screenWidth - 2 * margin) * 0.3, 30);
    btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:11.0f];
    [btn setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [btn.layer setCornerRadius:5];
    [btn setBackgroundColor:YYColor(234, 161, 50)];
    btn.yy_centerY = validateNumTextFiled.yy_centerY;
    [btn addTarget:self action:@selector(timerClic) forControlEvents:UIControlEventTouchUpInside];
    [validateView addSubview:btn];
    self.getValidateBtn = btn;
    
    [self.view addSubview:phoneView];
    [self.view addSubview:validateView];
    
    //验证按钮
    CGFloat x = 0;
    CGFloat y = screenHeight * 0.3;
    CGFloat buttonW = screenWidth - (margin * 2);
    CGFloat buttonH = 44;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(x, y, buttonW, buttonH);
    button.layer.cornerRadius = 5;
    [button setBackgroundColor: [UIColor colorWithRed:209/255.0 green:0.0 blue:15/255.0 alpha:1]];
    [button setTitle:@"验证" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    button.yy_centerX = self.view.yy_centerX;
    [button addTarget:self action:@selector(validateLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

/**
 *  验证按钮点击
 */
- (void)validateLogin{
    
    if (!self.phoneTextField.text.length) {
        [MBProgressHUD showError:@"请输入电话号码并且获取验证码"];
    }else if (!self.validateNumTextFiled.text){
        [MBProgressHUD showError:@"请输入您获取的验证码"];
    }else if ([self.validateString isEqualToString:self.validateNumTextFiled.text]) {
        //验证成功，跳转重置密码
        [MBProgressHUD showSuccess:@"验证成功,请重置密码"];
        self.validateString = nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //跳转到修改密码控制器
            NSLog(@"在这里跳转控制器");
        });
    }else{
        
        [MBProgressHUD showError:@"验证密码错误"];
    }
}

/**
 *  点击获取验证码
 */
-(void)timerClic{
    if (!self.phoneTextField.text.length) {
        [MBProgressHUD showError:@"请输入电话号码"];
        return;
    }else if ([CManager validateMobile:self.phoneTextField.text]) {
        
        //获取验证码
        [self messege];
    }else{
        [MBProgressHUD showError:@"请输入正确的电话号码"];
        return;
    }
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.getValidateBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.getValidateBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.getValidateBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                self.getValidateBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

/**
 *  从服务器获取验证码
 */
-(void)messege{
    //Your company's interface address
    NSString *url=@"xxxxxxxxxxxxx";//你的接口地址
    
    NSMutableDictionary *parameters=[[NSMutableDictionary alloc]init];
    [parameters setObject:self.phoneTextField.text forKey:@"phone"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", nil];
    NSLog(@"%@",parameters);
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data = responseObject;
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        self.validateString = str;
        NSLog(@"请求成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.userInfo);
        
    }];
}
@end

