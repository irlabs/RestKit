//
//  LCLDDLog_RK.h
//
//  Created by Dirk van Oosterbosch on 16-05-13.
//  Copyright (c) 2013 Dirk van Oosterbosch - Peerby. All rights reserved.
//
//

// ARC/non-ARC autorelease pool
#define _RKlcl_logger_autoreleasepool_arc 0
#if defined(__has_feature)
#   if __has_feature(objc_arc)
#   undef  _RKlcl_logger_autoreleasepool_arc
#   define _RKlcl_logger_autoreleasepool_arc 1
#   endif
#endif
#if _RKlcl_logger_autoreleasepool_arc
#define _RKlcl_logger_autoreleasepool_begin                                      \
    @autoreleasepool {
#define _RKlcl_logger_autoreleasepool_end                                        \
    }
#else
#define _RKlcl_logger_autoreleasepool_begin                                      \
    NSAutoreleasePool *_RKlcl_logger_autoreleasepool = [[NSAutoreleasePool alloc] init];
#define _RKlcl_logger_autoreleasepool_end                                        \
    [_RKlcl_logger_autoreleasepool release];
#endif

// Define the _RKlcl_logger macro which integrates LCLNSLogger as a logging
// back-end for LibComponentLogging.

#if 0
#define _RKlcl_logger(_component, _level, _format, ...) {                      \
_RKlcl_logger_autoreleasepool_begin                                        \
[LCLDDLog_RK logWithComponent:_component                                   \
level:_level                                       \
path:@__FILE__                                     \
line:__LINE__                                     \
format:_format,                                     \
## __VA_ARGS__];                                \
_RKlcl_logger_autoreleasepool_end                                          \
}
#else
#define _RKlcl_logger(_component, _level, _format, ...) {                      \
_RKlcl_logger_autoreleasepool_begin                                        \
[LCLDDLog_RK logWithComponent:_component                                   \
level:_level                                       \
path:@__FILE__                                     \
line:__LINE__                                     \
format:_format,                                     \
## __VA_ARGS__];                                \
_RKlcl_logger_autoreleasepool_end                                          \
}
#endif



#import <Foundation/Foundation.h>
#import "lcl_RK.h"
#import "DDLog.h"

@interface LCLDDLog_RK : NSObject {
	
}

// Passes the given log message to the designated DDLog macro.
+ (void)logWithComponent:(_RKlcl_component_t)component
				   level:(uint32_t)level
                    path:(NSString *)path
					line:(uint32_t)line
                  format:(NSString *)format, ... __attribute__((format(__NSString__, 5, 6)));

@end