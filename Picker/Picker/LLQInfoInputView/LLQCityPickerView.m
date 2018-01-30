//
//  LLQCityPickerView.m
//  Picker
//
//  Created by LLQ on 2017/3/8.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import "LLQCityPickerView.h"

@interface LLQCityPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSMutableArray *provinceArray;  //省份数据
@property (strong, nonatomic) NSMutableArray *cityArray;      //市数据
@property (strong, nonatomic) NSMutableArray *districtArray;  //区数据

@end

@implementation LLQCityPickerView

//lazy
- (NSMutableArray *)provinceArray{
    if (!_provinceArray) {
        _provinceArray = [[NSMutableArray alloc] init];
    }
    return _provinceArray;
}

- (NSMutableArray *)cityArray{
    if (!_cityArray) {
        _cityArray = [[NSMutableArray alloc] init];
    }
    return _cityArray;
}

- (NSMutableArray *)districtArray{
    if (!_districtArray) {
        _districtArray = [[NSMutableArray alloc] init];
    }
    return _districtArray;
}

//初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self loadData];
        self.firstName = @"";
        self.secondName = @"";
        self.thirdName = @"";
    }
    return self;
}

//加载数据
- (void)loadData{
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ChineseCities" ofType:@"json"]];
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    self.provinceArray = [NSMutableArray arrayWithArray:array];
    self.cityArray = [self analysisCitysData:self.provinceArray withIndex:0];  //第一次加载为第一个省的城市
    self.districtArray = [self analysisCitysData:self.cityArray withIndex:0];  //第一次加载为第一个省的第一个市的区县
    
}

//解析方法
- (NSMutableArray *)analysisCitysData:(NSArray *)dataArray withIndex:(NSInteger)index{
    
    if (dataArray.count <= index) {
        return [NSMutableArray array];
    }else{
        NSDictionary *subDic = dataArray[index];
        NSArray *subArray = [subDic objectForKey:@"sub"];
        if (subArray.count > 0) {
            return [NSMutableArray arrayWithArray:subArray];
        }
        else {
            return [NSMutableArray array];
        }
    }
    
    return [NSMutableArray array];
    
}

//某一列某一行的数据
- (NSString *)acquireStrWithArray:(NSArray *)array Index:(NSInteger)index{
    
    if (array.count > index) {
        NSDictionary *dic = array[index];
        return [dic objectForKey:@"name"];
    }
    
    return @"";
    
}

#pragma mark ------ UIPickerViewDataSource

//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.pickerType == PickerTypeCity) {
        return 2;
    }
    else if (self.pickerType == PickerTypeDistrict) {
        return 3;
    }
    return 3;
}

//每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (component == 0) {
        return self.provinceArray.count;
    }
    else if (component == 1) {
        return self.cityArray.count;
    }
    else if (component == 2) {
        return self.districtArray.count;
    }
    
    return 0;
}

#pragma mark ------ UIPickerViewDelegate

//每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (self.pickerType == PickerTypeCity) {
        return pickerView.bounds.size.width/2;
    }
    else if (self.pickerType == PickerTypeDistrict) {
        return pickerView.bounds.size.width/3;
    }
    return pickerView.bounds.size.width/3;
}

//选中时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    //刷新数组并刷新选择器
    if (component == 0) {
        
        self.cityArray = [self analysisCitysData:self.provinceArray withIndex:row];
        [self reloadComponent:1];
        [self selectRow:0 inComponent:1 animated:YES];
        
        if (self.pickerType == PickerTypeDistrict) {
            self.districtArray = [self analysisCitysData:self.cityArray withIndex:0];
            [self reloadComponent:2];
            [self selectRow:0 inComponent:2 animated:YES];
        }
        
        self.secondName = @"";
        self.thirdName = @"";
        //第一列选中标题
        NSString *titleStr = [self acquireStrWithArray:self.provinceArray Index:row];
        if ([titleStr isEqualToString:@"请选择"]) {
            titleStr = @"";
        }
        self.firstName = titleStr;
        
    }
    else if (component == 1) {
        
        if (self.pickerType == PickerTypeDistrict) {
            self.districtArray = [self analysisCitysData:self.cityArray withIndex:row];
            [self reloadComponent:2];
            [self selectRow:0 inComponent:2 animated:YES];
        }
        
        self.thirdName = @"";
        //第二列选中标题
        NSString *titleStr = [self acquireStrWithArray:self.cityArray Index:row];
        if ([titleStr isEqualToString:@"请选择"]) {
            titleStr = @"";
        }
        self.secondName = titleStr;
        
    }
    else if (component == 2) {
        
        //第三例选中标题
        NSString *titleStr = [self acquireStrWithArray:self.districtArray Index:row];
        if ([titleStr isEqualToString:@"请选择"]) {
            titleStr = @"";
        }
        self.thirdName = titleStr;
        
    }
    
}

//返回当前行的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return [self acquireStrWithArray:self.provinceArray Index:row];
        
    }
    else if (component == 1) {
        
        return [self acquireStrWithArray:self.cityArray Index:row];
        
    }else if (component == 2){
        
        return [self acquireStrWithArray:self.districtArray Index:row];
        
    }
    
    return nil;
}



@end
