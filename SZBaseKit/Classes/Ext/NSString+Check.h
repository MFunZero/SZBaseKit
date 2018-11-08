//
//  NSString+Check.h
//  MaiTalk
//
//  Created by Joy on 15/4/17.
//  Copyright (c) 2015年 duomai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)
-(BOOL)checkPhoneNumAvailuable;
-(BOOL)isPureInt;
-(BOOL)checkPasswordAvailable;
-(NSArray*)matchingString:(NSString * )tagetStr keyStr:(NSString *)keyStr;

-(BOOL)isContainUrl;

//解析字符串内部的url 返回的是包含NSRange的数组
-(NSArray *)getRangesForURLs;
- (NSArray *)resultWithPattern:(NSString *)pattern;
// 根据range取出string
- (NSString *)stringInRange:(NSRange)range;
//md5加密
-(NSString*)mtkMD5HexDigest;
/**是否是数字*/
- (BOOL)isNum;
/**是否是钱*/
- (BOOL)isMoney;
/**是否是有效地身份证号*/
- (BOOL)isIDCardNO;
/**是否是手机号*/
- (BOOL)isPhoneNum;
/**是否是银行卡号*/
- (BOOL)isBankCardNo;
+ (BOOL)isBlank:(NSString *)str;
+ (BOOL)isNotBlank:(NSString *)str;

- (BOOL)wordAndNumerCheck;
@end
