//
//  NSString+Check.m
//  MaiTalk
//
//  Created by Joy on 15/4/17.
//  Copyright (c) 2015年 duomai. All rights reserved.
//

#import "NSString+Check.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Check)

-(BOOL)checkPhoneNumAvailuable {
    if (self.length == 11 && [self hasPrefix:@"1"]) {
        return YES;
    }
    return NO;
}

- (BOOL)isPureInt {
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

-(BOOL)checkPasswordAvailable{
    if (self.length>=6 && self.length<=20) {
        return YES;
    }
    return NO;
}

- (NSArray*)matchingString:(NSString * )targetStr keyStr:(NSString *)keyStr{
    
    targetStr = [targetStr uppercaseString];
    
    keyStr = [keyStr uppercaseString];
    
//    const char * allStr = [tagetStr UTF8String];
    
    NSUInteger len = targetStr.length;
    
//    const char * keyWords = [keyStr UTF8String];
    
//    NSUInteger length = strlen(keyWords);
    NSUInteger length = keyStr.length;
    
    NSMutableArray * mArrLocation = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (NSUInteger i = 0; i <= len - length; i++)
    {
        BOOL isEqual = YES;
        
        for (NSUInteger j = 0; j < length; j++) {
            
            NSString *targetLocationStr = [targetStr substringWithRange:NSMakeRange(i + j, 1)];
            
            NSString * keytLocationStr = [keyStr substringWithRange:NSMakeRange(j, 1)];
            
            if ([targetLocationStr isEqualToString:keytLocationStr]) {
//                NSLog(@"匹配上了%lu",(unsigned long)j + i);
            }else{
                isEqual = NO;
                break;
            }
            
        }
        
        if (isEqual) {
            [mArrLocation addObject:[NSNumber numberWithUnsignedInteger:i]];
            i = i + length - 1;
        }
    }
    
    NSArray * keyLocationArr = [NSArray arrayWithArray:mArrLocation];
    
    return keyLocationArr;
}

- (BOOL)isContainUrl
{
//    NSString *urlPattern = @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
//    return [self resultWithPattern:urlPattern].count >= 1;
    return self.getRangesForURLs.count > 0;
}

- (NSString *)stringInRange:(NSRange)range {
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i = range.location ; i < range.length + range.location;i ++) {
        int c = [self characterAtIndex:i];
        NSString *cString = [NSString stringWithFormat:@"%C",(unichar)c];
        [str appendString:cString];
    }
    return str;
}

- (NSArray *)resultWithPattern:(NSString *)pattern {
    if (pattern == nil) {
        return nil;
    }
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray *array =  [regular matchesInString:self options:0 range:NSMakeRange(0,self.length)];
    NSMutableArray *rangeArr = [NSMutableArray array];
    for (NSTextCheckingResult *result in array) {
        [rangeArr addObject:[NSValue valueWithRange:result.range]];
    }
    return rangeArr;
}

-(NSArray *)getRangesForURLs {
    NSMutableArray *rangesForURLs = [[NSMutableArray alloc] init];
    NSError *error = nil;
    NSDataDetector *detector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:&error];

    NSArray *matches = [detector matchesInString:self
                                         options:0
                                           range:NSMakeRange(0, self.length)];

    for (NSTextCheckingResult *match in matches)
    {
        NSRange matchRange = [match range];

        if (matchRange.location != NSNotFound && [match resultType] == NSTextCheckingTypeLink){
            NSString *str = [self substringWithRange:matchRange];
            if (str.length) {
                [rangesForURLs addObject:[NSValue valueWithRange:matchRange]];
            }
        }
    }
    return rangesForURLs;
}

//MD5加密
-(NSString*)mtkMD5HexDigest {
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}


- (BOOL)isNum {
    NSString *numPattern = @"^[0-9]*$";
    return [self resultWithPattern:numPattern].count;
}

- (BOOL)isMoney {
    NSString *moneyPattern = @"^(([1-9]\\d{0,9})|0)(\\.\\d{1,2})?$";
    return [self resultWithPattern:moneyPattern].count;
}

- (BOOL)isIDCardNO {
    NSString *no15 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    NSString *no19 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    return ([self resultWithPattern:no15].count || [self resultWithPattern:no19].count);
}

- (BOOL)isPhoneNum {
    NSString *phonePattern = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|199|18[0-9]|14[57])[0-9]{8}$";
    return [self resultWithPattern:phonePattern].count;
}

- (BOOL)isBankCardNo {
    // 16位或者19位银行卡号2
    NSString *cardPattern = @"^(\\d{16}|\\d{19}|\\d{17})$";
    return [self resultWithPattern:cardPattern].count;
}

- (BOOL)isNotBlank {
    return ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0);
}

+ (BOOL)isNotBlank:(NSString *)str {
    return ![NSString isBlank:str];
}

+ (BOOL)isBlank:(NSString *)str {
    if (str && [str isKindOfClass:[NSString class]] && str.isNotBlank) {
        return NO;
    }
    return YES;
}

- (BOOL)wordAndNumerCheck {
    NSArray *result = [self resultWithPattern:@"^[A-Za-z0-9]+$"];
    return result && result.count > 0;
}
@end
