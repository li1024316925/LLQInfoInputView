//
//  PickerUITests.m
//  PickerUITests
//
//  Created by LLQ on 2017/3/8.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface PickerUITests : XCTestCase

@end

@implementation PickerUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    
    
}

- (void)inputviewsFromView:(UIView *)view complete:(void(^)(NSArray *))complete {
    dispatch_async(dispatch_get_main_queue(), ^{
        __block NSMutableArray *array = [[NSMutableArray alloc] init];
        if (([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]]) && [view canBecomeFirstResponder]) {
            [array addObject:view];
            if (complete) {
                complete(array);
            }
        }
        else if (view.subviews.count > 0) {
            NSArray *subviews = view.subviews;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                for (UIView *subview in subviews) {
                    [self inputviewsFromView:subview complete:^(NSArray *inputs) {
                        [array addObjectsFromArray:inputs];
                        if (complete) {
                            complete(array);
                        }
                    }];
                }
            });
        }
    });
}

- (NSArray *)test_inputviewsFromView:(UIView *)view {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]]) && [view canBecomeFirstResponder]) {
        [array addObject:view];
    }
    else if (view.subviews.count > 0) {
        NSArray *subviews = view.subviews;
        for (UIView *subview in subviews) {
            [array addObjectsFromArray:[self test_inputviewsFromView:subview]];
        }
    }
    return array;
}

@end
