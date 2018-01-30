//
//  LLQToolBar.h
//  Picker
//
//  Created by LLQ on 2018/1/18.
//  Copyright © 2018年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLQToolBarDelegate <NSObject>

@optional

- (void)selectedDoneButton:(UIBarButtonItem *)doneBtn;

- (void)selectedArrowButton:(UIBarButtonItem *)control isNext:(BOOL)isNext;

@end

@interface LLQToolBar : UIToolbar

@property (nonatomic, copy) NSString *placeholderTitle;

@property (nonatomic, assign) id<LLQToolBarDelegate> toolBarDelegate;

@end
