//
//  LLQInputManager.m
//  Picker
//
//  Created by LLQ on 2018/1/24.
//  Copyright © 2018年 LLQ. All rights reserved.
//

#import "LLQToolBarManager.h"

@implementation LLQToolBarManager

+ (LLQToolBarManager *)shareManager {
    static LLQToolBarManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LLQToolBarManager alloc] init];
    });
    return manager;
}

- (NSMutableArray *)inputviews {
    if (!_inputviews) {
        _inputviews = [[NSMutableArray alloc] init];
    }
    return _inputviews;
}

#pragma mark ------ LLQToolBarDelegate

- (void)selectedDoneButton:(UIBarButtonItem *)doneBtn {
    for (UIView *textFiled in self.inputviews) {
        if ([textFiled isFirstResponder]) {
            [textFiled resignFirstResponder];
        }
    }
}

- (void)selectedArrowButton:(UIBarButtonItem *)control isNext:(BOOL)isNext {
    if (isNext) {
        NSInteger index = self.fristResponderIndex + 1;
        if (self.inputviews.count > index) {
            UIView *textFiled = self.inputviews[index];
            [textFiled becomeFirstResponder];
        }
    }
    else {
        NSInteger index = self.fristResponderIndex - 1;
        if (self.inputviews.count > index) {
            UIView *textFiled = self.inputviews[index];
            [textFiled becomeFirstResponder];
        }
    }
}

@end
