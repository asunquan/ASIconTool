//
//  NSImage+ASScale.m
//  IconTool
//
//  Created by 孙泉 on 2019/2/13.
//  Copyright © 2019 asunquan. All rights reserved.
//

#import "NSImage+ASScale.h"

@implementation NSImage (ASScale)

- (NSImage *)as_scale:(CGSize)size
{
    if (size.width <= 0 || size.height <= 0) {
        return nil;
    }
    
    if (size.width == self.size.width && size.height == self.size.height) {
        return self;
    }
    
    if (self.isValid) {
        NSRect fromRect = NSMakeRect(0, 0, self.size.width, self.size.height);
        NSRect rect = NSMakeRect(0, 0, size.width, size.height);
        NSImage *newImage = [[NSImage alloc] initWithSize:size];
        
        [newImage lockFocus];
        
        [self drawInRect:rect
                fromRect:fromRect
               operation:NSCompositingOperationCopy
                fraction:1.0];
        
        [newImage unlockFocus];
        
        return newImage;
    }
    
    return nil;
}

@end
