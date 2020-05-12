//
//  CYElement.m
//  CYCache_Example
//
//  Created by chenyan on 2020/5/13.
//  Copyright © 2020 iweekly. All rights reserved.
//

#import "CYElement.h"

@implementation CYElement

- (void)dealloc {
    
    NSLog(@"释放了：%@", self.name);
}

@end
