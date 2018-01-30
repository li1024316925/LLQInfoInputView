//
//  TestViewController.m
//  Picker
//
//  Created by LLQ on 2018/1/26.
//  Copyright © 2018年 LLQ. All rights reserved.
//

#import "TestViewController.h"
#import "LLQInfoInputView.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createInputview];
    
}

- (void)createInputview {
    
    NSArray *array = @[
                       @{@"默认":@(LLQInputKeyboardTypeDefault)},
                       @{@"身份证号":@(LLQInputKeyboardTypeIDCardNumber)},
                       @{@"电话号码":@(LLQInputKeyboardTypePhonePad)},
                       @{@"城市":@(LLQInputKeyboardTypeCity)},
                       @{@"日期":@(LLQInputKeyboardTypeDate)},
                       @{@"衣服尺寸":@(LLQInputKeyboardTypeSize)},
                       @{@"邮箱":@(LLQInputKeyboardTypeEmailAddress)},
                       @{@"血型":@(LLQInputKeyboardTypeBlood)},
                       @{@"不可编辑":@(LLQInputKeyboardTypeNoEidt)}
    ];
    
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dic = array[i];
        LLQInfoInputView *llqInputView = [[LLQInfoInputView alloc] initWithFrame:CGRectMake(20, (i*30)+i*10+10, (UIScreen.mainScreen.bounds.size.width)-40, 30)];
        llqInputView.keyboardType = [[dic objectForKey:dic.allKeys[0]] integerValue];
        llqInputView.placeholder = dic.allKeys[0];
        llqInputView.endEditing = ^(NSString *text, NSString *alertStr) {
            NSLog(@"%@ -- %@",text, alertStr);
        };
        llqInputView.showAccessory = YES;
        llqInputView.isCheck = YES;
        llqInputView.layer.borderWidth = 0.5;
        llqInputView.layer.borderColor = [UIColor blackColor].CGColor;
        [self.view addSubview:llqInputView];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
