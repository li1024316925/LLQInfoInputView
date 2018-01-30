//
//  LLQToolBar.m
//  Picker
//
//  Created by LLQ on 2018/1/18.
//  Copyright © 2018年 LLQ. All rights reserved.
//

#import "LLQToolBar.h"

#define LLQBarTitleTintColor [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]
#define LLQBarItemTintColor [UIColor blackColor]

@interface LLQToolBar ()

@property (nonatomic, strong) UIBarButtonItem *titleBtn;
@property (nonatomic, strong) UIBarButtonItem *doneBtn;
@property (nonatomic, strong) UIBarButtonItem *nextBtn;
@property (nonatomic, strong) UIBarButtonItem *previousBtn;

@end

@implementation LLQToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *space2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        NSArray * buttonsArray = [NSArray arrayWithObjects:self.previousBtn,self.nextBtn,space,self.titleBtn,space2,self.doneBtn,nil];
        [self setItems:buttonsArray];
    }
    return self;
}

- (void)setPlaceholderTitle:(NSString *)placeholderTitle {
    _placeholderTitle = placeholderTitle;
    self.titleBtn.title = _placeholderTitle;
}

- (UIBarButtonItem *)titleBtn {
    if (!_titleBtn) {
        _titleBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        _titleBtn.tintColor = LLQBarTitleTintColor;
    }
    return _titleBtn;
}

- (UIBarButtonItem *)doneBtn {
    if (!_doneBtn) {
        _doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonAction:)];
        _doneBtn.tintColor = LLQBarItemTintColor;
    }
    return _doneBtn;
}

- (UIBarButtonItem *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button_bar_arrowDown"] style:UIBarButtonItemStylePlain target:self action:@selector(nextButtonAction:)];
        _nextBtn.tintColor = LLQBarItemTintColor;
    }
    return _nextBtn;
}

- (UIBarButtonItem *)previousBtn {
    if (!_previousBtn) {
        _previousBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button_bar_arrowUp"] style:UIBarButtonItemStylePlain target:self action:@selector(previousButtonAction:)];
        _previousBtn.tintColor = LLQBarItemTintColor;
    }
    return _previousBtn;
}

- (void)doneButtonAction:(UIBarButtonItem *)sender {
    if (self.toolBarDelegate) {
        if ([self.toolBarDelegate respondsToSelector:@selector(selectedDoneButton:)]) {
            [self.toolBarDelegate selectedDoneButton:sender];
        }
    }
}

- (void)nextButtonAction:(UIBarButtonItem *)sender {
    if (self.toolBarDelegate) {
        if ([self.toolBarDelegate respondsToSelector:@selector(selectedArrowButton:isNext:)]) {
            [self.toolBarDelegate selectedArrowButton:sender isNext:YES];
        }
    }
}

- (void)previousButtonAction:(UIBarButtonItem *)sender {
    if (self.toolBarDelegate) {
        if ([self.toolBarDelegate respondsToSelector:@selector(selectedArrowButton:isNext:)]) {
            [self.toolBarDelegate selectedArrowButton:sender isNext:NO];
        }
    }
}

@end
