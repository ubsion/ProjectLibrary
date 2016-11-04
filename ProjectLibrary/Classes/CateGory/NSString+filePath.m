//
//  NSString+filePath.m
//  NewsApp
//
//  Created by xuyong on 16/1/9.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "NSString+filePath.h"
#import "MacroDefinition.h"

@implementation NSString (filePath)
-(NSString *)documentFullPath{
    
    if ([self hasPrefix:@"http"]) {
        return self;
    }
    
    return [NSString stringWithFormat:@"%@%@",FILE_URL,self];
}

- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}
@end
