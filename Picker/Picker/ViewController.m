//
//  ViewController.m
//  Picker
//
//  Created by LLQ on 2017/3/8.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import "ViewController.h"
#import "LLQCityPickerView.h"
#import "LLQInfoInputCell.h"
#import "LLQInfoInputView.h"
#import "TestViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    LLQInfoInputView *llqInputView;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) LLQCityPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    llqInputView = [[LLQInfoInputView alloc] initWithFrame:CGRectMake(20, 20, (UIScreen.mainScreen.bounds.size.width)-40, 30)];
    llqInputView.keyboardType = LLQInputKeyboardTypeCity;
    llqInputView.content = @"12333";
    llqInputView.placeholder = @"身份证";
    llqInputView.endEditing = ^(NSString *text) {
        NSLog(@"%@",text);
    };
    llqInputView.showAccessory = YES;
    llqInputView.layer.borderWidth = 0.5;
    llqInputView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:llqInputView];
    
    
    
    _pickerView = [[LLQCityPickerView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    _pickerView.pickerType = PickerTypeDistrict;
    //自定义输入视图
    self.textField.inputView = _pickerView;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    button.backgroundColor = [UIColor yellowColor];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //自定义输入视图的辅助视图
    self.textField.inputAccessoryView = button;
    
    [_mainTableView registerNib:[UINib nibWithNibName:@"LLQInfoInputCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LLQInfoInputCell"];
    
    for (UIView *view in self.view.subviews) {
        NSLog(@"%ld",view.tag);
    }

}


- (IBAction)chengeKeyBoardType:(UIButton *)sender {
    [self presentViewController:[[TestViewController alloc] init] animated:YES completion:nil];
}

- (void)buttonAction:(UIButton *)button{
    
    [self.view endEditing:YES];
    
    //获取某一列的选中行标
//    NSInteger index0 = [self.pickerView selectedRowInComponent:0];
//    NSInteger index1 = [self.pickerView selectedRowInComponent:1];
//    NSInteger index2 = [self.pickerView selectedRowInComponent:2];
    
//
//    NSString *str0 = self.dataSource[0][index0];
//    NSString *str1 = self.dataSource[1][index1];
//    NSString *str2 = self.dataSource[2][index2];
//    
    NSString *str = [NSString stringWithFormat:@"%@ - %@ - %@",_pickerView.firstName,_pickerView.secondName,_pickerView.thirdName];
    self.textField.text = str;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


#pragma mark ------ UITableViewDelegate and UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLQInfoInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLQInfoInputCell"];
    cell.keyboardType = CellInputKeyboardTypeDate;
    cell.inputTextField.tag = 10002;
    cell.endEditing = ^(NSString *text) {
        NSLog(@"%@",text);
    };
    return cell;
}

@end
