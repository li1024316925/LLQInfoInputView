//
//  LLQInfoInputView.h
//  Picker
//
//  Created by LLQ on 2018/1/17.
//  Copyright © 2018年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LLQInputKeyboardTypeDefault,       //默认键盘
    LLQInputKeyboardTypeBlood,         //血型
    LLQInputKeyboardTypeSize,          //衣服尺码
    LLQInputKeyboardTypeEmailAddress,  //Email
    LLQInputKeyboardTypePhonePad,      //数字键盘
    LLQInputKeyboardTypeNoEidt,        //不可编辑
    LLQInputKeyboardTypeIDCardNumber,  //身份证
    LLQInputKeyboardTypeCity,          //城市
    LLQInputKeyboardTypeDate           //日期
} LLQInputKeyboardType;

typedef void(^EndEditing)(NSString *text);

@interface LLQInfoInputView : UIView


/**
 占位字符
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 设置初始值
 */
@property (nonatomic, copy) NSString *content;

/**
 TextField
 */
@property (nonatomic, strong) UITextField *inputTextField;

/**
 键盘样式
 */
@property (nonatomic, assign) LLQInputKeyboardType keyboardType;

/**
 编辑结束时的回调
 */
@property (nonatomic, copy) EndEditing endEditing;

/**
 显示 accessory
 */
@property (nonatomic, assign) BOOL showAccessory;

@end
