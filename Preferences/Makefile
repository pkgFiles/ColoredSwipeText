TARGET := iphone:clang:latest:13.7

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ColoredSwipeTextPrefs

ColoredSwipeTextPrefs_FILES = $(shell find Sources/ColoredSwipeTextPrefs -name '*.swift') $(shell find Sources/ColoredSwipeTextPrefsC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
ColoredSwipeTextPrefs_SWIFTFLAGS = -ISources/ColoredSwipeTextPrefsC/include
ColoredSwipeTextPrefs_INSTALL_PATH = /Library/PreferenceBundles
ColoredSwipeTextPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
