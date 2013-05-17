//
//  LCLDDLog_RK.m
//
//  Created by Dirk van Oosterbosch on 16-05-13.
//  Copyright (c) 2013 Dirk van Oosterbosch - Peerby. All rights reserved.
//

#import "LCLDDLog_RK.h"

#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
#ifdef ADHOC
static const int ddLogLevel = LOG_LEVEL_INFO;
#else
static const int ddLogLevel = LOG_LEVEL_WARN;
#endif
#endif

@implementation LCLDDLog_RK

+ (void)logWithComponent:(_RKlcl_component_t)component
				   level:(uint32_t)level
                    path:(NSString *)path
					line:(uint32_t)line
                  format:(NSString *)format, ... {
	
	va_list args;
    va_start(args, format);
	NSString *log_msg = [[NSString alloc] initWithFormat:format arguments:args];
	
	switch (ddLogLevelFromLCLLevel(level)) {
		case 1:
			// Error
			DDLogError(@"%s %s:%@:%d %@",
					  _RKlcl_level_header_1[level],
					  _RKlcl_component_header[component],
					  [path lastPathComponent],
					  line,
					  log_msg);
			break;
		case 2:
			// Warn
			DDLogWarn(@"%s %s:%@:%d %@",
					  _RKlcl_level_header_1[level],
					  _RKlcl_component_header[component],
					  [path lastPathComponent],
					  line,
					  log_msg);
			break;
		case 3:
			// Info
			DDLogInfo(@"%s %s:%@:%d %@",
					  _RKlcl_level_header_1[level],
					  _RKlcl_component_header[component],
					  [path lastPathComponent],
					  line,
					  log_msg);
			break;
		case 4:
			// Verbose
			DDLogVerbose(@"%s %s:%@:%d %@",
					  _RKlcl_level_header_1[level],
					  _RKlcl_component_header[component],
					  [path lastPathComponent],
					  line,
					  log_msg);
			break;
		default:
			break;
	}
	va_end(args);
}


// Configures the Lumberjack log level from the given (LCL) log level.
uint32_t ddLogLevelFromLCLLevel(_RKlcl_level_t level) {
	
	switch (level) {
		case 1:
			// Critcal
			return 1; // Error
			break;
		case 2:
			// Error
			return 1; // Error
			break;
		case 3:
			// Warning
			return 2; // Warn
			break;
		case 4:
			// Info
			return 3; // Info
			break;
		case 5:
			// Debug
			return 4; // Verbose
			break;
		case 6:
			// Trace
			return 4; // Verbose
			break;
		default:
			break;
	}
    return 0;
}

@end
