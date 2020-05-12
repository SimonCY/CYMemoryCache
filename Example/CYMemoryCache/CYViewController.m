//
//  CYViewController.m
//  CYCache
//
//  Created by iweekly on 05/13/2020.
//  Copyright (c) 2020 iweekly. All rights reserved.
//

#import "CYViewController.h"
#import <CYMemoryCache.h>
#import "CYElement.h"

@interface CYViewController ()

@property (nonatomic, strong) CYMemoryCache *cache;

@end

@implementation CYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cache = [[CYMemoryCache alloc] initWithCapacity:5];
	
    
    for (int i = 0; i < 8; i++) {
        
        CYElement *el = [CYElement new];
        el.name = [NSString stringWithFormat:@"element%d", i];
        [self.cache setItem:el forKey:el.name withCost:1];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    static int i = 7;
    i++;
    
    CYElement *el = [CYElement new];
    el.name = [NSString stringWithFormat:@"element%d", i];
    [self.cache setItem:el forKey:[NSString stringWithFormat:@"element%d",i] withCost:1];
}

@end
