//
//  VCAloneNumField.h
//  VCAloneNumFieldDemo
//
//  Created by 任维超 on 2018/3/27.
//  Copyright © 2018年 vchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VCAloneNumField;

@protocol VCAloneNumFieldDelegate <NSObject>

@optional
/**
 *  获取用户输入的字符
 */
- (void)numField:(VCAloneNumField *)numField inputNum:(NSString *)num;

@end

@interface VCAloneNumField : UIView

@property (nonatomic, assign) NSInteger numLength;//数字长度（位数）

@property (nonatomic, strong) UIColor   *gridLineColor;//输入框（网格）边框颜色
@property (nonatomic, assign) CGFloat   gridLineWidth;//输入框边框宽度

@property (nonatomic, strong) UIColor   *dotColor;//密文点颜色
@property (nonatomic, assign) CGFloat   dotWidth;//密文点直径

@property (nonatomic, strong) UIColor   *textColor;//明文颜色
@property (nonatomic, strong) UIFont    *font;//明文字体

@property (nonatomic, strong) UIColor   *inputingColor;//正在输入的框背景色

@property (nonatomic, getter=isSecureTextEntry) BOOL secureTextEntry;//明文/密文,默认密文(YES)
@property (nonatomic , assign) NSInteger inputCount;//用户当前输入的字符个数,设置这个值,可以修改圆点显示

@property (nonatomic, weak) id<VCAloneNumFieldDelegate> delegate;

/**
 *  自动获得焦点
 */
- (void)autoBecomeFirstResponder;

@end
