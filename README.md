# LLQInfoInputView
>基于 **UIView** 封装，可以使用任何 **UIView** 的 **API** 
>使用 **UITextField** 作为输入控件，兼容 **IQKeyboardManager** 等第三方键盘管理

## 使用
```objc
#import "LLQInfoInputView.h"
```
```objc
//初始化
LLQInfoInputView *llqInputView = [[LLQInfoInputView alloc] initWithFrame:CGRectMake(20, 20, (UIScreen.mainScreen.bounds.size.width)-40, 30)];

//设置输入类型
llqInputView.keyboardType = LLQInputKeyboardTypeCity;

//设置初始值
llqInputView.content = @"12333";

//设置提示语
llqInputView.placeholder = @"身份证";

//输入结束时拿到字符串
llqInputView.endEditing = ^(NSString *text) {
    NSLog(@"%@",text);
};

//设置显示辅助视图
llqInputView.showAccessory = YES;
```

## 输入类型
目前有 **9** 种输入类型，如果您有更多的常用输入类型，欢迎提到 Issues

```objc
//默认键盘，血型，衣服尺码，邮箱，电话号码，不可编辑，身份证号，城市，日期
typedef enum : NSUInteger {
    LLQInputKeyboardTypeDefault,       
    LLQInputKeyboardTypeBlood,         
    LLQInputKeyboardTypeSize,          
    LLQInputKeyboardTypeEmailAddress,  
    LLQInputKeyboardTypePhonePad,      
    LLQInputKeyboardTypeNoEidt,        
    LLQInputKeyboardTypeIDCardNumber,  
    LLQInputKeyboardTypeCity,          
    LLQInputKeyboardTypeDate           
} LLQInputKeyboardType;
```

![展示](https://github.com/li1024316925/LLQInfoInputView/blob/master/Image/inputview.gif)







