//
//  Single.h
//  单例模式通用宏
//
//  Created by nave on 14/6/6.
//  Copyright © 2013年
//


#define SingleH(name) +(instancetype)shared##name 

#if __has_feature(objc_arc)
// arc
#define SingleM(name) static id _tool;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _tool = [super allocWithZone:zone];\
    });\
    return _tool;\
}\
\
\
+ (instancetype)shared##name {\
    return [[self alloc] init];\
}\
\
- (id)copyWithZone:(NSZone *)zone {\
    return _tool;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone {\
    return _tool;\
}

#else
// mrc
#define SingleM(name) static id _tool;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_tool = [super allocWithZone:zone];\
});\
return _tool;\
}\
+ (instancetype)shared##name {\
return [[self alloc] init];\
}\
- (oneway void)release {\
}\
-(instancetype)retain\
{\
return _instance;\
}\
-(NSUInteger)retainCount\
{\
    return MAXFLOAT;\
}

#endif
