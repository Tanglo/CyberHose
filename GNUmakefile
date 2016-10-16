#
# CyberHose GNUMakefile
#
# Created by: Lee Walsh on 17/07/2016.
# Copyright (c) 2016 Lee David Walsh. All rights reserved.
# This software is licensed under The MIT License (MIT)
# See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
#

GNUSTEP_MAKEFILES = /usr/share/GNUstep/Makefiles

#Include the common Makefile variables
include $(GNUSTEP_MAKEFILES)/common.make

TOOL_NAME = cyberhosed
#APP_NAME = cyberhosed

cyberhosed_OBJC_FILES = CHMain.m CHGPIO.m CHSettings.m CHSchedule.m CHScheduleLine.m CHTime.m CHStartDaemon.m

-include GNUmakefile.preamble

#Include the rules for making obj-c
include $(GNUSTEP_MAKEFILES)/tool.make
#include $(GNUSTEP_MAKEFILES)/application.make

# -include GNUmakefile.postamble
