LOCAL_PATH := $(call my-dir)

SHARED_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/../include/libfastboot
SHARED_CFLAGS := \
	$(KERNELFLINGER_CFLAGS) \
	-DTARGET_BOOTLOADER_BOARD_NAME=\"$(TARGET_BOOTLOADER_BOARD_NAME)\"
SHARED_C_INCLUDES := $(LOCAL_PATH)/../include/libfastboot
SHARED_STATIC_LIBRARIES := \
	$(KERNELFLINGER_STATIC_LIBRARIES) \
	libkernelflinger-$(TARGET_BUILD_VARIANT)
SHARED_SRC_FILES := \
	fastboot.c \
	fastboot_oem.c \
	flash.c \
	sparse.c \
	info.c \
	intel_variables.c \
	bootmgr.c \
	hashes.c \
	bootloader.c

ifneq ($(strip $(TARGET_BOOTLOADER_POLICY)),)
    SHARED_SRC_FILES += authenticated_action.c
endif

include $(CLEAR_VARS)

LOCAL_MODULE := libfastboot-$(TARGET_BUILD_VARIANT)
LOCAL_CFLAGS := $(SHARED_CFLAGS)
LOCAL_STATIC_LIBRARIES := $(SHARED_STATIC_LIBRARIES)
LOCAL_EXPORT_C_INCLUDE_DIRS := $(SHARED_EXPORT_C_INCLUDE_DIRS)
LOCAL_C_INCLUDES := $(SHARED_C_INCLUDES)
LOCAL_SRC_FILES := $(SHARED_SRC_FILES) \
	fastboot_usb.c \
	fastboot_ui.c \

include $(BUILD_EFI_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := libfastboot-for-installer-$(TARGET_BUILD_VARIANT)
LOCAL_CFLAGS := $(SHARED_CFLAGS)
LOCAL_STATIC_LIBRARIES := $(SHARED_STATIC_LIBRARIES)
LOCAL_EXPORT_C_INCLUDE_DIRS := $(SHARED_EXPORT_C_INCLUDE_DIRS)
LOCAL_C_INCLUDES := $(SHARED_C_INCLUDES)
LOCAL_SRC_FILES := $(SHARED_SRC_FILES)

include $(BUILD_EFI_STATIC_LIBRARY)

