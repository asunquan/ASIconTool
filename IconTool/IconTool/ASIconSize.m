//
//  ASIconSize.m
//  IconTool
//
//  Created by 孙泉 on 2019/2/13.
//  Copyright © 2019 asunquan. All rights reserved.
//

#import "ASIconSize.h"

@implementation ASIconSize

+ (NSArray<NSDictionary *> *)iOSIconSizes
{
    return @[@{@"icon_20@1x.png" : @"20*20"},
             @{@"icon_20@2x.png" : @"40*40"},
             @{@"icon_20@3x.png" : @"60*60"},
             @{@"icon_29@1x.png" : @"29*29"},
             @{@"icon_29@2x.png" : @"58*58"},
             @{@"icon_29@3x.png" : @"87*87"},
             @{@"icon_40@1x.png" : @"40*40"},
             @{@"icon_40@2x.png" : @"80*80"},
             @{@"icon_40@3x.png" : @"120*120"},
             @{@"icon_60@2x.png" : @"120*120"},
             @{@"icon_60@3x.png" : @"180*180"},
             @{@"icon_76@1x.png" : @"76*76"},
             @{@"icon_76@2x.png" : @"152*152"},
             @{@"icon_83.5@2x.png" : @"167*167"},
             @{@"icon_1024@1x.png" : @"1024*1024"}];
}

+ (NSArray<NSDictionary *> *)macOSIconSizes
{
    return @[@{@"icon_16@1x.png" : @"16*16"},
             @{@"icon_16@2x.png" : @"32*32"},
             @{@"icon_32@1x.png" : @"32*32"},
             @{@"icon_32@2x.png" : @"64*64"},
             @{@"icon_128@1x.png" : @"128*128"},
             @{@"icon_128@2x.png" : @"256*256"},
             @{@"icon_256@1x.png" : @"256*256"},
             @{@"icon_256@2x.png" : @"512*512"},
             @{@"icon_512@1x.png" : @"512*512"},
             @{@"icon_512@2x.png" : @"1024*1024"}];
}

+ (NSArray<NSDictionary *> *)watchOSIconSizes
{
    return @[@{@"icon_24@2x.png" : @"48*48"},
             @{@"icon_27.5@2x.png" : @"55*55"},
             @{@"icon_29@2x.png" : @"58*58"},
             @{@"icon_29@3x.png" : @"87*87"},
             @{@"icon_40@2x.png" : @"80*80"},
             @{@"icon_44@2x.png" : @"88*88"},
             @{@"icon_86@2x.png" : @"172*172"},
             @{@"icon_98@2x.png" : @"196*196"},
             @{@"icon_1024@1x.png" : @"1024*1024"}];
}

+ (NSArray<NSDictionary *> *)messageIconSizes
{
    return @[@{@"icon_29@2x.png" : @"58*58"},
             @{@"icon_29@3x.png" : @"87*87"},
             @{@"icon_60*45@2x.png" : @"120*90"},
             @{@"icon_60*45@3x.png" : @"180*135"},
             @{@"icon_67*50@2x.png" : @"134*100"},
             @{@"icon_74*55@2x.png" : @"148*110"},
             @{@"icon_1024@1x.png" : @"1024*1024"},
             @{@"icon_1024*768@1x.png" : @"1024*768"},
             @{@"icon_27*20@2x.png" : @"54*40"},
             @{@"icon_27*20@3x.png" : @"81*60"},
             @{@"icon_32*24@2x.png" : @"64*48"},
             @{@"icon_32*24@3x.png" : @"96*72"}];
}

@end
