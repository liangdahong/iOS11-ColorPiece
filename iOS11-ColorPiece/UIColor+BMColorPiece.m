//
//  UIColor+BMColorPiece.m
//  iOS11-ColorPiece
//
//  Created by ___liangdahong on 2017/9/28.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static void bm_ApplyRecordsMatchingTraitCollection(id self, SEL _cmd,  id value) {}
static void bm_colorNamed(id self, SEL _cmd, id value) {}

@implementation UIColor (BMColorPiece)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
        } else {
            // 添加方法
            class_addMethod(objc_getMetaClass("UIColor"), NSSelectorFromString(@"colorNamed:"), (IMP)bm_colorNamed, "v@:@");
            {
                // 创建私有类 _UIColorAttributeTraitStorage
                Class clas = NSClassFromString(@"_UIColorAttributeTraitStorage");
                if (clas) return;
                // 创建类
                clas = objc_allocateClassPair(NSClassFromString(@"_UITraitStorage"), "_UIColorAttributeTraitStorage", 0);
                // 添加方法
                class_addMethod(clas, NSSelectorFromString(@"applyRecordsMatchingTraitCollection:"), (IMP) bm_ApplyRecordsMatchingTraitCollection, "v@:@");
                // 注册类
                objc_registerClassPair(clas);
            }
        }
    });
}

@end
