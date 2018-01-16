//
//  ResponsabilityChainList.h
//  ChainDemo
//
//  Created by chengyulong on 2018/1/4.
//  Copyright © 2018年 chengyulong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Space @"space"

@interface ResponsabilityChain : NSObject

/**
 *  责任链中的对象
 *
 *  @param target 责任链对象的指向
 *  @param selector 责任链对象的对应方法
 */
+ (nonnull instancetype)instanceChain:(nonnull id)target selector:(nonnull SEL)selector;

/**
 *  责任链对象添加本责任链对象对应的枚举数组
 *
 *  @param enumNums 由各个维度的枚举num数组结合组成的二维数组
 */
- (void)addEnumStringArray:(nonnull NSArray<NSArray<NSNumber *> *> *)enumNums;

@end

@interface ResponsabilityChainList : NSObject

/**
 *  责任链对象的类方法，生成责任链对象
 *
 *  @param responsabilityChain 责任链对象组成的数组
 *  @param defaultTarget    默认指向
 *  @param defaultSelector 当判断条件不适用于责任链对象数组中任何一个对象的方法时，将执行默认的方法
 */
+ (nonnull instancetype)instanceResponsabilityChain:(nonnull NSArray<ResponsabilityChain *> *)responsabilityChain
                                      defaultTarget:(nonnull id)defaultTarget
                                    defaultSelector:(nonnull SEL)defaultSelector;

/**
 *  用于执行判断条件
 *
 *  @param condition 用于责任链判断执行的条件数组
 */
- (nullable id)implementationMethodByConditionArray:(nonnull NSArray<NSNumber *> *)condition;

@end
