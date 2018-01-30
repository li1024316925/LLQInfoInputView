//
//  LLQInfoInputView.m
//  Picker
//
//  Created by LLQ on 2018/1/17.
//  Copyright © 2018年 LLQ. All rights reserved.
//

#import "LLQInfoInputView.h"
#import "LLQCityPickerView.h"
#import "LLQToolBar.h"
#import "LLQToolBarManager.h"

#define LLQKeyboardHeight 215

@interface LLQInfoInputView ()<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *mainPickView;
@property (nonatomic, strong) LLQCityPickerView *cityPickerView;
@property (nonatomic, strong) LLQToolBar *inputAccessory;

@property (nonatomic, strong) NSMutableArray *pickViewDataSource;

@end

@implementation LLQInfoInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITextField *textField = [[UITextField alloc] initWithFrame:self.bounds];
        textField.delegate = self;
        textField.borderStyle = UITextBorderStyleNone;
        self.inputTextField = textField;
        self.showAccessory = NO;
        self.isCheck = NO;
        [self addSubview:self.inputTextField];
    }
    return self;
}

- (LLQToolBar *)inputAccessory {
    if (!_inputAccessory) {
        _inputAccessory = [[LLQToolBar alloc] initWithFrame:CGRectMake(0, 0, (UIScreen.mainScreen.bounds.size.width), 45)];
        _inputAccessory.toolBarDelegate = [LLQToolBarManager shareManager];
        _inputAccessory.placeholderTitle = self.placeholder?self.placeholder:@"";
    }
    return _inputAccessory;
}

- (NSMutableArray *)pickViewDataSource {
    if (!_pickViewDataSource) {
        _pickViewDataSource = [[NSMutableArray alloc] init];
    }
    return _pickViewDataSource;
}

- (LLQCityPickerView *)cityPickerView {
    if (!_cityPickerView) {
        _cityPickerView = [[LLQCityPickerView alloc] initWithFrame:CGRectMake(0, 0, (UIScreen.mainScreen.bounds.size.width), LLQKeyboardHeight)];
        _cityPickerView.backgroundColor = [UIColor whiteColor];
        _cityPickerView.pickerType = PickerTypeCity;
    }
    return _cityPickerView;
}

- (UIPickerView *)mainPickView {
    if (!_mainPickView) {
        _mainPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, (UIScreen.mainScreen.bounds.size.width), LLQKeyboardHeight)];
        _mainPickView.backgroundColor = [UIColor whiteColor];
        _mainPickView.showsSelectionIndicator = NO;
        _mainPickView.delegate = self;
        _mainPickView.dataSource = self;
    }
    return _mainPickView;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, (UIScreen.mainScreen.bounds.size.width), LLQKeyboardHeight)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
        _datePicker.locale = locale;
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-24*60*60*7];
        _datePicker.maximumDate = [NSDate date];
    }
    return _datePicker;
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.inputTextField.text = _content;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.inputTextField.placeholder = _placeholder;
    if (_inputAccessory) {
        self.inputAccessory.placeholderTitle = _placeholder?_placeholder:@"";
    }
}

- (void)setShowAccessory:(BOOL)showAccessory {
    _showAccessory = showAccessory;
    if (_showAccessory) {
        self.inputTextField.inputAccessoryView = self.inputAccessory;
    }
}

- (void)setKeyboardType:(LLQInputKeyboardType)KeyboardType {
    _keyboardType = KeyboardType;
    
    self.inputTextField.userInteractionEnabled = YES;
    self.inputTextField.inputView = nil;
    self.inputTextField.keyboardType = UIKeyboardTypeDefault;
    
    switch (KeyboardType) {
            
        case LLQInputKeyboardTypeDefault:
            self.inputTextField.keyboardType = UIKeyboardTypeDefault;
            break;
            
        case LLQInputKeyboardTypeSize:
            self.inputTextField.inputView = self.mainPickView;
            self.pickViewDataSource = [NSMutableArray arrayWithArray:@[@"XS",@"S",@"M",@"L",@"XL",@"XXL"]];
            [self.mainPickView reloadAllComponents];
            if (self.content) {
                NSInteger index = [self.pickViewDataSource indexOfObject:self.content];
                if (index && index <= self.pickViewDataSource.count) {
                    [self.mainPickView selectRow:index inComponent:0 animated:NO];
                }
            }
            break;
            
        case LLQInputKeyboardTypeBlood:
            self.inputTextField.inputView = self.mainPickView;
            self.pickViewDataSource = [NSMutableArray arrayWithArray:@[@"A",@"B",@"AB",@"O"]];
            [self.mainPickView reloadAllComponents];
            if (self.content) {
                NSInteger index = [self.pickViewDataSource indexOfObject:self.content];
                if (index && index <= self.pickViewDataSource.count) {
                    [self.mainPickView selectRow:index inComponent:0 animated:NO];
                }
            }
            break;
            
        case LLQInputKeyboardTypePhonePad:
            self.inputTextField.keyboardType = UIKeyboardTypePhonePad;
            break;
            
        case LLQInputKeyboardTypeEmailAddress:
            self.inputTextField.keyboardType = UIKeyboardTypeEmailAddress;
            break;
            
        case LLQInputKeyboardTypeNoEidt:
            self.inputTextField.userInteractionEnabled = NO;
            break;
            
        case LLQInputKeyboardTypeCity:
            self.inputTextField.inputView = self.cityPickerView;
            break;
            
        case LLQInputKeyboardTypeIDCardNumber:
            self.inputTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            break;
            
        case LLQInputKeyboardTypeDate:
            self.inputTextField.inputView = self.datePicker;
            break;
            
        default:
            break;
            
    }
    
}

- (NSArray *)inputviewsFromView:(UIView *)view {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]]) && [view canBecomeFirstResponder]) {
        [array addObject:view];
    }
    else if (view.subviews.count > 0) {
        NSArray *subviews = view.subviews;
        for (UIView *subview in subviews) {
            [array addObjectsFromArray:[self inputviewsFromView:subview]];
        }
    }
    return array;
}


#pragma mark ------ UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.keyboardType == LLQInputKeyboardTypeCity) {
        NSMutableString *cityStr = [[NSMutableString alloc] initWithString:@""];
        if (![self.cityPickerView.firstName isEqualToString:@""]) {
            [cityStr appendString:self.cityPickerView.firstName];
        }
        if (![self.cityPickerView.secondName isEqualToString:@""]) {
            [cityStr appendFormat:@" %@",self.cityPickerView.secondName];
        }
        if (![self.cityPickerView.thirdName isEqualToString:@""]) {
            [cityStr appendFormat:@" %@",self.cityPickerView.thirdName];
        }
        if (![cityStr isEqualToString:@""]) {
            textField.text = cityStr;
        }
    }
    else if (self.keyboardType == LLQInputKeyboardTypeDate) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *dateStr = [formatter stringFromDate:self.datePicker.date];
        textField.text = dateStr;
    }
    if (self.endEditing) {
        NSString *alertStr = nil;
        if (self.isCheck)
            alertStr = [self checkText:textField.text];
        self.endEditing(textField.text,alertStr);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([self.content isEqualToString:@""] || self.content == nil) {
        switch (self.keyboardType) {
            case LLQInputKeyboardTypeBlood:
                self.content = @"A";
                break;
                
            case LLQInputKeyboardTypeSize:
                self.content = @"XS";
                break;
                
            default:
                break;
        }
    }
    
    if (self.showAccessory) {
        LLQToolBarManager *manager = [LLQToolBarManager shareManager];
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[self inputviewsFromView:[UIApplication sharedApplication].delegate.window]];
        [tempArray sortUsingComparator:^NSComparisonResult(UIView *view1, UIView *view2) {
            CGRect frame1 = [view1 convertRect:view1.bounds toView:[UIApplication sharedApplication].delegate.window];
            CGRect frame2 = [view2 convertRect:view2.bounds toView:[UIApplication sharedApplication].delegate.window];
            
            CGFloat x1 = CGRectGetMinX(frame1);
            CGFloat y1 = CGRectGetMinY(frame1);
            CGFloat x2 = CGRectGetMinX(frame2);
            CGFloat y2 = CGRectGetMinY(frame2);
            
            if (y1 < y2)  return NSOrderedAscending;
            else if (y1 > y2) return NSOrderedDescending;
            else if (x1 < x2)  return NSOrderedAscending;
            else if (x1 > x2) return NSOrderedDescending;
            else    return NSOrderedSame;
        }];
        manager.inputviews = tempArray;
        manager.fristResponderIndex = [manager.inputviews indexOfObject:textField];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.keyboardType == LLQInputKeyboardTypePhonePad || self.keyboardType == LLQInputKeyboardTypeIDCardNumber) {
        if ([string isEqualToString:@" "]) {
            return NO;
        }
    }
    return YES;
}


#pragma mark ------ 校验

- (NSString *)checkText:(NSString *)text {
    NSString *alertStr = nil;
    switch (self.keyboardType) {
        case LLQInputKeyboardTypePhonePad:
            alertStr = [self checkPhoneNumber:text]?nil:@"您输入的手机号不正确！";
            break;
            
        case LLQInputKeyboardTypeIDCardNumber:
            alertStr = [self checkIDCardNumber:text]?nil:@"您输入的身份证号不正确！";
            break;
            
        case LLQInputKeyboardTypeEmailAddress:
            alertStr = [self checkMail:text]?nil:@"您输入的邮箱不正确！";
            break;
            
        default:
            break;
    }
    return alertStr;
}

//校验身份证
- (BOOL)checkIDCardNumber:(NSString *)IDCardNumber {
    
    if ([IDCardNumber isEqualToString:@""]) {
        return YES;
    }
    NSString *regex = @"(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]$)";
    NSRegularExpression *regu = [[NSRegularExpression alloc] initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger index = [regu numberOfMatchesInString:IDCardNumber options:NSMatchingReportProgress range:NSMakeRange(0, IDCardNumber.length)];
    if (index == 0) {
        return NO;
    }
    else if (index == 1) {
        return YES;
    }
    return NO;
    
}

//校验手机号
- (BOOL)checkPhoneNumber:(NSString *)phoneNum {
    
    if ([phoneNum isEqualToString:@""]) {
        return YES;
    }
    NSString *regex = @"^134[0-8]\\d{7}$|^13[^4]\\d{8}$|^14[5-9]\\d{8}$|^15[^4]\\d{8}$|^16[6]\\d{8}$|^17[0-8]\\d{8}$|^18[\\d]{9}$|^19[8,9]\\d{8}$";
    NSRegularExpression *regu = [[NSRegularExpression alloc] initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger index = [regu numberOfMatchesInString:phoneNum options:NSMatchingReportProgress range:NSMakeRange(0, phoneNum.length)];
    if (index == 0) {
        return NO;
    }
    else if (index == 1) {
        return YES;
    }
    return NO;
}

//校验邮箱
- (BOOL)checkMail:(NSString *)mail {
    
    if ([mail isEqualToString:@""]) {
        return YES;
    }
    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSRegularExpression *regu = [[NSRegularExpression alloc] initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger index = [regu numberOfMatchesInString:mail options:NSMatchingReportProgress range:NSMakeRange(0, mail.length)];
    if (index == 0) {
        return NO;
    }
    else if (index == 1) {
        return YES;
    }
    return NO;
    
}


#pragma mark ------ UIPickViewDelegate and UIPickViewDataSource

//列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickViewDataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickViewDataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.inputTextField.text = self.pickViewDataSource[row];
}

@end
