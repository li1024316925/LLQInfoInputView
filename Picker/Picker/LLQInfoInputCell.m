//
//  SelfInfoCardCell.m
//  Chinalife_iDong
//
//  Created by LLQ on 2017/12/14.
//  Copyright © 2017年 sinosoft. All rights reserved.
//

#import "LLQInfoInputCell.h"
#import "LLQCityPickerView.h"

@interface LLQInfoInputCell () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *mainPickView;
@property (nonatomic, strong) NSMutableArray *pickViewDataSource;
@property (nonatomic, strong) LLQCityPickerView *cityPickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation LLQInfoInputCell

- (NSMutableArray *)pickViewDataSource {
    if (!_pickViewDataSource) {
        _pickViewDataSource = [[NSMutableArray alloc] init];
    }
    return _pickViewDataSource;
}

- (LLQCityPickerView *)cityPickerView {
    if (!_cityPickerView) {
        _cityPickerView = [[LLQCityPickerView alloc] initWithFrame:CGRectMake(0, 0, (UIScreen.mainScreen.bounds.size.width), 220)];
        _cityPickerView.backgroundColor = [UIColor whiteColor];
        _cityPickerView.pickerType = PickerTypeCity;
    }
    return _cityPickerView;
}

- (UIPickerView *)mainPickView {
    if (!_mainPickView) {
        _mainPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, (UIScreen.mainScreen.bounds.size.width), 220)];
        _mainPickView.backgroundColor = [UIColor whiteColor];
        _mainPickView.showsSelectionIndicator = NO;
        _mainPickView.delegate = self;
        _mainPickView.dataSource = self;
    }
    return _mainPickView;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, (UIScreen.mainScreen.bounds.size.width), 220)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
        _datePicker.locale = locale;
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-24*60*60*7];
        _datePicker.maximumDate = [NSDate date];
    }
    return _datePicker;
}

- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = _name;
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.inputTextField.text = _content;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.inputTextField.placeholder = _placeholder;
}

- (void)setKeyboardType:(CellInputKeyboardType)keyboardType {
    _keyboardType = keyboardType;
    
    switch (keyboardType) {
            
        case CellInputKeyboardTypeDefault:
            self.inputTextField.keyboardType = UIKeyboardTypeDefault;
            break;
            
        case CellInputKeyboardTypeSize:
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
            
        case CellInputKeyboardTypeBlood:
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
            
        case CellInputKeyboardTypePhonePad:
            self.inputTextField.keyboardType = UIKeyboardTypePhonePad;
            break;
            
        case CellInputKeyboardTypeEmailAddress:
            self.inputTextField.keyboardType = UIKeyboardTypeEmailAddress;
            break;
            
        case CellInputKeyboardTypeNoEidt:
            self.inputTextField.userInteractionEnabled = NO;
            break;
            
        case CellInputKeyboardTypeCity:
            self.inputTextField.inputView = self.cityPickerView;
            break;
            
        case CellInputKeyboardTypeIDCardNum:
            self.inputTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            break;
            
        case CellInputKeyboardTypeDate:
            self.inputTextField.inputView = self.datePicker;
            break;
            
        default:
            break;
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.inputTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark ------ UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.keyboardType == CellInputKeyboardTypeCity) {
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
    else if (self.keyboardType == CellInputKeyboardTypeDate) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *dateStr = [formatter stringFromDate:self.datePicker.date];
        textField.text = dateStr;
    }
    if (self.endEditing) {
        self.endEditing(textField.text);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([self.content isEqualToString:@""] || self.content == nil) {
        switch (self.keyboardType) {
            case CellInputKeyboardTypeBlood:
                self.content = @"A";
                break;
                
            case CellInputKeyboardTypeSize:
                self.content = @"XS";
                break;
                
            default:
                break;
        }
    }
    
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
