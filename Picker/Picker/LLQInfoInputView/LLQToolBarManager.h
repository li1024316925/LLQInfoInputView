//
//  LLQToolBarManager.h
//  Picker
//
//  Created by LLQ on 2018/1/24.
//  Copyright © 2018年 LLQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLQToolBar.h"

@interface LLQToolBarManager : NSObject<LLQToolBarDelegate>

@property (nonatomic, strong) NSMutableArray *inputviews;
@property (nonatomic, assign) NSInteger fristResponderIndex;

+ (LLQToolBarManager *)shareManager;

@end
