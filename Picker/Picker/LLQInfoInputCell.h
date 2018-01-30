//
//  SelfInfoCardCell.h
//  Chinalife_iDong
//
//  Created by LLQ on 2017/12/14.
//  Copyright © 2017年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CellInputKeyboardTypeDefault,       //默认键盘
    CellInputKeyboardTypeBlood,         //血型
    CellInputKeyboardTypeSize,          //衣服尺码
    CellInputKeyboardTypeEmailAddress,  //Email
    CellInputKeyboardTypePhonePad,      //数字键盘
    CellInputKeyboardTypeNoEidt,        //不可编辑
    CellInputKeyboardTypeIDCardNum,     //身份证
    CellInputKeyboardTypeCity,          //城市
    CellInputKeyboardTypeDate           //日期
} CellInputKeyboardType;

typedef void(^EndEditing)(NSString *text);

@interface LLQInfoInputCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) CellInputKeyboardType keyboardType;

@property (nonatomic, copy) EndEditing endEditing;

@end
