//
//  LLQCityPickerView.h
//  Picker
//
//  Created by LLQ on 2017/3/8.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PickerTypeCity,     //精确到市
    PickerTypeDistrict  //精确到区
} PickerType;

@interface LLQCityPickerView : UIPickerView
//记录当前选中的标题
@property (nonatomic, copy) NSString *firstName, *secondName, *thirdName;

//精确程度
@property (nonatomic, assign) PickerType pickerType;

@end
