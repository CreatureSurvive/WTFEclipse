ARCHS = arm64
TARGET = iphone:clang:11.2:latest

GO_EASY_ON_ME = 1
FINALPACKAGE = 1
DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WTFEclipse
$(TWEAK_NAME)_FILES = $(wildcard source/*.m source/*.xm)
$(TWEAK_NAME)_CFLAGS += -fobjc-arc -I$(THEOS_PROJECT_DIR)/source

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 AppStore"
	install.exec "killall -9 Safari"