//
//  ASIconSize.h
//  IconTool
//
//  Created by 孙泉 on 2019/2/13.
//  Copyright © 2019 asunquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASIconSize : NSObject

+ (NSArray<NSDictionary *> *)iOSIconSizes;

+ (NSArray<NSDictionary *> *)macOSIconSizes;

+ (NSArray<NSDictionary *> *)watchOSIconSizes;

+ (NSArray<NSDictionary *> *)messageIconSizes;

@end
