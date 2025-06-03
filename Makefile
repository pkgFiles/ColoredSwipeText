TARGET := iphone:clang:latest:13.7
INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ColoredSwipeText

ColoredSwipeText_FILES = $(shell find Sources/ColoredSwipeText -name '*.swift') $(shell find Sources/ColoredSwipeTextC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
ColoredSwipeText_SWIFTFLAGS = -ISources/ColoredSwipeTextC/include
ColoredSwipeText_CFLAGS = -fobjc-arc -ISources/ColoredSwipeTextC/include
ColoredSwipeText_PRIVATE_FRAMEWORKS = SpringBoardUIServices CoverSheet

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += Preferences
include $(THEOS_MAKE_PATH)/aggregate.mk
